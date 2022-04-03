import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import 'package:json_annotation/json_annotation.dart';

import '../controllers/settings.controller.dart';

part 'tennis_hour.g.dart';

@JsonSerializable()
class TennisHour {
  late double hours;
  late DateTime date;
  List<String> partners = [];
  bool _isPayd = false;
  late String id;

  SettingsController _settingsController = Get.find();

  TennisHour(
    this.date,
    this.hours,
  ) {
    _generateId();
  }

  factory TennisHour.fromJson(Map<String, dynamic> json) =>
      _$TennisHourFromJson(json);
  Map<String, dynamic> toJson() => _$TennisHourToJson(this);

  void _generateId() {
    var uuidGener = Uuid();
    id = uuidGener.v1();
  }

  List<String> get partnerWithoutCurrentPlayer {
    List<String> list = partners.toList();
    logger.d(list);
    list.remove(_settingsController.currentPlayer?.name ?? '');
    return list;
  }

  bool get isPayd {
    return _isPayd;
  }

  set isPayd(bool isPayd) {
    _isPayd = isPayd;
  }

  String getAllChars() {
    //for filtering
    String allChars = '';
    allChars = hours.toString();
    DateFormat formatter = DateFormat('dd. MM. yyyy');
    allChars += formatter.format(date);
    allChars += partners.join();
    return allChars;
  }

  bool updateDatas(TennisHour hourUpdate) {
    if (hourUpdate.id != id) return false;
    _isPayd = hourUpdate.isPayd;
    hours = hourUpdate.hours;
    partners = hourUpdate.partners;
    date = hourUpdate.date;
    return true;
  }
}
