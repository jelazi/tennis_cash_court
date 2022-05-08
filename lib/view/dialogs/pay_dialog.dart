import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/hour_controller.dart';

// ignore: must_be_immutable
class PayDialog extends StatelessWidget {
  final HourController hourController = Get.find();
  String sum = '';
  PayDialog({Key? key}) : super(key: key) {
    sum = hourController.totalPrice.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("payTennisHours".tr),
      content: Text('payTennisQuestion' + sum),
      actions: [
        TextButton(
          child: Text('ok'.tr),
          onPressed: () {
            hourController.payAll();
            Navigator.of(Get.overlayContext!).pop();
          },
        ),
        TextButton(
          child: Text("cancel".tr),
          onPressed: () {},
        ),
      ],
    );
  }
}
