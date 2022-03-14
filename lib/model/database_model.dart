import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import './tennis_hour.dart';
import '../constants.dart';
import 'player.dart';

class DatabaseModel {
  static final DatabaseModel _databaseModel = DatabaseModel._internal();

  factory DatabaseModel() {
    return _databaseModel;
  }

  final databaseHours = FirebaseDatabase.instance.ref('hours');
  final databasePlayers = FirebaseDatabase.instance.ref('players');

  DatabaseModel._internal();

  void setTennisHoursList(RxList<TennisHour> data) async {
    Map<String, dynamic> map = {};
    for (int index = 0; index < data.length; index++) {
      logger.d(data[index].toMap());
      map['hour' + index.toString()] = data[index].toMap();
    }

    await databaseHours.update(map);
  }

  setListPlayers(List<dynamic> listPlayers) async {
    Map<String, dynamic> map = {};
    for (Player player in listPlayers) {
      map[player.name] = player.toMap();
    }
    await databasePlayers.update(map);
  }

  Future<List<dynamic>> getListPLayers() async {
    List<Player> listPlayers = [];
    await databasePlayers.once().then((event) {
      final dataSnapshot = event.snapshot;
      Map<dynamic, dynamic>? map = dataSnapshot.value as Map?;
      if (map == null) return listPlayers;
      List listDatas = map.values.toList();
      for (Map listData in listDatas) {
        Player player = Player.fromMap(listData);
        listPlayers.add(player);
      }
      return listPlayers;
    });
    return listPlayers;
  }

  Future<List<TennisHour>> getTennisHourListFromDatabase() async {
    List<TennisHour> tennisHour = [];
    await databaseHours.once().then((event) {
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
    databaseHours.remove();
  }
}
