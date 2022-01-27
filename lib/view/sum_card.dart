import 'package:flutter/material.dart';
import 'package:tennis_cash_court/model/hour_manager.dart';

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
      child: Column(
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
    );
  }
}
