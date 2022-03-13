import '../../model/player.dart';
import 'package:get/get.dart';

abstract class AuthenticationService extends GetxService {
  Future<Player?> getCurrentUser();
  Future<Player> signInWithNameAndPassword(String email, String password);
  Future<void> signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<Player?> getCurrentUser() async {
    // simulated delay
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  Future<Player> signInWithNameAndPassword(
      String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    if (email.toLowerCase() != 'test' || password != 'test') {
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
