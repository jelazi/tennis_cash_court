import 'package:flutter/material.dart';
import 'package:tennis_cash_court/model/hour_manager.dart';
import 'package:tennis_cash_court/model/tennis_hour.dart';
import 'package:tennis_cash_court/view/add_new_hour_dialog.dart';
import './view/listview_cards_hours.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tennis cash counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  late HourManager hourManager;
  MyHomePage({Key? key, required this.title}) : super(key: key) {
    hourManager = HourManager();
  }
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListViewCardsHours(),
            Container(
              child: Text('Summary: ' +
                  widget.hourManager.summary.toString() +
                  widget.hourManager.currency),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayAddHour(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  _displayAddHour(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return AddNewHourDialog(
            addNewHour, context, animation, secondaryAnimation);
      },
    );
  }

  void addNewHour(TennisHour tennisHour) {
    setState(() {
      widget.hourManager.listTennisHours.add(tennisHour);
    });
  }
}
