import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class NetworkChecker {
  static final Connectivity _connectivity = Connectivity();
  static StreamSubscription<List<ConnectivityResult>>? _subscription;

  static bool _hasConnection = true;
  static bool get isConnected => _hasConnection;

  static void startListening({bool showToast = true}) {
    _subscription ??= _connectivity.onConnectivityChanged.listen((results) {
      _hasConnection = results.isNotEmpty && !results.contains(ConnectivityResult.none);
      if (!_hasConnection && showToast) {
        Fluttertoast.showToast(
          msg: "Network Error : Please check your connection",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "You're online",
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
        );
      }
    });
  }

  static Future<bool> hasConnection() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  static void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }
}
