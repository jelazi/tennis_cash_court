import 'package:flutter/material.dart';
import 'package:tennis_cash_court/model/tennis_hour.dart';
import 'package:intl/intl.dart';

class CardHour extends StatefulWidget {
  CardHour(this.tennisHour);
  TennisHour tennisHour;

  @override
  State<CardHour> createState() => _CardHourState();
}

class _CardHourState extends State<CardHour> {
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
                  'Partner: ' + widget.tennisHour.partner,
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
    );
  }
}
