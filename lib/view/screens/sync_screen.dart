import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../model/database_model.dart';
import '../../model/hour_controller.dart';
import '../../model/tennis_hour.dart';
import '../../model/storage_model.dart';

class SyncScreen extends StatefulWidget {
  DatabaseModel databaseModel = DatabaseModel();

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  final HourController hourController = Get.find();
  final databaseReference = FirebaseDatabase.instance.ref();

  void updateDataToServerFirebase() {
    widget.databaseModel.setTennisHoursList(hourController.listTennisHourReal);
  }

  void viewDataFirebase() async {
    List<TennisHour> tennisHourList =
        await widget.databaseModel.getTennisHourListFromDatabase();
    tennisHourList.map((e) => print(e.toMap())).toList();
  }

  void updateDataFromServerFirebase() async {
    await widget.databaseModel.getTennisHourListFromDatabase().then((value) {
      hourController.updateDatas(value);
    });
  }

  void deleteDataFirebase() {
    widget.databaseModel.deleteAllData();
  }

  void getData() {
    StorageModel preferencesModel = StorageModel();
    preferencesModel.getDataFromStorage();
  }

  void deleteData() {
    Get.dialog(AlertDialog(
      title: Text("Delete"),
      content: Text("Do you want delete all data"),
      actions: [
        TextButton(
          child: Text("Ok"),
          onPressed: () {
            hourController.listTennisHours.clear();
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
    ));
  }

  void saveData() {
    print('save data to preferences => nothing');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => updateDataToServerFirebase(),
                child: Text("Update data to server"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: updateDataFromServerFirebase,
                child: Text("Update data from server"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => viewDataFirebase(),
                child: Text("View Data Firebase"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: deleteDataFirebase,
                child: Text("Delete data Firabese"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: getData,
                child: Text("get data"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: saveData,
                child: Text("save data"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: deleteData,
                child: Text("delete data"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
