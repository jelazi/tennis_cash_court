import 'package:flutter/material.dart';

import '../view/sum_card.dart';
import '../model/tennis_hour.dart';
import '../view/add_new_hour_dialog.dart';
import '../view/listview_cards_hours.dart';
import '../model/hour_manager.dart';

class MainScreen extends StatefulWidget {
  late HourManager hourManager;
  late final BuildContext menuScreenContext;
  late final Function onScreenHideButtonPressed;
  late final bool hideStatus;

  MainScreen(
      {Key? key,
      required this.title,
      required this.menuScreenContext,
      required this.hideStatus,
      required this.onScreenHideButtonPressed})
      : super(key: key) {
    hourManager = HourManager();
  }
  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          ListViewCardsHours(),
          Positioned(
            bottom: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: SumCard(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayAddHour(context),
        tooltip: 'Add new hour',
        child: const Icon(Icons.sports_tennis),
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
