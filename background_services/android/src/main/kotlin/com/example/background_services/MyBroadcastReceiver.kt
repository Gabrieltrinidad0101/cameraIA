import android.content.BroadcastReceiver
import android.content.Intent
import android.content.Context
import android.widget.Toast

class MyBroadcastReceiver: BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent){
        //val isAirplaneModeEnabled = intent?.getBooleanExtra("state",false) ?: return
        Toast.makeText(context,"Airplane Mode enababled", Toast.LENGTH_LONG).show()
    }
}