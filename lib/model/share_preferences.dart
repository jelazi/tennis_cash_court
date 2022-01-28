import 'package:shared_preferences/shared_preferences.dart';
import './hour_manager.dart';
import './tennis_hour.dart';
import 'dart:convert';

class PreferencesModel {
  late HourManager hourManager;

  static final PreferencesModel _preferencesModel =
      PreferencesModel._internal();

  factory PreferencesModel() {
    return _preferencesModel;
  }

  PreferencesModel._internal() {
    hourManager = HourManager();
  }

  void saveDataToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'listHours', _encodeToJson(hourManager.listTennisHours));
  }

  Future<List<TennisHour>> getDataFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return _decodeFromJson(prefs.getString('listHours') ?? '');
  }

  void deleteDataPreferences() async {
    print('delte data');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('listHours');
  }

  List<TennisHour> _decodeFromJson(String hours) {
    if (hours.isEmpty) return [];
    return (json.decode(hours) as List<dynamic>)
        .map<TennisHour>((item) => TennisHour.fromMap(item))
        .toList();
  }

  String _encodeToJson(List<TennisHour> list) => json.encode(
        list.map<Map<String, dynamic>>((hour) => hour.toMap()).toList(),
      );
}
