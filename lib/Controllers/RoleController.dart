import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/constant.dart';

class RoleController extends GetxController{



  RxString role = "".obs; 

  @override
  void onInit() {
    super.onInit();
    getRole();
  }

  void getRole() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role.value = prefs.getString(ROLE) ?? "";
  }
}
  