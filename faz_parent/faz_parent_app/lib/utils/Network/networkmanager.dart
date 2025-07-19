import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Loaders/AppLoaders.dart';


class NetworkManager extends GetxController{


  static NetworkManager get instance => Get.find();



  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscrition;
  final Rx<ConnectivityResult> _connectivityStatus = ConnectivityResult.none.obs;

  @override
  void onInit() async{
    super.onInit();
   // _connectivitySubscrition =(await  _connectivity.onConnectivityChanged.listen(_updateConnectionStatus as void Function(List<ConnectivityResult> event)?)) as StreamSubscription<ConnectivityResult> ;
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async{
    _connectivityStatus.value = result;
    if(_connectivityStatus.value == ConnectivityResult.none){
      AppLoaders.warningSnackbar(title:"No Internet Connection");
    }
  }

  Future<bool> isConnected()async{
    try{
      final result = await _connectivity.checkConnectivity();
      if(result == ConnectivityResult.none){
        return false;
      }else {
        return true;
      }
    } on PlatformException catch(_){
      return false;
    }
  }

  @override
  void onClose(){
    super.onClose();
    _connectivitySubscrition.cancel();
  }
}