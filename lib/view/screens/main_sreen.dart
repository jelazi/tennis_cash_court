import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_cash_court/model/hour_model.dart';
import 'package:tennis_cash_court/model/tennis_hour.dart';

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
  bool isEditable = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<HourModel>(builder: (context, model, _) {
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
                  model.listTennisHourUnpaid,
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
    });
  }

  void deleteHour(TennisHour hour) {
    Provider.of<HourModel>(context, listen: false).deleteHour(hour);
  }

  void editHour(TennisHour hour) {
    print('edit Hour');
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => Provider.of<HourModel>(context, listen: false).loadData());
    setState(() {});
  }
}
