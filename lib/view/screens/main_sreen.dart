import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/hour_controller.dart';
import '../../model/tennis_hour.dart';

import '../cards/sum_card.dart';
import '../cards/listview_cards_hours.dart';

class MainScreen extends StatefulWidget {
  late final BuildContext menuScreenContext;
  late final Function onScreenHideButtonPressed;
  late final bool hideStatus;

  MainScreen(
      {Key? key,
      required this.title,
      required this.menuScreenContext,
      required this.hideStatus,
      required this.onScreenHideButtonPressed})
      : super(key: key) {}
  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final HourController hourController = Get.find();
  bool isEditable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 200,
              child: ListViewCardsHours(
                hourController.listTennisHourUnpaid,
                deleteHour,
                editHour,
                isEditable,
              ),
            ),
            Positioned(
              bottom: 5,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: SumCard(setState, isEditable)),
            ),
          ],
        ),
      ),
    );
  }

  void deleteHour(TennisHour hour) {
    hourController.deleteHour(hour);
  }

  void editHour(TennisHour hour) {
    print('edit Hour');
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!
        .addPostFrameCallback((_) => hourController.loadData());
    setState(() {});
  }
}
