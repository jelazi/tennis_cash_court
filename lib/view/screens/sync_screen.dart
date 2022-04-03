import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../../controllers/settings.controller.dart';

import '../../constants.dart';
import '../../model/database_model.dart';
import '../../controllers/hour_controller.dart';
import '../../model/tennis_hour.dart';
import '../../model/storage_model.dart';

class SyncScreen extends StatefulWidget {
  final DatabaseModel _databaseModel = DatabaseModel();

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  final HourController hourController = Get.find();
  final databaseReference = FirebaseDatabase.instance.ref();
  final SettingsController _settingsController = Get.find();
  final StorageModel _preferencesModel = StorageModel();

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => updateHoursToServerFirebase(),
                  child: Text("Update hours to server"),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => updatePlayersToServerFirebase(),
                  child: Text("Update players to server"),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => updateHoursFromServerFirebase(),
                  child: Text("Update hours from server"),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => updatePlayersFromServerFirebase(),
                  child: Text("Update players from server"),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => viewHoursFirebase(),
                  child: Text("View Data Firebase"),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => deleteDataFirebase(),
                  child: Text("Delete data Firabese"),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => getData(),
                  child: Text("get data"),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => saveData(),
                  child: Text("save data"),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => deleteData(),
                  child: Text("delete data"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
