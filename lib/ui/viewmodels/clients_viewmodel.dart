import 'package:flutter_test_tots/app/core/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';
import '../../app/core/models/client_model.dart';
import '../../app/core/services/clients_service.dart';

class ClientsViewModel extends BaseViewModel {
  //se almacena el token
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

  Future<void> fetchClients() async {
    setBusy(true);
    try {
      _clients = await _clientsService.fetchClients(_authService.token!);
      _filteredClients = _clients;
      _loadFiveClients = 5;

      _errorMessage = null;
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
    // Limpia el `query` eliminando espacios extras
    final searchQuery = query.trim().toLowerCase();

    // Si el query está vacío, muestra todos los clientes
    if (searchQuery.isEmpty) {
      _filteredClients = List.from(_clients);
    } else {
      _filteredClients = _clients.where((client) {
        // Concatena firstname y lastname, y compara con el email
        final name =
            '${client.firstname ?? ''} ${client.lastname ?? ''}'.toLowerCase();
        final email = client.email?.toLowerCase() ?? '';

        // Verifica si el query aparece en el nombre o email
        return name.contains(searchQuery) || email.contains(searchQuery);
      }).toList();
    }

    // Reinicia el contador de clientes visibles para la lista filtrada
    _loadFiveClients =
        (_filteredClients.length >= 5) ? 5 : _filteredClients.length;

    notifyListeners();
  }
}
