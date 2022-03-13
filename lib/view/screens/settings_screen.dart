import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../controllers/settings.controller.dart';

class SettingsScreen extends StatefulWidget {
  SettingsController settingsController = Get.find();
  late String hourPrice;
  late String currency;
  SettingsScreen() {
    hourPrice = settingsController.priceForHour.value.toString();
    currency = settingsController.currency.value;
  }

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.price_change),
                title: Text('Hour price'),
                value: Text(widget.hourPrice),
                onPressed: (BuildContext context) {
                  Get.dialog(getDialogHourPrice());
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.money),
                title: Text('Currency'),
                value: Text(widget.currency),
                onPressed: (BuildContext context) {
                  Get.dialog(getDialogCurrency());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getDialogCurrency() {
    return AlertDialog(
      title: Text('Currency'),
      content: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.currency,
          hintText: 'Enter short currency',
        ),
        keyboardType: TextInputType.text,
        onChanged: (text) {
          setState(() {
            widget.currency = text;
          });
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.settingsController.currency.value = widget.currency;
            widget.settingsController.saveData();
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('Ok'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  Widget getDialogHourPrice() {
    return AlertDialog(
      title: Text('Hour price'),
      content: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.hourPrice,
          hintText: 'Enter new price',
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        keyboardType: TextInputType.number,
        onChanged: (text) {
          setState(() {
            widget.hourPrice = text;
          });
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.settingsController.priceForHour.value =
                int.parse(widget.hourPrice);
            widget.settingsController.saveData();
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('Ok'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
