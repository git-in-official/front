import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:to_morrow_front/repository/global_controller.dart';
import 'package:to_morrow_front/repository/login_controller.dart';
import 'package:to_morrow_front/ui/screens/splash_page/splash_page.dart';


void main() {
  runApp(const tomorrow());
  Get.put(GlobalController());
  Get.put(LoginController());
}

class  tomorrow extends StatelessWidget {
  const tomorrow({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "tomorrow",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'KoPubBatangPro',
        iconButtonTheme: IconButtonThemeData(
          style : ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
          )
        )
      ),
      home: SplashPage(),
    );
  }
}
