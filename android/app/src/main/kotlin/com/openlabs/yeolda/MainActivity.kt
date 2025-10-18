package com.openlabs.yeolda

import android.content.Intent
import android.provider.Settings
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class MainActivity : FlutterActivity() {
    private val PERMISSION_CHANNEL = "yeolda/permissions"
    private val NOTIFICATION_CHANNEL = "yeolda/notifications"
    private val APP_LIST_CHANNEL = "yeolda/app_list"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Permission MethodChannel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PERMISSION_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "checkNotificationPermission" -> {
                        val enabled = isNotificationServiceEnabled()
                        result.success(enabled)
                    }
                    "openNotificationSettings" -> {
                        openNotificationSettings()
                        result.success(null)
                    }
                    else -> {
                        result.notImplemented()
                    }
                }
            }

        // App List MethodChannel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, APP_LIST_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getInstalledApps" -> {
                        val apps = getInstalledApps()
                        result.success(apps)
                    }
                    else -> {
                        result.notImplemented()
                    }
                }
            }

        // Notification EventChannel
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, NOTIFICATION_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    YeoldaNotificationListener.setEventSink(events)
                }

                override fun onCancel(arguments: Any?) {
                    YeoldaNotificationListener.setEventSink(null)
                }
            })
    }

    private fun isNotificationServiceEnabled(): Boolean {
        val enabledListeners = NotificationManagerCompat.getEnabledListenerPackages(this)
        return enabledListeners.contains(packageName)
    }

    private fun openNotificationSettings() {
        val intent = Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS)
        startActivity(intent)
    }

    private fun getInstalledApps(): List<Map<String, String>> {
        val pm = packageManager
        val apps = mutableListOf<Map<String, String>>()
        
        val intent = Intent(Intent.ACTION_MAIN, null)
        intent.addCategory(Intent.CATEGORY_LAUNCHER)
        
        val resolveInfoList = pm.queryIntentActivities(intent, 0)
        
        for (resolveInfo in resolveInfoList) {
            val appInfo = resolveInfo.activityInfo.applicationInfo
            val packageName = appInfo.packageName
            val appName = pm.getApplicationLabel(appInfo).toString()
            
            // 시스템 앱 제외 (선택사항)
            apps.add(
                mapOf(
                    "packageName" to packageName,
                    "appLabel" to appName
                )
            )
        }
        
        // 앱 이름으로 정렬
        return apps.sortedBy { it["appLabel"] }
    }
}
