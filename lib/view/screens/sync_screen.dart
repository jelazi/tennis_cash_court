import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../../controllers/settings.controller.dart';

import '../../others/constants.dart';
import '../../model/database_model.dart';
import '../../controllers/hour_controller.dart';
import '../../model/tennis_hour.dart';

class SyncScreen extends StatefulWidget {
  final DatabaseModel _databaseModel = DatabaseModel();

  SyncScreen({Key? key}) : super(key: key);

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  final HourController hourController = Get.find();
  final databaseReference = FirebaseDatabase.instance.ref();
  final SettingsController _settingsController = Get.find();

  updateHoursToServerFirebase() {
    List<TennisHour> list = hourController.listTennisHours;
    widget._databaseModel.setTennisHoursList(list);
  }

  viewHoursFirebase() async {
    List<TennisHour> tennisHourList =
        await widget._databaseModel.getTennisHourListFromDatabase();
    tennisHourList.map((e) => logger.d(e.toJson())).toList();
  }

  updateHoursFromServerFirebase() async {
    await widget._databaseModel.getTennisHourListFromDatabase().then((value) {
      hourController.updateDatas(value);
    });
  }

  updatePlayersFromServerFirebase() async {
    await widget._databaseModel
        .getListPLayers()
        .then(((value) => _settingsController.updateListPlayers(value)));
  }

  updatePlayersToServerFirebase() async {
    await widget._databaseModel.setListPlayers(_settingsController.listPlayers);
  }

  deleteDataFirebase() {
    widget._databaseModel.deleteAllData();
  }

  getData() {
    hourController.loadData();
  }

  deleteData() {
    Get.dialog(AlertDialog(
      title: Text('delete'.tr),
      content: Text('questDelete'.tr),
      actions: [
        TextButton(
          child: Text('ok'.tr),
          onPressed: () {
            hourController.listTennisHours.clear();
            Navigator.of(Get.overlayContext!).pop();
          },
        ),
        TextButton(
          child: Text('cancel'.tr),
          onPressed: () {
            Navigator.of(Get.overlayContext!).pop();
          },
        ),
      ],
    ));
  }

  saveData() {
    logger.d('save data');
    hourController.saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _settingsController.currentPlayer!.isAdmin,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => updateHoursToServerFirebase(),
                    child: const Text("Update hours to server"),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => updatePlayersToServerFirebase(),
                    child: const Text("Update players to server"),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => updateHoursFromServerFirebase(),
                    child: const Text("Update hours from server"),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => updatePlayersFromServerFirebase(),
                    child: const Text("Update players from server"),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => viewHoursFirebase(),
                    child: const Text("View Data Firebase"),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => deleteDataFirebase(),
                    child: const Text("Delete data Firabese"),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => getData(),
                    child: const Text("get data"),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => saveData(),
                    child: const Text("save data"),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => deleteData(),
                    child: const Text("delete data"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
