import 'package:flutter/material.dart';
import 'package:flutter_test_tots/app/app.router.dart';
import 'package:flutter_test_tots/app/app.locator.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart'; // Importamos el archivo del locator

void main() {
  // Llama a setupLocator para inicializar los servicios antes de ejecutar la app
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      navigatorKey: GetIt.instance<NavigationService>()
          .navigatorKey, // Configura navigatorKey
      initialRoute: AppRouter.loginRoute, // Definimos la ruta inicial
      onGenerateRoute:
          AppRouter.generateRoute, // Configuración de rutas con auto_route
    );
  }
}
