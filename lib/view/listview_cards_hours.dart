import 'package:flutter/material.dart';
import 'package:tennis_cash_court/model/tennis_hour.dart';
import '../model/hour_manager.dart';

import 'card_hour.dart';

class ListViewCardsHours extends StatefulWidget {
  final void Function(TennisHour tennisHour) deleteHour;
  final void Function(TennisHour tennisHour) editHour;

  List<TennisHour> listTennisHour;
  //Function setStateList;

  ListViewCardsHours(this.listTennisHour, this.deleteHour, this.editHour);

  @override
  State<ListViewCardsHours> createState() => _ListViewCardsHoursState();
}

class _ListViewCardsHoursState extends State<ListViewCardsHours> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5.5),
      itemCount: widget.listTennisHour.length,
      itemBuilder: _itemBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: CardHour(
        widget.listTennisHour[index],
        widget.deleteHour,
        widget.editHour,
      ),
    );
  }
}
