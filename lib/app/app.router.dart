import 'package:flutter/material.dart';

import '../ui/views/client_detail/client_detail_view.dart';
import '../ui/views/clients/clients_view.dart';
import '../ui/views/login/login_view.dart';
import '../app/core/models/client_model.dart';

class AppRouter {
  static const loginRoute = '/login';
  static const clientsRoute = '/clients';
  static const clientDetailRoute = '/client-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case clientsRoute:
        final arguments = settings.arguments as dynamic;
        return MaterialPageRoute(
          builder: (_) => const ClientsView(),
          settings: RouteSettings(
            arguments: arguments,
          ),
        );

      case clientDetailRoute:
        // Obtenemos los argumentos como un objeto `Client`
        final client = settings.arguments as Client?;
        return MaterialPageRoute(
          builder: (_) => const ClientDetailView(),
          settings: RouteSettings(
            arguments: client, // Pasamos el argumento `Client`
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
