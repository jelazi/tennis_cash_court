import 'package:firebase_database/firebase_database.dart';
import './tennis_hour.dart';

class DatabaseModel {
  static final DatabaseModel _databaseModel = DatabaseModel._internal();

  factory DatabaseModel() {
    return _databaseModel;
  }

  final databaseReference = FirebaseDatabase.instance.ref('user1');

  DatabaseModel._internal();

  void setTennisHoursList(List<TennisHour> data) {
    Map<String, dynamic> map = {};
    for (int index = 1; index < data.length; index++) {
      map['hour' + index.toString()] = data[index].toMap();
    }
    databaseReference.update(map);
  }

  List<TennisHour> getTennisHourListFromDatabase() {
    List<TennisHour> tennisHour = [];
    databaseReference.once().then((event) {
      final dataSnapshot = event.snapshot;

      Map<dynamic, dynamic>? map = dataSnapshot.value as Map?;
      if (map == null) return tennisHour;
      List listData = map.values.toList();

      for (Map mapHour in listData) {
        TennisHour hour = TennisHour.fromMap(mapHour);
        tennisHour.add(hour);
      }
      return tennisHour;
    });
    return tennisHour;
  }

  void deleteAllData() {
    databaseReference.remove();
  }
}
