import 'package:flutter/material.dart';

enum ScreenDimension { width, height }

double getUsableScreenDimension(
    BuildContext context, ScreenDimension dimension) {
  final screenSize = MediaQuery.of(context).size;

  final usableHeight = screenSize.height -
      MediaQuery.of(context).viewPadding.top -
      MediaQuery.of(context).viewPadding.bottom;

  final usableWidth = screenSize.width -
      MediaQuery.of(context).viewPadding.left -
      MediaQuery.of(context).viewPadding.right;

  switch (dimension) {
    case ScreenDimension.width:
      return usableWidth;
    case ScreenDimension.height:
      return usableHeight;
    default:
      throw ArgumentError("Invalid screen dimension type");
  }
}
