import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tennis_cash_court/model/tennis_hour.dart';
import '../model/hour_manager.dart';

class SyncScreen extends StatefulWidget {
  late HourManager hourManager;

  SyncScreen() {
    hourManager = HourManager();
  }

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  final databaseReference = FirebaseDatabase.instance.ref();

  void createRecord() {
    int index = 0;
    for (TennisHour hour in widget.hourManager.listTennisHours) {
      databaseReference.child('hour' + index.toString()).set(hour.toMap());
      index++;
    }
  }

  void getData() {
    databaseReference.once().then((event) {
      final dataSnapshot = event.snapshot;

      Map<dynamic, dynamic>? map = dataSnapshot.value as Map?;
      List listData = map!.values.toList();
      List<TennisHour> tennisHour = [];
      for (Map mapHour in listData) {
        TennisHour hour = TennisHour.fromMap(mapHour);
        tennisHour.add(hour);
      }
      print(tennisHour.length);
    });
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
                onPressed: () => createRecord(),
                child: Text("Create Record"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => getData(),
                child: Text("View Record"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: null,
                child: Text("Update Record"),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: null,
                child: Text("Delete Record"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
