import 'package:flutter/material.dart';
import 'package:tennis_cash_court/model/preferences_model.dart';
import 'package:tennis_cash_court/model/tennis_hour.dart';

class HourModel extends ChangeNotifier {
  List<TennisHour> _listTennisHours = [];
  List<TennisHour> _listTennisHourUnpaid = [];
  String currency = 'Kč';
  double priceForHour = 100;

  List<TennisHour> get listTennisHours {
    return _listTennisHours;
  }

  List<TennisHour> get listTennisHourUnpaid {
    return _listTennisHourUnpaid;
  }

  _updateListTennisHoursUnPaid() {
    _listTennisHourUnpaid = [];
    _listTennisHours.map((hour) {
      if (!hour.isPayd) _listTennisHourUnpaid.add(hour);
    }).toString();
  }

  List<Map<String, dynamic>> getListMapTennisHour() {
    List<Map<String, dynamic>> list = [];
    _listTennisHours.map((e) => list.add(e.toMap())).toList();
    return list;
  }

  void payAll() {
    for (var i = 0; i < _listTennisHours.length; i++) {
      _listTennisHours[i].isPayd = true;
    }
    _setData(listTennisHours);
    _updateListTennisHoursUnPaid();
    notifyListeners();
  }

  double get totalPrice {
    double sum = 0;
    _listTennisHours.map((hour) {
      int sumPartners = hour.partner.isEmpty ? 1 : hour.partner.length;

      if (!hour.isPayd) sum += (hour.hours * (priceForHour / sumPartners));
    }).toList();
    return sum;
  }

  bool get _containsUnpaid {
    return _listTennisHourUnpaid.isNotEmpty;
  }

  List<DateTime> getFirstLastDateUnpaid() {
    List<DateTime> list = [];
    if (listTennisHours.isEmpty || !_containsUnpaid) return list;
    DateTime first = listTennisHours.first.date;
    DateTime last = listTennisHours.first.date;
    listTennisHours.map((e) {
      if (first.isAfter(e.date) && !e.isPayd) first = e.date;
      if (last.isBefore(e.date) && !e.isPayd) last = e.date;
    }).toList();
    list.add(first);
    list.add(last);
    return list;
  }

  List<String> getListCurrentPartners() {
    List<String> list = [''];
    _listTennisHours.map((hour) {
      hour.partner.map((partner) {
        if (!list.contains(partner)) list.add(partner);
      }).toList();
    }).toList();
    list.add('..add new name');
    return list;
  }

  double get summaryHours {
    double sum = 0;
    _listTennisHours
        .map((hour) => {if (!hour.isPayd) sum += hour.hours})
        .toList();
    return sum;
  }

  void loadData() async {
    PreferencesModel preferencesModel = PreferencesModel();
    preferencesModel
        .getDataFromPreferences()
        .then((value) => _listTennisHours = value);
    _updateListTennisHoursUnPaid();
    notifyListeners();
  }

  void addNewHour(TennisHour tennisHour) {
    _listTennisHours.add(tennisHour);
    _setData(listTennisHours);
    _updateListTennisHoursUnPaid();
    notifyListeners();
  }

  void _setData(List<TennisHour> listTennisHours) async {
    PreferencesModel preferencesModel = PreferencesModel();
    preferencesModel.saveDataToPreferences(listTennisHours);
  }

  void updateDatas(List<TennisHour> data) {
    for (TennisHour hour in data) {
      bool isUpdate = false;
      for (TennisHour hourCur in _listTennisHours) {
        isUpdate = hourCur.updateDatas(hour);
      }
      if (!isUpdate) _listTennisHours.add(hour);
    }
    _updateListTennisHoursUnPaid();
    notifyListeners();
  }

  void deleteHour(TennisHour hourForDelete) {
    _listTennisHours.removeWhere((element) => (element.id == hourForDelete.id));
    _setData(listTennisHours);
    _updateListTennisHoursUnPaid();
    notifyListeners();
  }
}
