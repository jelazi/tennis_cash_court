import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tennis_cash_court/controllers/authentication/authentication_controller.dart';
import 'package:tennis_cash_court/controllers/authentication/authentication_service.dart';
import 'package:tennis_cash_court/controllers/hour_controller.dart';
import 'package:tennis_cash_court/controllers/player_controller.dart';
import 'package:tennis_cash_court/controllers/settings.controller.dart';
import 'controllers/authentication/authentication_state.dart';
import 'controllers/authentication/login/login_page.dart';
import 'controllers/authentication/splash_screen.dart';
import 'view/navbar/custom_tabs_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'model/storage_model.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SettingsController settingsController = Get.put(SettingsController());
  final HourController hourController = Get.put(HourController());
  final PlayerController playerController = Get.put(PlayerController());
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController(MyAuthenticationService()));

  await hourController.loadData().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController = Get.find();
    return GetMaterialApp(
      title: 'Tennis cash counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Obx(() {
        if (authenticationController.state is UnAuthenticated) {
          return LoginPage();
        }

        if (authenticationController.state is Authenticated) {
          return CustomWidget(context);
        }
        return SplashScreen();
      }),
    );
  }
}
