package com.luissoriano.mathscrib

import android.content.pm.ActivityInfo
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Bloquea físicamente la rotación para que ni siquiera intente girar
        requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
    }
}