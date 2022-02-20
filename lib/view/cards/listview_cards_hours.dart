import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/tennis_hour.dart';
import 'card_hour.dart';

class ListViewCardsHours extends StatefulWidget {
  final void Function(TennisHour tennisHour) deleteHour;
  final void Function(TennisHour tennisHour) editHour;
  bool isEditable;

  RxList<dynamic> listTennisHour = [].obs;
  //Function setStateList;

  ListViewCardsHours(
      this.listTennisHour, this.deleteHour, this.editHour, this.isEditable);

  @override
  State<ListViewCardsHours> createState() => _ListViewCardsHoursState();
}

class _ListViewCardsHoursState extends State<ListViewCardsHours> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.all(5.5),
        itemCount: widget.listTennisHour.length,
        itemBuilder: _itemBuilder,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Obx(
      () => InkWell(
        child: CardHour(
          widget.listTennisHour[index],
          widget.deleteHour,
          widget.editHour,
          widget.isEditable,
        ),
      ),
    );
  }
}
