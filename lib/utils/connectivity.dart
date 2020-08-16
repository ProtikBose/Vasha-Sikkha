import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  //for making request
import 'dart:async';  //for asynchronous features
import 'dart:convert';  //for converting the response to desired format. e.g: JSON
import 'package:connectivity/connectivity.dart';

class ConnectionChecker{

  static ConnectionChecker _instance = new ConnectionChecker.internal();
  ConnectionChecker.internal();
  factory ConnectionChecker() => _instance;

  Future<bool>checkConnection()async
  {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult == ConnectivityResult.mobile)
      { 
          print("Connected to mobile");
          return true;
      }
      else if(connectivityResult == ConnectivityResult.wifi)
      { 
          print("Connected to wifi");
          return true;
      }
      else{
          print("Unable to connect");
          return false;
      }

  }


}
