import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/hour_controller.dart';

class PayDialog extends StatelessWidget {
  HourController hourController = Get.find();
  late String sum;
  PayDialog() {
    sum = hourController.totalPrice.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Pay tennis hours"),
      content: Text("Do you want pay all hours? Price is $sum."),
      actions: [
        TextButton(
          child: Text("Ok"),
          onPressed: () {
            hourController.payAll();
            Navigator.of(Get.overlayContext!).pop();
          },
        ),
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(Get.overlayContext!).pop();
          },
        ),
      ],
    );
  }
}
