import 'package:flutter/material.dart';
import './view/custom_tabs_widget.dart';

void main() {
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
      home: CustomWidgetExample(context),
    );
  }
}
