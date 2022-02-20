import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../model/database_model.dart';
import '../../model/hour_model.dart';
import '../../model/tennis_hour.dart';
import '../../model/preferences_model.dart';

class SyncScreen extends StatefulWidget {
  late DatabaseModel databaseModel;

  SyncScreen() {
    databaseModel = DatabaseModel();
  }

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  final HourController hourController = Get.find();
  final databaseReference = FirebaseDatabase.instance.ref();

  void updateDataToServerFirebase() {
    // widget.databaseModel.setTennisHoursList(hourController.listTennisHours);
  }

  void viewDataFirebase() {
    List<TennisHour> tennisHourList =
        widget.databaseModel.getTennisHourListFromDatabase();
    tennisHourList.map((e) => print(e.toMap())).toList();
  }

  void updateDataFromServerFirebase() {
    print('from server');
    List<TennisHour> tennisHourList =
        widget.databaseModel.getTennisHourListFromDatabase();
    tennisHourList.map((e) => print(e.toMap())).toList();
    hourController.updateDatas(tennisHourList);
  }

  void deleteDataFirebase() {
    widget.databaseModel.deleteAllData();
  }

  void getDataFromPreferences() {
    PreferencesModel preferencesModel = PreferencesModel();
    preferencesModel.getDataFromPreferences();
  }

  void deleteDataPreferences() {
    PreferencesModel preferencesModel = PreferencesModel();
    preferencesModel.deleteDataPreferences();
  }

  void saveDataPreferences() {
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
                child: Text("View Data"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: deleteDataFirebase,
                child: Text("Delete data"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: getDataFromPreferences,
                child: Text("get data from preferences"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: saveDataPreferences,
                child: Text("save data preferences"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: deleteDataPreferences,
                child: Text("deletedata from preferences"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
