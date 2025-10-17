package com.openlabs.yeolda

import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.plugin.common.EventChannel
import io.flutter.view.FlutterCallbackInformation
import android.content.Context
import android.content.pm.PackageManager
import android.os.Bundle
import org.json.JSONObject

class YeoldaNotificationListener : NotificationListenerService() {
    private val CHANNEL_NAME = "yeolda/notifications"

    companion object {
        private var eventSink: EventChannel.EventSink? = null
        private var instance: YeoldaNotificationListener? = null

        fun setEventSink(sink: EventChannel.EventSink?) {
            eventSink = sink
            println("YeoldaNotificationListener: EventSink 설정됨 - ${sink != null}")
        }

        fun getInstance(): YeoldaNotificationListener? {
            return instance
        }
    }

    override fun onCreate() {
        super.onCreate()
        instance = this
        println("YeoldaNotificationListener: 서비스 시작됨")
    }

    override fun onDestroy() {
        super.onDestroy()
        instance = null
        eventSink = null
        println("YeoldaNotificationListener: 서비스 종료됨")
    }

    override fun onNotificationPosted(sbn: StatusBarNotification?) {
        super.onNotificationPosted(sbn)
        
        println("YeoldaNotificationListener: 알림 수신됨 - ${sbn?.packageName}")
        
        sbn?.let { notification ->
            try {
                // 자기 자신의 알림은 무시
                if (notification.packageName == packageName) {
                    println("YeoldaNotificationListener: 자신의 알림 무시")
                    return
                }

                // Ongoing notification 무시 (옵션)
                if (notification.isOngoing) {
                    println("YeoldaNotificationListener: Ongoing 알림 무시")
                    return
                }

                val extras = notification.notification.extras
                val title = extras.getString("android.title") ?: ""
                val text = extras.getCharSequence("android.text")?.toString() ?: ""
                
                // 빈 알림 무시
                if (title.isEmpty() && text.isEmpty()) {
                    println("YeoldaNotificationListener: 빈 알림 무시")
                    return
                }

                val appLabel = getAppLabel(notification.packageName)
                val category = notification.notification.category
                val channelId = notification.notification.channelId
                val postedAt = notification.postTime

                val data = mapOf(
                    "package" to notification.packageName,
                    "appLabel" to appLabel,
                    "title" to title,
                    "text" to text,
                    "category" to (category ?: ""),
                    "channelId" to (channelId ?: ""),
                    "postedAt" to postedAt
                )

                println("YeoldaNotificationListener: 알림 데이터 전송 시도 - $appLabel: $title")
                println("YeoldaNotificationListener: EventSink null? ${eventSink == null}")
                
                // EventSink로 전송
                eventSink?.success(data)
                println("YeoldaNotificationListener: 알림 데이터 전송 완료")
            } catch (e: Exception) {
                println("YeoldaNotificationListener: 오류 발생 - ${e.message}")
                e.printStackTrace()
            }
        }
    }

    override fun onNotificationRemoved(sbn: StatusBarNotification?) {
        super.onNotificationRemoved(sbn)
        // 필요시 처리
    }

    private fun getAppLabel(packageName: String): String {
        return try {
            val packageManager = applicationContext.packageManager
            val applicationInfo = packageManager.getApplicationInfo(packageName, 0)
            packageManager.getApplicationLabel(applicationInfo).toString()
        } catch (e: PackageManager.NameNotFoundException) {
            packageName
        }
    }
}
