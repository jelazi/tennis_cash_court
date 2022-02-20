import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './tennis_hour.dart';
import 'dart:convert';

class PreferencesModel {
  PreferencesModel();

  void saveDataToPreferences(RxList<dynamic> listTennisHours) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('listHours', _encodeToJson(listTennisHours));
  }

  Future<RxList<dynamic>> getDataFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return _decodeFromJson(prefs.getString('listHours') ?? '');
  }

  void deleteDataPreferences() async {
    print('delete data');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('listHours');
  }

  RxList<dynamic> _decodeFromJson(String hours) {
    if (hours.isEmpty) return [].obs;
    return RxList((json.decode(hours))
        .map<TennisHour>((item) => TennisHour.fromMap(item))
        .toList());
  }

  String _encodeToJson(RxList<dynamic> list) => json.encode(
        list.map<Map<String, dynamic>>((hour) => hour.toMap()).toList(),
      );
}
