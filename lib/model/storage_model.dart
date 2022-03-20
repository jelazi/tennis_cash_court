import 'package:get/get.dart';
import 'package:tennis_cash_court/model/player.dart';
import '../constants.dart';
import './tennis_hour.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class StorageModel {
  final box = GetStorage();
  StorageModel();

  saveTennisHoursToStorage(List listTennisHours) async {
    await box.write('listHours', _encodeTennisHoursToJson(listTennisHours));
  }

  Future<List> getTennisHoursFromStorage() async {
    return _decodeHoursFromJson(box.read('listHours') ?? '');
  }

  deleteTennisHourFromStorage() async {
    print('delete data');
    await box.remove('listHours');
  }

  List _decodeHoursFromJson(String hours) {
    if (hours.isEmpty) return [].obs;
    return (json.decode(hours))
        .map<TennisHour>((item) => TennisHour.fromMap(item))
        .toList();
  }

  String _encodeTennisHoursToJson(List list) => json.encode(
        list.map<Map<String, dynamic>>((hour) => hour.toMap()).toList(),
      );

  Future<Player?> getCurrentPlayerFromStorage() async {
    Future<Map<String, dynamic>> map = box.read('player');
    logger.d(map);
    return null;
  }

  saveCurrentPlayerToStorage(Player player) async {
    await box.write('player', player.toJson());
  }

  resetAllData() async {
    await box.erase();
  }
}
