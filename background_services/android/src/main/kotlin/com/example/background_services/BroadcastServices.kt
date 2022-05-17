import android.content.BroadcastReceiver
import android.content.Intent
import android.content.Context
import android.widget.Toast
import com.example.background_services.FunctionType

class BroadcastServices(val callBack: FunctionType) : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent){
        // val isAirplaneModeEnabled = intent?.getBooleanExtra("state",false) ?: return
        // //intent.action == Intent.ACTION_BOOT_COMPLETED
        // if (isAirplaneModeEnabled){
        //     Toast.makeText(context,"Call method background", Toast.LENGTH_LONG).show()
        //     callBack.run();
        //   }
        val isAirplaneModeEnabled = intent?.getBooleanExtra("state", false) ?: return

        if (isAirplaneModeEnabled) {
            Toast.makeText(context, "Airplane Mode Enabled", Toast.LENGTH_LONG).show()
        } else {
            Toast.makeText(context, "Airplane Mode Disabled", Toast.LENGTH_LONG).show()
        }
    }
}