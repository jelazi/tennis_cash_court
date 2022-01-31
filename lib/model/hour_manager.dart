import 'package:tennis_cash_court/model/share_preferences.dart';
import '../model/tennis_hour.dart';

class HourManager {
  List<TennisHour> _listTennisHours = [];
  String currency = 'Kč';
  static final HourManager _hourManager = HourManager._internal();
  double priceForHour = 100;

  List<TennisHour> get listTennisHours {
    return _listTennisHours;
  }

  List<Map<String, dynamic>> getListMapTennisHour() {
    List<Map<String, dynamic>> list = [];
    _listTennisHours.map((e) => list.add(e.toMap())).toList();
    return list;
  }

  double get totalPrice {
    double sum = 0;
    _listTennisHours.map((hour) {
      int sumPartners = hour.partner.isEmpty ? 1 : hour.partner.length;

      if (!hour.isSold) sum += (hour.hours * (priceForHour / sumPartners));
    }).toList();
    return sum;
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
        .map((hour) => {if (!hour.isSold) sum += hour.hours})
        .toList();
    return sum;
  }

  factory HourManager() {
    return _hourManager;
  }

  HourManager._internal() {
    // _loadDefaultData();
  }

  void loadData() async {
    PreferencesModel preferencesModel = PreferencesModel();
    preferencesModel
        .getDataFromPreferences()
        .then((value) => _listTennisHours = value);
  }

  void addNewHour(TennisHour tennisHour) {
    _listTennisHours.add(tennisHour);
    _setData();
  }

  void _setData() async {
    PreferencesModel preferencesModel = PreferencesModel();
    preferencesModel.saveDataToPreferences();
  }

  void updateDatas(List<TennisHour> data) {
    for (TennisHour hour in data) {
      bool isUpdate = false;
      for (TennisHour hourCur in _listTennisHours) {
        isUpdate = hourCur.updateDatas(hour);
      }
      if (!isUpdate) _listTennisHours.add(hour);
    }
  }

  void deleteHour(TennisHour hourForDelete) {
    _listTennisHours.removeWhere((element) => (element.id == hourForDelete.id));
    _setData();
  }
}
