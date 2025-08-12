import 'package:flutter/material.dart';
import 'package:shopping_app/core/routes/route_observer.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static final AppRouteObserver routeObserver = AppRouteObserver();
}
