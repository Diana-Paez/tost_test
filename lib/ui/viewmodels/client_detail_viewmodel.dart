import 'dart:developer';

import 'package:flutter_test_tots/app/core/services/auth_service.dart';
import 'package:flutter_test_tots/app/core/services/clients_service.dart';
import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';

class ClientDetailViewModel extends BaseViewModel {
  final AuthService _authService = GetIt.instance<AuthService>();
  final ClientsService _clientsService = GetIt.instance<ClientsService>();

  // Variables para almacenar los datos del formulario
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String? _photo;

  // Setters para actualizar cada campo
  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPhoto(String photoUrl) {
    _photo = photoUrl;
    notifyListeners();
  }

  bool isEnabled() {
    if (_firstName.length >= 4 && _lastName.length >= 4 && _email.length >= 8) {
      return true;
    } else {
      return false;
    }
  }

// Método para guardar el cliente
  Future<bool?> saveClient() async {
    setBusy(true);
    try {
      await _clientsService.requestServer(
          token: _authService.token!,
          firstName: _firstName,
          lastName: _lastName,
          email: _email,
          photo: _photo,
          clientMethod: ClientMethod.create);

      return true;
    } catch (e) {
      log('Error al guardar el cliente: $e');
      throw Exception('Failed to add client');
    } finally {
      setBusy(false);
    }
  }

  Future<bool?> updateClient() async {
    setBusy(true);

    try {
      await _clientsService.requestServer(
          token: _authService.token!,
          firstName: _firstName,
          lastName: _lastName,
          email: _email,
          photo: _photo,
          clientMethod: ClientMethod.update);
      return true;
    } catch (e) {
      log('Error al guardar el cliente: $e');
      throw Exception('Failed to add client');
    } finally {
      setBusy(false);
    }
  }

  Future<bool?> deleleClient(String id) async {
    setBusy(true);

    try {
      await _clientsService.deleteClient(_authService.token!, id);

      return true;
    } catch (e) {
      log('Error al guardar el cliente: $e');
      throw Exception('Failed to add client');
    } finally {
      setBusy(false);
    }
  }
}
