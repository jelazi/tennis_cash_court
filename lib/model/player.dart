import '../constants.dart';

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
