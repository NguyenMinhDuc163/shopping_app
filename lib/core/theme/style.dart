import 'package:flutter/material.dart';


double heightScreen(context) => MediaQuery.of(context).size.height;

double widthScreen(context) => MediaQuery.of(context).size.width;

Color colorPrimaryTheme(context) => Theme.of(context).colorScheme.primary;

Color colorSecondaryTheme(context) => Theme.of(context).colorScheme.secondary;

double maxHeightBottomSheet(context) => MediaQuery.of(context).size.height * 0.85;

