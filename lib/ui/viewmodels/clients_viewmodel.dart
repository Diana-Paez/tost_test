import 'package:flutter_test_tots/app/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';
import '../../app/core/models/client_model.dart';
import '../../app/core/services/clients_service.dart';

class ClientsViewModel extends BaseViewModel {
  final AuthService _authService = GetIt.instance<AuthService>();

  final ClientsService _clientsService = GetIt.instance<ClientsService>();

  List<Client> _clients = [];
  List<Client> get clients => _clients;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchClients() async {
    setBusy(true);
    try {
      _clients = await _clientsService.fetchClients(_authService.token!);
      print(_clients);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load clients';
    }
    setBusy(false);
    notifyListeners();
  }
}
