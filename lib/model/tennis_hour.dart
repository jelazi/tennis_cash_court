import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../others/constants.dart';
import 'package:json_annotation/json_annotation.dart';

import '../controllers/settings.controller.dart';

part 'tennis_hour.g.dart';

@JsonSerializable()
class TennisHour {
  late double hours;
  late DateTime date;
  List<String> partners = [];
  bool isPayd = false;
  late String id;

  final SettingsController _settingsController = Get.find();

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
    var uuidGener = const Uuid();
    id = uuidGener.v1();
  }

  List<String> get partnerWithoutCurrentPlayer {
    List<String> list = partners.toList();
    logger.v(list);
    list.remove(_settingsController.currentPlayer?.name ?? '');
    return list;
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
    isPayd = hourUpdate.isPayd;
    hours = hourUpdate.hours;
    partners = hourUpdate.partners;
    date = hourUpdate.date;
    return true;
  }
}
