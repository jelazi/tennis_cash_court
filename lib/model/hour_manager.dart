import 'package:flutter/foundation.dart';
import '../model/tennis_hour.dart';

class HourManager {
  List<TennisHour> listTennisHours = [];
  String currency = 'Kč';
  static final HourManager _hourManager = HourManager._internal();
  double priceForHour = 100;

  double get summaryCurrent {
    double sum = 0;
    listTennisHours
        .map((hour) => {if (!hour.isSold) sum += (hour.hours * priceForHour)})
        .toList();
    return sum;
  }

  double get summaryHours {
    double sum = 0;
    listTennisHours
        .map((hour) => {if (!hour.isSold) sum += hour.hours})
        .toList();
    return sum;
  }

  factory HourManager() {
    return _hourManager;
  }

  HourManager._internal() {
    _loadDefaultData();
  }

  void _loadDefaultData() {
    listTennisHours.add(TennisHour(DateTime.utc(2021, 11, 9), 2, 'Pazit'));
    listTennisHours.add(TennisHour(DateTime.utc(2021, 11, 10), 2.5, 'Danek'));
    listTennisHours.add(TennisHour(DateTime.utc(2021, 11, 11), 3.5, 'Jarin'));
    listTennisHours.add(TennisHour(DateTime.utc(2021, 11, 9), 2, 'Pazit'));
    listTennisHours.add(TennisHour(DateTime.utc(2021, 11, 10), 2.5, 'Danek'));
    listTennisHours.add(TennisHour(DateTime.utc(2021, 11, 11), 3.5, 'Jarin'));
    listTennisHours.add(TennisHour(DateTime.utc(2021, 11, 9), 2, 'Pazit'));
    listTennisHours.add(TennisHour(DateTime.utc(2021, 11, 10), 2.5, 'Danek'));
    listTennisHours.add(TennisHour(DateTime.utc(2021, 11, 11), 3.5, 'Jarin'));
  }
}
