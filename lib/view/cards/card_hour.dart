import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tennis_cash_court/controllers/hour_controller.dart';
import '../../model/tennis_hour.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'custom_card.dart';

class CardHour extends StatefulWidget {
  final bool isEditable;
  final TennisHour tennisHour;

  const CardHour(this.tennisHour, this.isEditable, {Key? key})
      : super(key: key);

  @override
  State<CardHour> createState() => _CardHourState();
}

class _CardHourState extends State<CardHour> {
  HourController hourController = Get.find();
  edit(BuildContext context) {}

  delete(BuildContext context) {
    hourController.deleteHour(widget.tennisHour);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEditable) {
      return Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: edit,
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit_rounded,
              label: 'edit'.tr,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              flex: 2,
              onPressed: delete,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'delete'.tr,
            ),
          ],
        ),
        child: CustomCard(widget.tennisHour),
      );
    } else {
      return CustomCard(widget.tennisHour);
    }
  }
}
