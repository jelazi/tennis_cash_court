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

  double get summaryCurrent {
    double sum = 0;
    _listTennisHours
        .map((hour) => {if (!hour.isSold) sum += (hour.hours * priceForHour)})
        .toList();
    return sum;
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
        .then((value) => _listTennisHours = value)
        .then(
            (value) => _listTennisHours.map((e) => print(e.toMap())).toList());
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
