import 'package:flutter_test_tots/app/core/services/clients_service.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_test_tots/app/core/services/auth_service.dart';

import 'package:stacked_services/stacked_services.dart';

import 'core/services/cloudinay_service.dart';

// Instancia de GetIt para inyección de dependencias
final locator = GetIt.instance;

// Función para registrar servicios
void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ClientsService());
  locator.registerLazySingleton(() => CloudinaryService());
}
