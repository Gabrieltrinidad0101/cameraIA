package com.example.background_services
import BroadcastServices
import android.content.BroadcastReceiver
import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.os.Handler
import android.os.Looper
import android.content.Intent
import android.content.IntentFilter
import android.widget.Toast
import android.net.ConnectivityManager

public class BackgroundServicesPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel : MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "background_services")
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.applicationContext
    var filter = IntentFilter(Intent.ACTION_BOOT_COMPLETED)
    filter.addAction(ConnectivityManager.CONNECTIVITY_ACTION)
    context.registerReceiver(BroadcastServices(object  : FunctionType{
      override fun run() {
        callDartMethod();
      }
    }),filter)
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
      channel.setMethodCallHandler(BackgroundServicesPlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      callDartMethod()
      result.success("Androd 1")
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