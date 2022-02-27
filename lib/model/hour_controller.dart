import '../constants.dart';
import 'storage_model.dart';
import 'tennis_hour.dart';
import 'package:get/get.dart';

class HourController extends GetxController {
  var listTennisHours = [].obs;
  final String currency = 'Kč';
  double priceForHour = 100;

  RxList get listTennisHourUnpaid {
    var listTennisHourUnpaid = [].obs;
    for (var i = 0; i < listTennisHours.length; i++) {
      if (!listTennisHours[i].isPayd) {
        listTennisHourUnpaid.add(listTennisHours[i]);
      }
    }
    return listTennisHourUnpaid;
  }

  List<Map<String, dynamic>> getListMapTennisHour() {
    List<Map<String, dynamic>> list = [];
    listTennisHours.map((e) => list.add(e.toMap())).toList();
    return list;
  }

  void payAll() {
    for (var i = 0; i < listTennisHours.length; i++) {
      listTennisHours[i].isPayd = true;
    }
    _setData(listTennisHours);
  }

  RxDouble get totalPrice {
    RxDouble sum = RxDouble(0);
    listTennisHours.map((hour) {
      int sumPartners = hour.partner.isEmpty ? 1 : hour.partner.length;

      if (!hour.isPayd)
        sum.value += (hour.hours * (priceForHour / sumPartners));
    }).toList();
    return sum;
  }

  bool get _containsUnpaid {
    return listTennisHourUnpaid.isNotEmpty;
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
    listTennisHours.map((hour) {
      hour.partner.map((partner) {
        if (!list.contains(partner)) list.add(partner);
      }).toList();
    }).toList();
    list.add('..add new name');
    return list;
  }

  RxDouble get summaryHours {
    RxDouble sum = RxDouble(0);
    listTennisHours
        .map((hour) => {if (!hour.isPayd) sum.value += hour.hours})
        .toList();
    return sum;
  }

  Future loadData() async {
    StorageModel preferencesModel = StorageModel();
    await preferencesModel
        .getDataFromStorage()
        .then((value) => listTennisHours.value = value)
        .then((_) => null);
  }

  void addNewHour(TennisHour tennisHour) {
    listTennisHours.add(tennisHour);
    listTennisHourUnpaid.add(tennisHour);
    _setData(listTennisHours);
  }

  void _setData(List listTennisHours) async {
    StorageModel preferencesModel = StorageModel();
    preferencesModel.saveDataToStorage(listTennisHours);
  }

  void updateDatas(List<TennisHour> data) {
    for (TennisHour hour in data) {
      bool isUpdate = false;
      for (TennisHour hourCur in listTennisHours) {
        isUpdate = hourCur.updateDatas(hour);
      }
      if (!isUpdate) listTennisHours.add(hour);
    }
  }

  void deleteHour(TennisHour hourForDelete) {
    listTennisHours.removeWhere((element) => (element.id == hourForDelete.id));
    _setData(listTennisHours);
  }
}
