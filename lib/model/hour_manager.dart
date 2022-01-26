import 'package:flutter/foundation.dart';
import 'package:tennis_cash_court/model/tennis_hour.dart';

class HourManager {
  List<TennisHour> listTennisHours = [];
  String currency = 'Kč';
  static final HourManager _hourManager = HourManager._internal();
  double priceForHour = 100;
  double get summary {
    double sum = 0;
    for (TennisHour hour in listTennisHours) {
      if (!hour.isSold) sum += (hour.hours * priceForHour);
    }
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
  }
}
