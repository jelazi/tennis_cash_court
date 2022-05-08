import 'package:get/get.dart';
import 'package:tennis_cash_court/model/player.dart';
import '../others/constants.dart';
import './tennis_hour.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class StorageModel {
  static final StorageModel _singleton = StorageModel._internal();

  factory StorageModel() {
    return _singleton;
  }
  StorageModel._internal();

  final box = GetStorage();

  saveTennisHoursToStorage(List listTennisHours) async {
    await box.write('listHours', _encodeTennisHoursToJson(listTennisHours));
  }

  Future<List> getTennisHoursFromStorage() async {
    return _decodeHoursFromJson(box.read('listHours') ?? '');
  }

  deleteTennisHourFromStorage() async {
    logger.d('delete data');
    await box.remove('listHours');
  }

  List _decodeHoursFromJson(String hours) {
    if (hours.isEmpty) return [].obs;
    return (json.decode(hours))
        .map<TennisHour>((item) => TennisHour.fromJson(item))
        .toList();
  }

  String _encodeTennisHoursToJson(List list) => json.encode(
        list.map<Map<String, dynamic>>((hour) => hour.toJson()).toList(),
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
