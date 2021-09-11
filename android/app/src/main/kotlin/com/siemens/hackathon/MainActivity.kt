package com.siemens.hackathon

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL: String = "com.siemens.hackathon/platform_interface"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if(call.method == "bringToForeground"){
                 bringToForeground()
            }
            else {
                result.notImplemented()
            }
        }
    }

    private fun bringToForeground() {
        val intent: Intent = Intent()
        intent.flags = Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT
        context.startActivity(intent)
    }
}