import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  RxInt priceForHour = RxInt(100);
  RxString currency = RxString('Kč');

  SettingsController() {
    loadData();
  }

  loadData() async {
    final box = GetStorage();
    priceForHour = RxInt(await box.read('priceForHour') ?? 100);
    currency = RxString(await box.read('currency') ?? 'Kč');
  }

  saveData() async {
    final box = GetStorage();
    await box.write('priceForHour', priceForHour.value);
    await box.write('currency', currency.value);
  }
}
