import 'package:flutter/material.dart';

class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    final String routeName = route.settings.name ?? 'Unknown Route';
    final String previousRouteName = previousRoute?.settings.name ?? 'None';

    print('ROUTE PUSHED: =====> $routeName (from: $previousRouteName)');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    final String routeName = route.settings.name ?? 'Unknown Route';
    final String previousRouteName = previousRoute?.settings.name ?? 'None';

    print('ROUTE POPPED: =====> $routeName (back to: $previousRouteName)');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    final String newRouteName = newRoute?.settings.name ?? 'Unknown Route';
    final String oldRouteName = oldRoute?.settings.name ?? 'Unknown Route';

    print('ROUTE REPLACED: =====> $oldRouteName -> $newRouteName');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);

    final String routeName = route.settings.name ?? 'Unknown Route';

    print('ROUTE REMOVED: =====> $routeName');
  }
}
