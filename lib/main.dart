import 'package:flutter/material.dart';
import 'view/navbar/custom_tabs_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './model/share_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tennis cash counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomWidget(context),
    );
  }
}
