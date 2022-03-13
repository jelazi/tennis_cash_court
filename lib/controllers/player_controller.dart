import 'package:get/get.dart';
import 'package:tennis_cash_court/model/storage_model.dart';

import '../constants.dart';
import '../model/database_model.dart';
import '../model/player.dart';

class PlayerController extends GetxController {
  final DatabaseModel _databaseModel = DatabaseModel();
  final StorageModel _storageModel = StorageModel();
  List _listPlayers = [];
  Player? currentPlayer;

  PlayerController() {
    _databaseModel.setListPlayers(_listPlayers);
    loadAllPlayers();
    loadCurrentPlayer();
    logger.d(_listPlayers);
  }

  loadAllPlayers() async {
    List<dynamic> player = await _databaseModel.getListPLayers();
    _listPlayers = player;
    // logger.d(_listPlayers.first.name);
  }

  loadCurrentPlayer() {}

  loadDefaultPlayer() {
    Player admin = Player('Lubos', 'pass');
    admin.isAdmin = true;
    _listPlayers.add(admin);
  }

  setNewPlayer(String name, String password) {
    Player player = Player(name, password);
    if ((_listPlayers.singleWhere((it) => it.name == player.name,
            orElse: () => null)) !=
        null) {
      logger.e('Player name exists already');
      return;
    }
    _listPlayers.add(player);
  }
}
