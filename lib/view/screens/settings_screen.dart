import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../controllers/authentication/authentication_controller.dart';
import '../../controllers/settings.controller.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatefulWidget {
  final SettingsController _settingsController = Get.find();
  late String namePlayer;
  late String password;
  late int hourPrice;
  late String currency;
  late bool isAdmin;
  late RxString language = RxString('');

  SettingsScreen({Key? key}) : super(key: key) {
    namePlayer = _settingsController.currentPlayer?.name ?? '';
    password = _settingsController.currentPlayer?.password ?? '';
    hourPrice = _settingsController.priceForHour.value;
    currency = _settingsController.currency.value;
    isAdmin = _settingsController.currentPlayer?.isAdmin ?? false;
    language.value = _settingsController.language.value.languageCode;
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
            title: Text('currentPlayer'.tr),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: Text('namePlayer'.tr),
                leading: const Icon(Icons.sports_tennis),
                value: Text(widget.namePlayer),
                onPressed: (BuildContext context) {
                  Get.dialog(getLogout());
                },
              ),
              SettingsTile.navigation(
                title: Text('password'.tr),
                leading: const Icon(Icons.password),
                value: Text(widget.password),
                onPressed: (BuildContext context) {
                  Get.dialog(getPassword());
                },
              ),
              SettingsTile.navigation(
                title: Text('isAdmin'.tr),
                leading: const Icon(Icons.admin_panel_settings),
                value: Text(widget.isAdmin ? 'true' : 'false'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('common'.tr),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.price_change),
                title: Text('hourPrice'.tr),
                value: Text(widget.hourPrice.toString()),
                onPressed: (BuildContext context) {
                  Get.dialog(getDialogHourPrice());
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.money),
                title: Text('currency'.tr),
                value: Text(widget.currency),
                onPressed: (BuildContext context) {
                  Get.dialog(getDialogCurrency());
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: Text('language'.tr),
                value: Text(widget.language.value),
                onPressed: (BuildContext context) {
                  Get.dialog(getLanguage());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getLanguage() {
    List<String> listLanguage = ['cs', 'en'];
    return AlertDialog(
      title: Text('language'.tr),
      content: DropdownButtonFormField<String>(
        value: widget.language.value,
        items: listLanguage.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            if (value != null) {
              widget.language.value = value;
            }
          });
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget._settingsController.language.value =
                widget._settingsController.getLocale(widget.language.value);
            widget._settingsController.saveData();
            Get.updateLocale(widget._settingsController.language.value);
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('ok'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            widget.language.value =
                widget._settingsController.language.value.languageCode;
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('cancel'.tr),
        ),
      ],
    );
  }

  Widget getPassword() {
    return AlertDialog(
      title: Text('password'.tr),
      content: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.password,
          hintText: 'enterNewPass'.tr,
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
          child: Text('ok'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            widget.password =
                widget._settingsController.currentPlayer?.password ?? '';
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('cancel'.tr),
        ),
      ],
    );
  }

  Widget getLogout() {
    AuthenticationController _authenticationController = Get.find();
    return AlertDialog(
      title: Text('logoutPlayerTitle'.tr),
      content: Text('logoutPlayerMess'.tr),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget._settingsController.currentPlayer = null;
            widget._settingsController.saveData();
            _authenticationController.signOut();
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('ok'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('cancel'.tr),
        ),
      ],
    );
  }

  Widget getDialogCurrency() {
    return AlertDialog(
      title: Text('currency'.tr),
      content: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.currency,
          hintText: 'enterShortCurrency'.tr,
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
          child: Text('ok'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            widget.currency = widget._settingsController.currency.value;
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('cancel'.tr),
        ),
      ],
    );
  }

  Widget getDialogHourPrice() {
    return AlertDialog(
      title: Text('hourPrice'.tr),
      content: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.hourPrice.toString(),
          hintText: 'enterHourPrice'.tr,
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
          child: Text('Ok'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            widget.hourPrice = widget._settingsController.priceForHour.value;
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Text('cancel'.tr),
        ),
      ],
    );
  }
}
