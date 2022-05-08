import 'settings.controller.dart';

import '../others/constants.dart';
import '../model/storage_model.dart';
import '../model/tennis_hour.dart';
import 'package:get/get.dart';

class HourController extends GetxController {
  SettingsController settingsController = Get.find();
  RxList<TennisHour> listTennisHours = RxList<TennisHour>();
  RxBool isListTennisHourUnpaidNotEmpty = RxBool(false);

  HourController() {
    loadData();
  }

  RxList get listTennisHourUnpaid {
    var listTennisHourUnpaid = [].obs;
    for (var i = 0; i < listTennisHours.length; i++) {
      if (!listTennisHours[i].isPayd) {
        listTennisHourUnpaid.add(listTennisHours[i]);
      }
    }
    isListTennisHourUnpaidNotEmpty.value = listTennisHourUnpaid.isNotEmpty;
    return listTennisHourUnpaid;
  }

  List<Map<String, dynamic>> getListMapTennisHour() {
    List<Map<String, dynamic>> list = [];
    listTennisHours.map((e) => list.add(e.toJson())).toList();
    return list;
  }

  void payAll() {
    for (var i = 0; i < listTennisHours.length; i++) {
      listTennisHours[i].isPayd = true;
    }
    saveData();
    isListTennisHourUnpaidNotEmpty.value = false;
  }

  RxDouble get totalPrice {
    RxDouble sum = RxDouble(0);
    listTennisHours.map((hour) {
      int sumPartners = hour.partners.length;
      if (!hour.isPayd) {
        sum.value +=
            (hour.hours * (settingsController.priceForHour / sumPartners));
      }
    }).toList();
    return sum;
  }

  RxList<DateTime> get firstLastDateUnpaid {
    RxList<DateTime> list = RxList();
    if (listTennisHours.isEmpty || !isListTennisHourUnpaidNotEmpty.value) {
      return list;
    }
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
      hour.partners.map((partner) {
        if (!list.contains(partner) &&
            partner != settingsController.currentPlayer!.name) {
          list.add(partner);
        }
      }).toList();
    }).toList();
    list.add('addNewName'.tr);
    return list;
  }

  RxDouble get summaryHours {
    RxDouble sum = RxDouble(0);
    listTennisHours
        .map((hour) => {if (!hour.isPayd) sum.value += hour.hours})
        .toList();
    return sum;
  }

  Future<void> loadData() async {
    StorageModel storrageModel = StorageModel();
    List<TennisHour> list =
        await storrageModel.getTennisHoursFromStorage() as List<TennisHour>;

    listTennisHours.value = list;
  }

  saveData() async {
    List<TennisHour> list = listTennisHours;
    StorageModel storageModel = StorageModel();
    await storageModel.saveTennisHoursToStorage(list);
  }

  void addNewHour(TennisHour tennisHour) {
    listTennisHours.add(tennisHour);
    listTennisHourUnpaid.add(tennisHour);
    saveData();
    isListTennisHourUnpaidNotEmpty.value = true;
  }

  void updateDatas(List<TennisHour> data) {
    logger.d(data);
    for (TennisHour hour in data) {
      bool isUpdate = false;
      for (TennisHour hourCur in listTennisHours) {
        isUpdate = hourCur.updateDatas(hour);
        if (isUpdate) break;
      }
      if (!isUpdate) listTennisHours.add(hour);
    }
  }

  void deleteHour(TennisHour hourForDelete) {
    listTennisHours.removeWhere((element) => (element.id == hourForDelete.id));
    saveData();
  }
}
