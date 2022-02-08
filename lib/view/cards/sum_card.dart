import 'package:flutter/material.dart';
import 'package:tennis_cash_court/model/hour_manager.dart';
import '../new_hour/add_new_hour_dialog.dart';
import '../../model/tennis_hour.dart';

class SumCard extends StatefulWidget {
  late HourManager hourManager;
  Function setState;
  bool addVisible;

  SumCard(this.setState, this.addVisible) {
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
                  'Total hours: ' +
                      widget.hourManager.summaryHours.toStringAsFixed(1) +
                      ' hours',
                  style: sumStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total price: ' +
                      widget.hourManager.totalPrice.toStringAsFixed(0) +
                      ' ' +
                      widget.hourManager.currency,
                  style: sumStyle,
                ),
              )
            ],
          ),
          widget.addVisible
              ? Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    onPressed: displayAddHour,
                    tooltip: 'Add new hour',
                    child: const Icon(Icons.add),
                  ),
                )
              : Container(),
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
    widget.setState(() {
      widget.hourManager.addNewHour(tennisHour);
    });
  }
}
