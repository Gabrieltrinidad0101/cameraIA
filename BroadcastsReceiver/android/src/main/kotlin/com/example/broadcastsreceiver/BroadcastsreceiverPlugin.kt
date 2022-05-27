package com.example.broadcastsreceiver

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel.Result
import androidx.annotation.NonNull;
import android.os.Handler
import android.os.Looper
import android.content.Intent
import android.app.Activity
import android.content.Context
import android.content.IntentFilter
import android.widget.Toast

/** BroadcastsreceiverPlugin */
class BroadcastsreceiverPlugin: FlutterPlugin, MethodCallHandler,ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "broadcastsreceiver")
    channel.setMethodCallHandler(this)
    // get context of application
    context = flutterPluginBinding.applicationContext
    Toast.makeText(context ,"123456" , Toast.LENGTH_LONG).show()
    //filter 
    var filter = IntentFilter(Intent.ACTION_BOOT_COMPLETED)
    context.registerReceiver(BroadcastBootCompleted(),filter)

  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "callDartMethod") {
      callDartMethod()
      result.success("ok")
    } else {
      result.notImplemented()
    }
  }

  fun callDartMethod(){
    Handler(Looper.getMainLooper()).postDelayed({
      channel.invokeMethod("run",null)
    },0)
  }

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "background_services")
      channel.setMethodCallHandler(BroadcastsreceiverPlugin())
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }
}
