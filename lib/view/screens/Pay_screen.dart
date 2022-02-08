import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:tennis_cash_court/model/hour_model.dart';

class PayScreen extends StatefulWidget {
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
    return Consumer<HourModel>(builder: (context, model, _) {
      return Scaffold(
        body: Stack(
          children: [
            model.containsUnpaid()
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
                                    (model.getFirstLastDateUnpaid().isNotEmpty
                                        ? DateFormat('dd. MM. yyyy').format(
                                            model
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
                                    (model.getFirstLastDateUnpaid().isNotEmpty
                                        ? DateFormat('dd. MM. yyyy').format(
                                            model.getFirstLastDateUnpaid().last)
                                        : '') +
                                    '\n',
                                style: sumStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Total hours: ' +
                                    model.summaryHours.toStringAsFixed(1) +
                                    ' hours',
                                style: sumStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Total price: ' +
                                    model.totalPrice.toStringAsFixed(0) +
                                    ' ' +
                                    model.currency,
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
          onPressed: () =>
              Provider.of<HourModel>(context, listen: false).payAll(),
          icon: Icon(Icons.payments),
          label: Text("Payment all hours"),
        ),
      );
    });
  }
}
