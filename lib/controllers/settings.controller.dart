import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants.dart';
import '../model/player.dart';

class SettingsController extends GetxController {
  RxInt priceForHour = RxInt(100);
  RxString currency = RxString('Kč');
  Player? currentPlayer;
  List<Player> _listPlayers = [];
  Rx<Locale> language = Rx(Locale('cs', 'CZ'));

  loadData() async {
    final box = GetStorage();
    priceForHour = RxInt(await box.read('priceForHour') ?? 100);
    currency = RxString(await box.read('currency') ?? 'Kč');
    language = Rx(Locale(await box.read('language') ?? 'cs'));
    if (box.hasData('player')) {
      currentPlayer = Player.fromJson(await box.read('player'));
    } else {
      logger.d('First run app');
    }
    _listPlayers = getDefaultPlayers();
  }

  Locale getLocale(String nameLanguage) {
    logger.d(nameLanguage);
    if (nameLanguage == 'cs') {
      return Locale('cs', 'CZ');
    }
    return Locale('en', 'US');
  }

  updateListPlayers(List<Player> players) {
    _listPlayers = players;
  }

  List<Player> get listPlayers {
    return _listPlayers;
  }

  List<Player> getDefaultPlayers() {
    List<Player> players = [];
    Player admin = Player.withAdminRights('Lubik', 'pass');
    players.add(admin);
    Player player = Player('player1', 'pass');
    players.add(player);
    return players;
  }

  bool isAdmin(String name, String pass) {
    for (Player player in _listPlayers) {
      if (player.name == name && player.password == pass) {
        return player.isAdmin;
      }
    }
    return false;
  }

  saveData() async {
    final box = GetStorage();
    await box.write('priceForHour', priceForHour.value);
    await box.write('currency', currency.value);
    logger.d(currentPlayer?.name);
    await box.write('player', currentPlayer?.toJson());
    await box.write('language', language.value.languageCode);
  }

  bool isCorrectPlayer(String name, String password) {
    for (Player player in listPlayers) {
      if (player.name == name && player.password == password) {
        return true;
      }
    }
    return false;
  }
}
