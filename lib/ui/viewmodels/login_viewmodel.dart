import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:flutter_test_tots/app/app.router.dart';

import '../../app/core/models/auth_response_model.dart';
import '../../app/core/services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService _authService = GetIt.instance<AuthService>();
  final NavigationService _navigationService =
      GetIt.instance<NavigationService>();

  String _email = '';
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  get email => _email;

  bool _isPasswordVisible = false;

  get isPasswordVisible => _isPasswordVisible;

  set isPasswordVisible(value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  String _password = '';

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  get password => _password;

  bool isEnabled() {
    if (_password.length > 4 && _email.length > 5) {
      return true;
    } else {
      return false;
    }
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthResponseModel? _authResponse;
  AuthResponseModel? get authResponse => _authResponse;

  Future<void> login() async {
    setBusy(true);

    _errorMessage = null;
    _authResponse = await _authService.authenticate(_email, _password);

    if (_authResponse == null) {
      _errorMessage = 'Error al iniciar sesión. Verifica tus credenciales.';
    } else {
      _navigationService.pushNamedAndRemoveUntil(AppRouter.clientsRoute);
    }

    setBusy(false);
    notifyListeners();
  }
}
