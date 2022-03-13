import 'package:get/get.dart';

import 'authentication_service.dart';
import 'authentication_state.dart';

class AuthenticationController extends GetxController {
  final AuthenticationService _authenticationService;
  final _authenticationStateStream = AuthenticationState().obs;

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

    final user = await _authenticationService.getCurrentUser();

    if (user == null) {
      _authenticationStateStream.value = UnAuthenticated();
    } else {
      _authenticationStateStream.value = Authenticated(player: user);
    }
  }
}
