import 'package:get/get.dart';

import '../Network/networkmanager.dart';


class GeneralBindings extends Bindings{

  @override
  void dependencies(){
    Get.put(NetworkManager());
  }



}