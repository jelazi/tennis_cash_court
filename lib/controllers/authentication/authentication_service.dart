import '../settings.controller.dart';

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
      throw AuthenticationException(message: 'wrongUserOrPass'.tr);
    }
    Player currentPlayer = Player(name, password);
    if (_settingsController.isAdmin(name, password)) {
      currentPlayer = Player.withAdminRights(name, password);
    }
    _settingsController.currentPlayer = currentPlayer;
    _settingsController.saveData();
    return currentPlayer;
  }

  @override
  Future<void> signOut() async {}
}

class AuthenticationException implements Exception {
  String message = 'unknownError'.tr;

  AuthenticationException({this.message = 'unknownError'});
}
