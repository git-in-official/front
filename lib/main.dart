import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:to_morrow_front/repository/controller/global_controller.dart';
import 'package:to_morrow_front/repository/controller/login_controller.dart';
import 'package:to_morrow_front/repository/controller/maintab_controller.dart';
import 'package:to_morrow_front/ui/screens/splash_page/splash_page.dart';


void main() {
  runApp(const tomorrow());

  Get.put(GlobalController());
  Get.put(LoginController());
  Get.put(MainTabController());
}

class  tomorrow extends StatelessWidget {
  const tomorrow({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "tomorrow",
      debugShowCheckedModeBanner: false,
      home: SplashPage(),

    );

  }
}