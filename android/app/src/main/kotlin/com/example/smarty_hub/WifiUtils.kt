package com.example.smarty_hub

import android.content.Context
import android.net.wifi.WifiConfiguration
import android.net.wifi.WifiManager

object WifiUtils {
    fun getWifiPassword(context: Context): String? {
        val wifiManager = context.getSystemService(Context.WIFI_SERVICE) as WifiManager
        val configurations: List<WifiConfiguration> = wifiManager.configuredNetworks

        for (config in configurations) {
            if (config.status == WifiConfiguration.Status.CURRENT) {
                return config.preSharedKey?.replace("\"", "") // Return the password
            }
        }
        return null
    }
}