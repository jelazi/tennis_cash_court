import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tennis_cash_court/model/settings.controller.dart';
import 'package:tennis_cash_court/view/cards/card_hour_short.dart';
import 'package:tennis_cash_court/view/dialogs/%20pay_dialog.dart';
import '../../model/hour_controller.dart';

class PayScreen extends StatefulWidget {
  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final HourController hourController = Get.find();
  final SettingsController settingsController = Get.find();

  TextStyle sumStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Positioned(
              top: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 200,
                child: ListView(
                  shrinkWrap: true,
                  children: hourController.listTennisHourUnpaid
                      .map((element) => InkWell(
                            child: CardHourShort(element),
                          ))
                      .toList(),
                ),
              ),
            ),
            hourController.isListTennisHourUnpaidNotEmpty.value
                ? Positioned(
                    bottom: 0,
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
                                            .firstLastDateUnpaid.isNotEmpty
                                        ? DateFormat('dd. MM. yyyy').format(
                                            hourController
                                                .firstLastDateUnpaid.first)
                                        : ''),
                                style: sumStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'To date: ' +
                                    (hourController
                                            .firstLastDateUnpaid.isNotEmpty
                                        ? DateFormat('dd. MM. yyyy').format(
                                            hourController
                                                .firstLastDateUnpaid.last)
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
                                    hourController.totalPrice
                                        .toStringAsFixed(0) +
                                    ' ' +
                                    settingsController.currency.value,
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
      ),
      floatingActionButton: Obx(
        () => Visibility(
          visible: hourController.isListTennisHourUnpaidNotEmpty.value,
          child: FloatingActionButton.extended(
            onPressed: () => payTennisHour(),
            icon: Icon(Icons.payments),
            label: Text("Payment all hours"),
          ),
        ),
      ),
    );
  }

  payTennisHour() {
    Get.dialog(PayDialog());
  }
}
