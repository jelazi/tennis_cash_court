import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../constants.dart';
import '../../controllers/settings.controller.dart';

class SettingsScreen extends StatefulWidget {
  final SettingsController _settingsController = Get.find();
  late String namePlayer;
  late String password;
  late int hourPrice;
  late String currency;
  late bool isAdmin;

  SettingsScreen() {
    namePlayer = _settingsController.currentPlayer?.name ?? '';
    password = _settingsController.currentPlayer?.password ?? '';
    hourPrice = _settingsController.priceForHour.value;
    currency = _settingsController.currency.value;
    isAdmin = _settingsController.currentPlayer?.isAdmin ?? false;
  }

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Current player'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: const Text('Name player'),
                leading: const Icon(Icons.sports_tennis),
                value: Text(widget.namePlayer),
                onPressed: (BuildContext context) {
                  Get.dialog(getDialogName());
                },
              ),
              SettingsTile.navigation(
                title: const Text('Password'),
                leading: const Icon(Icons.password),
                value: Text(widget.password),
                onPressed: (BuildContext context) {
                  Get.dialog(getPassword());
                },
              ),
              SettingsTile.navigation(
                title: const Text('Is Admin'),
                leading: const Icon(Icons.admin_panel_settings),
                value: Text(widget.isAdmin ? 'true' : 'false'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.price_change),
                title: const Text('Hour price'),
                value: Text(widget.hourPrice.toString()),
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

  Widget getPassword() {
    return AlertDialog(
      title: const Text('Password'),
      content: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.password,
          hintText: 'Enter new password',
        ),
        keyboardType: TextInputType.text,
        onChanged: (text) {
          setState(() {
            widget.password = text;
          });
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget._settingsController.currentPlayer?.password =
                widget.password;
            widget._settingsController.saveData();
            Navigator.of(Get.overlayContext!).pop();
          },
          child: const Text('Ok'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.password =
                widget._settingsController.currentPlayer?.password ?? '';
            Navigator.of(Get.overlayContext!).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget getDialogName() {
    return AlertDialog(
      title: const Text('Name player'),
      content: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.namePlayer,
          hintText: 'Enter name player',
        ),
        keyboardType: TextInputType.text,
        onChanged: (text) {
          setState(() {
            widget.namePlayer = text;
          });
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget._settingsController.currentPlayer?.name = widget.namePlayer;
            widget._settingsController.saveData();
            Navigator.of(Get.overlayContext!).pop();
          },
          child: const Text('Ok'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.namePlayer =
                widget._settingsController.currentPlayer?.name ?? '';
            Navigator.of(Get.overlayContext!).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget getDialogCurrency() {
    return AlertDialog(
      title: const Text('Currency'),
      content: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
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
            widget._settingsController.currency.value = widget.currency;
            widget._settingsController.saveData();
            Navigator.of(Get.overlayContext!).pop();
          },
          child: const Text('Ok'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.currency = widget._settingsController.currency.value;
            Navigator.of(Get.overlayContext!).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget getDialogHourPrice() {
    return AlertDialog(
      title: const Text('Hour price'),
      content: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.hourPrice.toString(),
          hintText: 'Enter new price',
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        keyboardType: TextInputType.number,
        onChanged: (text) {
          setState(() {
            widget.hourPrice = int.parse(text);
          });
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget._settingsController.priceForHour.value = widget.hourPrice;
            widget._settingsController.saveData();
            Navigator.of(Get.overlayContext!).pop();
          },
          child: const Text('Ok'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.hourPrice = widget._settingsController.priceForHour.value;
            Navigator.of(Get.overlayContext!).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
