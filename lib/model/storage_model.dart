import 'package:get/get.dart';
import './tennis_hour.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class StorageModel {
  final box = GetStorage();
  StorageModel();

  void saveDataToStorage(RxList<dynamic> listTennisHours) async {
    await box.write('listHours', _encodeToJson(listTennisHours));
  }

  Future<RxList<dynamic>> getDataFromStorage() async {
    return _decodeFromJson(box.read('listHours') ?? '');
  }

  void deleteDataPreferences() async {
    print('delete data');
    await box.remove('listHours');
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
