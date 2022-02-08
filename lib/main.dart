import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_cash_court/model/hour_model.dart';
import 'view/navbar/custom_tabs_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'model/preferences_model.dart';

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
    return ChangeNotifierProvider<HourModel>(
      create: (BuildContext context) => HourModel(),
      child: MaterialApp(
        title: 'Tennis cash counter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CustomWidget(context),
      ),
    );
  }
}
