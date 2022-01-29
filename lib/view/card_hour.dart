import 'package:flutter/material.dart';
import 'package:tennis_cash_court/model/tennis_hour.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CardHour extends StatefulWidget {
  final void Function(TennisHour tennisHour) deleteHour;
  final void Function(TennisHour tennisHour) editHour;

  CardHour(this.tennisHour, this.deleteHour, this.editHour);
  TennisHour tennisHour;

  @override
  State<CardHour> createState() => _CardHourState();
}

class _CardHourState extends State<CardHour> {
  void edit(BuildContext context) {
    widget.editHour(widget.tennisHour);
  }

  void delete(BuildContext context) {
    widget.deleteHour(widget.tennisHour);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(0),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: edit,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit_rounded,
            label: 'Edit',
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
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
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
                    DateFormat('dd. MM. yyyy')
                        .format(widget.tennisHour.date)
                        .toString(),
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
                    'Partner: ' + widget.tennisHour.partner.join(", "),
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
                widget.tennisHour.hours.toString() + ' hours',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
