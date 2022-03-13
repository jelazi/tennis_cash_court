import 'package:get/get.dart';

import '../constants.dart';
import '../model/database_model.dart';
import '../model/player.dart';

class PlayerController extends GetxController {
  DatabaseModel databaseModel = DatabaseModel();
  List listPlayers = [];

  PlayerController() {
    databaseModel.setListPlayers(listPlayers);
    loadFromDatabase();
  }

  loadFromDatabase() async {
    List<dynamic> player = await databaseModel.getListPLayers();
    listPlayers = player;
    logger.d(listPlayers.first.name);
  }

  loadDefaultPlayer() {
    Player admin = Player('Lubos', 'pass');
    admin.isAdmin = true;
    listPlayers.add(admin);
  }

  setNewPlayer(String name, String password) {
    Player player = Player(name, password);
    if ((listPlayers.singleWhere((it) => it.name == player.name,
            orElse: () => null)) !=
        null) {
      logger.e('Player name exists already');
      return;
    }
    listPlayers.add(player);
  }
}
