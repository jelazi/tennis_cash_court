import 'package:flutter/material.dart';
import 'package:tennis_cash_court/model/hour_manager.dart';
import './add_new_hour_dialog.dart';
import '../model/tennis_hour.dart';

class SumCard extends StatefulWidget {
  late HourManager hourManager;

  SumCard() {
    hourManager = HourManager();
  }

  @override
  State<SumCard> createState() => _SumCardState();
}

class _SumCardState extends State<SumCard> {
  TextStyle sumStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      color: Colors.blue.shade50,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Summary hours: ' +
                      widget.hourManager.summaryHours.toString() +
                      ' hours',
                  style: sumStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Summary current: ' +
                      widget.hourManager.summaryCurrent.toString() +
                      ' ' +
                      widget.hourManager.currency,
                  style: sumStyle,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton(
              onPressed: displayAddHour,
              tooltip: 'Add new hour',
              child: const Icon(Icons.sports_tennis),
            ),
          ),
        ],
      ),
    );
  }

  displayAddHour() {
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
