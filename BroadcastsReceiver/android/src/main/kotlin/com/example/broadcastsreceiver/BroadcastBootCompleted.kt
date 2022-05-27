package com.example.broadcastsreceiver

import android.content.BroadcastReceiver
import android.content.ComponentCallbacks
import android.content.Context
import android.content.Intent
import android.widget.Toast

class BroadcastBootCompleted(): BroadcastReceiver() {
    
    override fun onReceive(context: Context, intent: Intent?) {
        Toast.makeText(context ,"okkkkkkkkkkkkk" , Toast.LENGTH_LONG).show()
        val i = Intent(context, BroadcastsreceiverPlugin::class.java)
        i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        context.startActivity(i)
    }

}