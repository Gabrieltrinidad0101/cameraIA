package com.example.background_services
//import com.example.background_services.Broadcast
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
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

    private lateinit var context: Context
    private lateinit var activity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "background_services")
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.applicationContext
    val receiver = BroadcastServices(object : FunctionType{
      override fun run(){
        callDartMethod()
      }
    })
    var intentFilter = IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION);
    intentFilter.addAction(Intent.ACTION_AIRPLANE_MODE_CHANGED);
    intentFilter.addAction(Intent.ACTION_POWER_CONNECTED);
    intentFilter.addAction(Intent.ACTION_POWER_DISCONNECTED);
    intentFilter.addAction(Intent.ACTION_BOOT_COMPLETED);

    //   override fun onReceive(context: Context?, intent: Intent){
    //       //val isAirplaneModeEnabled = intent?.getBooleanExtra("state",false) ?: return
    //       if (intent.action == Intent.ACTION_BOOT_COMPLETED){
    //         Handler(Looper.getMainLooper()).postDelayed({
    //           Toast.makeText(context,"Call method background", Toast.LENGTH_LONG).show()
    //           channel.invokeMethod("run",null)
    //         },0)
    //       }
    //   }
    // }
    context.registerReceiver(receiver,intentFilter)
  }


  fun callDartMethod(){
    Handler(Looper.getMainLooper()).postDelayed({
      channel.invokeMethod("run",null)
    },0)
  }



  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
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