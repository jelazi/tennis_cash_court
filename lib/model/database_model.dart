import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import './tennis_hour.dart';
import '../constants.dart';

class DatabaseModel {
  static final DatabaseModel _databaseModel = DatabaseModel._internal();

  factory DatabaseModel() {
    return _databaseModel;
  }

  final databaseReference = FirebaseDatabase.instance.ref('user1');

  DatabaseModel._internal();

  void setTennisHoursList(RxList<TennisHour> data) async {
    Map<String, dynamic> map = {};
    for (int index = 0; index < data.length; index++) {
      logger.d(data[index].toMap());
      map['hour' + index.toString()] = data[index].toMap();
    }

    await databaseReference.update(map);
  }

  Future<List<TennisHour>> getTennisHourListFromDatabase() async {
    List<TennisHour> tennisHour = [];
    await databaseReference.once().then((event) {
      final dataSnapshot = event.snapshot;

      Map<dynamic, dynamic>? map = dataSnapshot.value as Map?;
      if (map == null) return tennisHour;
      List listData = map.values.toList();

      for (int i = 0; i < listData.length; i++) {
        TennisHour hour = TennisHour.fromMap(listData[i]);
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
