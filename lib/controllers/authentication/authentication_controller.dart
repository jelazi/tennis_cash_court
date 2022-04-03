import 'package:get/get.dart';
import '../settings.controller.dart';
import 'package:tennis_cash_court/model/database_model.dart';

import '../../constants.dart';
import '../../model/player.dart';
import 'authentication_service.dart';
import 'authentication_state.dart';

class AuthenticationController extends GetxController {
  final AuthenticationService _authenticationService;
  final _authenticationStateStream = AuthenticationState().obs;
  final SettingsController _settingsController = Get.find();

  AuthenticationState get state => _authenticationStateStream.value;

  AuthenticationController(this._authenticationService);

  @override
  void onInit() {
    _getAuthenticatedUser();
    super.onInit();
  }

  Future<void> signIn(String name, String password) async {
    final user =
        await _authenticationService.signInWithNameAndPassword(name, password);
    _authenticationStateStream.value = Authenticated(player: user);
  }

  void signOut() async {
    await _authenticationService.signOut();
    _authenticationStateStream.value = UnAuthenticated();
  }

  void _getAuthenticatedUser() async {
    _authenticationStateStream.value = AuthenticationLoading();

    final Player player = _settingsController.currentPlayer ?? Player('', '');

    if (_settingsController.isCorrectPlayer(player.name, player.password)) {
      _authenticationStateStream.value = Authenticated(player: player);
    } else {
      _authenticationStateStream.value = UnAuthenticated();
    }
  }
}
