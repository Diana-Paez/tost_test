import 'package:flutter_test_tots/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/core/services/auth_service.dart';
import '../../../app/core/models/auth_response.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService _authService = GetIt.instance<AuthService>();
  final NavigationService _navigationService =
      GetIt.instance<NavigationService>();

  String _email = '';
  // Métodos para actualizar email y password
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  String _password = '';

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthResponse? _authResponse;
  AuthResponse? get authResponse => _authResponse;

  // Método para manejar la autenticación
  Future<void> login() async {
    setBusy(true);

    _errorMessage = null; // Reseteamos el mensaje de error
    _authResponse = await _authService.authenticate(_email, _password);

    if (_authResponse == null) {
      _errorMessage = 'Error al iniciar sesión. Verifica tus credenciales.';
    } else {
      // Navegamos a la vista de clientes si la autenticación fue exitosa
      _navigationService.navigateTo(AppRouter.clientsRoute);
    }

    setBusy(false);
    notifyListeners();
  }
}
