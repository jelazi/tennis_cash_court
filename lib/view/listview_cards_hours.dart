import 'package:flutter/material.dart';
import '../model/hour_manager.dart';

import 'card_hour.dart';

class ListViewCardsHours extends StatefulWidget {
  late HourManager hourManager;
  ListViewCardsHours({Key? key}) : super(key: key) {
    hourManager = HourManager();
  }

  @override
  State<ListViewCardsHours> createState() => _ListViewCardsHoursState();
}

class _ListViewCardsHoursState extends State<ListViewCardsHours> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(5.5),
      itemCount: widget.hourManager.listTennisHours.length,
      itemBuilder: _itemBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: CardHour(
        widget.hourManager.listTennisHours[index],
      ),
    );
  }
}
