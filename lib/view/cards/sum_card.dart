import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tennis_cash_court/controllers/settings.controller.dart';
import '../../controllers/hour_controller.dart';
import '../new_hour/add_new_hour_dialog.dart';
import '../../model/tennis_hour.dart';

class SumCard extends StatefulWidget {
  final Function setState;
  final bool addVisible;

  const SumCard(this.setState, this.addVisible, {Key? key}) : super(key: key);

  @override
  State<SumCard> createState() => _SumCardState();
}

class _SumCardState extends State<SumCard> {
  final HourController hourController = Get.find();
  final SettingsController settingsController = Get.find();
  TextStyle sumStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      color: Colors.blue.shade50,
      child: Stack(
        children: [
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'totalHours'.tr +
                        hourController.summaryHours.value.toStringAsFixed(1) +
                        'hours'.tr,
                    style: sumStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'totalPrice'.tr +
                        hourController.totalPrice.value.toStringAsFixed(0) +
                        ' ' +
                        settingsController.currency.value,
                    style: sumStyle,
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: widget.addVisible,
            child: Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                heroTag: widget.addVisible ? 1 : 2,
                onPressed: displayAddHour,
                tooltip: 'addNewHour'.tr,
                child: const Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }

  displayAddHour() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return AddNewHourDialog(
            addNewHour, context, animation, secondaryAnimation);
      },
    );
  }

  void addNewHour(TennisHour tennisHour) {
    tennisHour.partners.add(settingsController.currentPlayer?.name ?? '');
    hourController.addNewHour(tennisHour);
  }
}
