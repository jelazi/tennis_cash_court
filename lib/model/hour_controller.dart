import 'storage_model.dart';
import 'tennis_hour.dart';
import 'package:get/get.dart';

class HourController extends GetxController with StateMixin {
  HourController() {}

  RxList<dynamic> _listTennisHours = [].obs;
  RxList<dynamic> _listTennisHourUnpaid = [].obs;
  final String currency = 'Kč';
  double priceForHour = 100;

  RxList<dynamic> get listTennisHours {
    return _listTennisHours;
  }

  RxList<dynamic> get listTennisHourUnpaid {
    return _listTennisHourUnpaid;
  }

  _updateListTennisHoursUnPaid() {
    _listTennisHourUnpaid = [].obs;
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
  }

  RxDouble get totalPrice {
    RxDouble sum = RxDouble(0);
    _listTennisHours.map((hour) {
      int sumPartners = hour.partner.isEmpty ? 1 : hour.partner.length;

      if (!hour.isPayd)
        sum.value += (hour.hours * (priceForHour / sumPartners));
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

  RxDouble get summaryHours {
    RxDouble sum = RxDouble(0);
    _listTennisHours
        .map((hour) => {if (!hour.isPayd) sum.value += hour.hours})
        .toList();
    return sum;
  }

  Future loadData() async {
    StorageModel preferencesModel = StorageModel();
    await preferencesModel
        .getDataFromStorage()
        .then((value) => _listTennisHours = value)
        .then((_) => null);
    _updateListTennisHoursUnPaid();
  }

  void addNewHour(TennisHour tennisHour) {
    _listTennisHours.add(tennisHour);
    _setData(listTennisHours);
    _updateListTennisHoursUnPaid();
  }

  void _setData(RxList<dynamic> listTennisHours) async {
    StorageModel preferencesModel = StorageModel();
    preferencesModel.saveDataToStorage(listTennisHours);
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
    //   notifyListeners();
  }

  void deleteHour(TennisHour hourForDelete) {
    _listTennisHours.removeWhere((element) => (element.id == hourForDelete.id));
    _setData(listTennisHours);
    _updateListTennisHoursUnPaid();
    //  notifyListeners();
  }
}
