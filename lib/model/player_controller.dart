import 'package:get/get.dart';

import '../constants.dart';
import 'database_model.dart';

class Player {
  String name;
  bool isAdmin = false;
  String password;

  Player(this.name, this.password);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'isAdmin': isAdmin.toString(),
      'password': password,
    };
    return map;
  }

  Player.fromMap(Map map, {this.name = '', this.password = ''}) {
    try {
      name = map['name'];
      isAdmin = map['isAdmin'] == 'true' ? true : false;
      password = map['password'];
    } catch (e) {
      logger.e('wrong map from database');
    }
  }
}

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
