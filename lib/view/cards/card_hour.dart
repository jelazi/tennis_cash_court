import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tennis_cash_court/controllers/hour_controller.dart';
import '../../others/constants.dart';
import '../../model/tennis_hour.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardHour extends StatefulWidget {
  bool isEditable;

  CardHour(this.tennisHour, this.isEditable);
  TennisHour tennisHour;

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

class CustomCard extends StatelessWidget {
  final TennisHour tennisHour;
  CustomCard(this.tennisHour);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.blue,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat('dd. MM. yyyy').format(tennisHour.date).toString(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'partner'.tr +
                      tennisHour.partnerWithoutCurrentPlayer.join(", "),
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            title: Text(
              tennisHour.hours.toString() + 'hours'.tr,
              style: TextStyle(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
