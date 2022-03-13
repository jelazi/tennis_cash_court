import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/player.dart';

class SettingsController extends GetxController {
  RxInt priceForHour = RxInt(100);
  RxString currency = RxString('Kč');
  Player? currentPlayer;

  SettingsController() {
    loadData();
  }

  loadData() async {
    final box = GetStorage();
    priceForHour = RxInt(await box.read('priceForHour') ?? 100);
    currency = RxString(await box.read('currency') ?? 'Kč');
    currentPlayer = Player.fromMap(await box.read('current_player'));
  }

  saveData() async {
    final box = GetStorage();
    await box.write('priceForHour', priceForHour.value);
    await box.write('currency', currency.value);
    await box.write('current_player', currentPlayer?.toMap());
  }
}
