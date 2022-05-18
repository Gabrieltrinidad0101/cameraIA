import android.content.BroadcastReceiver
import android.content.Intent
import android.content.Context
import android.widget.Toast
import com.example.background_services.FunctionType
import android.net.ConnectivityManager
class BroadcastServices(val callBack: FunctionType) : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent){
        // val isAirplaneModeEnabled = intent?.getBooleanExtra("state",false) ?: return
        if (Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())){
            Toast.makeText(context,"run BOOT_COMPLETED", Toast.LENGTH_LONG).show()
            callBack.run();
          }
        if(ConnectivityManager.CONNECTIVITY_ACTION.equals(intent.getAction())){
            Toast.makeText(context,"Connection change", Toast.LENGTH_LONG).show()
            callBack.run()
        }
    }
}