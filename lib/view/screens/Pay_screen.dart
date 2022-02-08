import 'package:flutter/material.dart';
import 'package:tennis_cash_court/model/hour_manager.dart';
import 'package:intl/intl.dart';

class PayScreen extends StatefulWidget {
  late HourManager hourManager;
  String firstDate = '';
  String lastDate = '';

  PayScreen() {
    hourManager = HourManager();
    firstDate = hourManager.getFirstLastDateUnpaid().isNotEmpty
        ? DateFormat('dd. MM. yyyy')
            .format(hourManager.getFirstLastDateUnpaid().first)
        : '';
    lastDate = hourManager.getFirstLastDateUnpaid().isNotEmpty
        ? DateFormat('dd. MM. yyyy')
            .format(hourManager.getFirstLastDateUnpaid().last)
        : '';
  }

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  TextStyle sumStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.hourManager.containsUnpaid()
              ? Positioned(
                  bottom: 100,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Card(
                      elevation: 15,
                      color: Colors.blue.shade50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'From date: ' + widget.firstDate,
                              style: sumStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'To date: ' + widget.lastDate + '\n',
                              style: sumStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Total hours: ' +
                                  widget.hourManager.summaryHours
                                      .toStringAsFixed(1) +
                                  ' hours',
                              style: sumStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Total price: ' +
                                  widget.hourManager.totalPrice
                                      .toStringAsFixed(0) +
                                  ' ' +
                                  widget.hourManager.currency,
                              style: sumStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
              : Center(child: Text('There is nothing to pay!')),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: payAll,
        icon: Icon(Icons.payments),
        label: Text("Payment all hours"),
      ),
    );
  }

  void payAll() {
    setState(() {
      widget.hourManager.payAll();
    });
  }
}
