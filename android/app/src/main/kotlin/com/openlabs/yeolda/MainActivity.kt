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
}
