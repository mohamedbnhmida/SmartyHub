package com.example.smarty_hub
import android.net.wifi.WifiNetworkSpecifier
import android.net.ConnectivityManager
import android.net.NetworkRequest
import android.net.Network
import android.net.NetworkCapabilities
import android.content.Context
import android.os.Build
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.smarty_hub/wifi"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "connectToWifi") {
                val ssid = call.argument<String>("ssid")
                val password = call.argument<String>("password")
                if (ssid != null && password != null) {
                    connectToWifi(ssid, password, result)
                } else {
                    result.error("INVALID_ARGUMENTS", "SSID or password is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

@RequiresApi(Build.VERSION_CODES.Q)
private fun connectToWifi(ssid: String, password: String, result: MethodChannel.Result) {
    val wifiNetworkSpecifier = WifiNetworkSpecifier.Builder()
        .setSsid(ssid)
        .setWpa2Passphrase(password)
        .build()

    val networkRequest = NetworkRequest.Builder()
        .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
        .setNetworkSpecifier(wifiNetworkSpecifier)
        .build()

    val connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

    connectivityManager.requestNetwork(networkRequest, object : ConnectivityManager.NetworkCallback() {
        override fun onAvailable(network: Network) {
            super.onAvailable(network)
            result.success("Connected to $ssid")
            connectivityManager.bindProcessToNetwork(network)
        }

        override fun onUnavailable() {
            super.onUnavailable()
            result.error("UNAVAILABLE", "Connection to $ssid failed", null)
        }

        override fun onCapabilitiesChanged(network: Network, capabilities: NetworkCapabilities) {
            super.onCapabilitiesChanged(network, capabilities)
            if (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI)) {
                // Add any additional checks if needed
            }
        }
    })
}
}