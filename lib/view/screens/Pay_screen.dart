import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/hour_model.dart';

class PayScreen extends StatefulWidget {
  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final HourController hourController = Get.find();

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
          hourController.listTennisHourUnpaid.isNotEmpty
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
                              'From date: ' +
                                  (hourController
                                          .getFirstLastDateUnpaid()
                                          .isNotEmpty
                                      ? DateFormat('dd. MM. yyyy').format(
                                          hourController
                                              .getFirstLastDateUnpaid()
                                              .first)
                                      : ''),
                              style: sumStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'To date: ' +
                                  (hourController
                                          .getFirstLastDateUnpaid()
                                          .isNotEmpty
                                      ? DateFormat('dd. MM. yyyy').format(
                                          hourController
                                              .getFirstLastDateUnpaid()
                                              .last)
                                      : '') +
                                  '\n',
                              style: sumStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Total hours: ' +
                                  hourController.summaryHours
                                      .toStringAsFixed(1) +
                                  ' hours',
                              style: sumStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Total price: ' +
                                  hourController.totalPrice.toStringAsFixed(0) +
                                  ' ' +
                                  hourController.currency,
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
        onPressed: () => payTennisHour(),
        icon: Icon(Icons.payments),
        label: Text("Payment all hours"),
      ),
    );
  }

  payTennisHour() {
    print('here');
    var sum = hourController.totalPrice.toStringAsFixed(0);
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        hourController.payAll();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Pay tennis hours"),
      content: Text("Do you want pay all hours? Price is $sum."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    print('hie');
  }
}
