import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import 'package:flutter_test_tots/app/core/services/auth_service.dart';

import '../../app/core/models/client_model.dart';
import '../../app/core/services/clients_service.dart';

class ClientsViewModel extends BaseViewModel {
  final AuthService _authService = GetIt.instance<AuthService>();

  final ClientsService _clientsService = GetIt.instance<ClientsService>();

  int _loadFiveClients = 0;

  get loadFiveClients => _loadFiveClients;

  void loadFiveClientsMore() {
    if (_loadFiveClients < _filteredClients.length) {
      _loadFiveClients =
          (_loadFiveClients + 5).clamp(0, _filteredClients.length);
      notifyListeners();
    }
  }

  List<Client> _clients = [];
  List<Client> get clients => _clients;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int? _selectedCardIndex;
  int? get selectedCardIndex => _selectedCardIndex;

  void toggleSelectedCardIndex(int index) {
    if (_selectedCardIndex == index) {
      _selectedCardIndex = null;
    } else {
      _selectedCardIndex = index;
    }
    notifyListeners();
  }

  Future<void> fetchClients() async {
    setBusy(true);
    try {
      _clients = await _clientsService.fetchClients(_authService.token!);
      _filteredClients = _clients;
      _loadFiveClients = 5;

      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load clients';
    }
    setBusy(false);
    notifyListeners();
  }

  List<Client> _filteredClients = [];

  List<Client> get displayedClients =>
      _filteredClients.take(_loadFiveClients).toList();

  void searchClients(String query) {
    final searchQuery = query.trim().toLowerCase();

    if (searchQuery.isEmpty) {
      _filteredClients = List.from(_clients);
    } else {
      _filteredClients = _clients.where((client) {
        final name =
            '${client.firstname ?? ''} ${client.lastname ?? ''}'.toLowerCase();
        final email = client.email?.toLowerCase() ?? '';

        return name.contains(searchQuery) || email.contains(searchQuery);
      }).toList();
    }

    _loadFiveClients =
        (_filteredClients.length >= 5) ? 5 : _filteredClients.length;

    notifyListeners();
  }

  void removeClientFromList(int clientId) {
    _clients.removeWhere((client) => client.id == clientId);
    notifyListeners();
  }

  void updateClientInList(Client updatedClient) {
    final index =
        _clients.indexWhere((client) => client.id == updatedClient.id);
    if (index != -1) {
      _clients[index] = updatedClient;
      notifyListeners();
    }
  }
}
