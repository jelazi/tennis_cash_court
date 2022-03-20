import 'package:tennis_cash_court/controllers/authentication/authentication_controller.dart';
import 'package:tennis_cash_court/controllers/settings.controller.dart';
import 'package:tennis_cash_court/model/database_model.dart';

import '../../model/player.dart';
import 'package:get/get.dart';

abstract class AuthenticationService extends GetxService {
  Future<Player?> getCurrentUser();
  Future<Player> signInWithNameAndPassword(String name, String password);
  Future<void> signOut();
}

class MyAuthenticationService extends AuthenticationService {
  final SettingsController _settingsController = Get.find();
  @override
  Future<Player?> getCurrentUser() async {
    return _settingsController.currentPlayer;
  }

  @override
  Future<Player> signInWithNameAndPassword(String name, String password) async {
    if (!_settingsController.isCorrectPlayer(name, password)) {
      throw AuthenticationException(message: 'Wrong username or password');
    }
    Player currentPlayer = Player(name, password);
    _settingsController.currentPlayer = Player(name, password);
    _settingsController.saveData();
    return currentPlayer;
  }

  @override
  Future<void> signOut() async {}
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}
