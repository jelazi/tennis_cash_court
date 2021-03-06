// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/authentication/authentication_controller.dart';
import 'controllers/authentication/authentication_service.dart';
import 'controllers/hour_controller.dart';
import 'controllers/settings.controller.dart';
import 'controllers/authentication/authentication_state.dart';
import 'controllers/authentication/login/login_page.dart';
import 'controllers/authentication/splash_screen.dart';
import 'others/languages.dart';
import 'view/navbar/custom_tabs_widget.dart';
import 'package:firebase_core/firebase_core.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDnLQO1FH7xfqHKCOKvgGelBqsEBlW1v6w',
      appId: '1:1083771712062:android:e205d61be88813b8cc576f',
      messagingSenderId: '1083771712062',
      projectId: 'api-project-1083771712062',
    ),
  );
  final SettingsController _settingsController = Get.put(SettingsController());
  await _settingsController.loadData();
  final HourController _hourController = Get.put(HourController());
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController(MyAuthenticationService()));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SettingsController _settingsController = Get.find();

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController = Get.find();
    return GetMaterialApp(
      title: 'nameApp'.tr,
      translations: Languages(),
      locale: _settingsController.language.value,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Obx(() {
        if (authenticationController.state is UnAuthenticated) {
          return const LoginPage();
        }

        if (authenticationController.state is Authenticated) {
          return CustomWidget(context);
        }
        return const SplashScreen();
      }),
    );
  }
}
