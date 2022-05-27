package com.example.frontend

import android.content.BroadcastReceiver
import android.content.ComponentCallbacks
import android.content.Context
import android.content.Intent
import android.widget.Toast

class BroadcastBootCompleted(val callbacks: FunctionType): BroadcastReceiver() {
    
    override fun onReceive(context: Context?, intent: Intent?) {
        Toast.makeText(context ,"okkkkkkkkkkkkk" , Toast.LENGTH_LONG).show()
        callbacks.run()
    }
}