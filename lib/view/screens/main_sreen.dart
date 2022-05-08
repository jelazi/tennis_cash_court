import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/hour_controller.dart';

import '../cards/card_hour.dart';
import '../cards/sum_card.dart';

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
      : super(key: key);
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
              child: Obx(() => ListView(
                    shrinkWrap: true,
                    children: hourController.listTennisHourUnpaid
                        .map((element) => InkWell(
                              child: CardHour(
                                element,
                                isEditable,
                              ),
                            ))
                        .toList(),
                  )),
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
}
