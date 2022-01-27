import 'package:flutter/material.dart';

import '../view/sum_card.dart';
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
      body: Stack(
        children: [
          ListViewCardsHours(),
          Positioned(
            bottom: 5,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: SumCard(),
            ),
          ),
        ],
      ),
    );
  }
}
