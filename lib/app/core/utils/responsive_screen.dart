import 'package:flutter/material.dart';

// Enum para seleccionar entre ancho o altura
enum ScreenDimension { width, height }

// Obtiene la dimensión usable de la pantalla según el tipo (ancho o altura)

double getUsableScreenDimension(
    BuildContext context, ScreenDimension dimension) {
  // Tamaño total de la pantalla
  final screenSize = MediaQuery.of(context).size;

// Altura usable (descontando top y bottom padding)
  final usableHeight = screenSize.height -
      MediaQuery.of(context).viewPadding.top -
      MediaQuery.of(context).viewPadding.bottom;

  // Ancho usable (descontando left y right padding)
  final usableWidth = screenSize.width -
      MediaQuery.of(context).viewPadding.left -
      MediaQuery.of(context).viewPadding.right;

  // Retorna la dimensión solicitada
  switch (dimension) {
    case ScreenDimension.width:
      return usableWidth;
    case ScreenDimension.height:
      return usableHeight;
    default:
      throw ArgumentError("Invalid screen dimension type");
  }
}
