import 'package:tennis_cash_court/controllers/player_controller.dart';
import 'package:tennis_cash_court/controllers/settings.controller.dart';
import 'package:tennis_cash_court/model/database_model.dart';

import '../../model/player.dart';
import 'package:get/get.dart';

abstract class AuthenticationService extends GetxService {
  Future<Player?> getCurrentUser();
  Future<Player> signInWithNameAndPassword(String email, String password);
  Future<void> signOut();
}

class MyAuthenticationService extends AuthenticationService {
  PlayerController _playerController = Get.find();
  @override
  Future<Player?> getCurrentUser() async {
    return _playerController.currentPlayer;
  }

  @override
  Future<Player> signInWithNameAndPassword(String name, String password) async {
    if (name != 'test' || password != 'test') {
      throw AuthenticationException(message: 'Wrong username or password');
    }

    return Player('name', password);
  }

  @override
  Future<void> signOut() async {}
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}
