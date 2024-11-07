import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import '../ui/views/client_detail/client_detail_view.dart';
import '../ui/views/clients/clients_view.dart';
import '../ui/views/login/login_view.dart';

class AppRouter {
  static const loginRoute = '/login';
  static const clientsRoute = '/clients';
  static const clientDetailRoute = '/client-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case clientsRoute:
        return MaterialPageRoute(builder: (_) => const ClientsView());
      case clientDetailRoute:
        return MaterialPageRoute(builder: (_) => const ClientDetailView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
