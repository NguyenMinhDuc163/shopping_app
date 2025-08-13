class AppAuthenticationBinding {
  static AppAuthenticationBinding? get instance => _instance;
  static AppAuthenticationBinding? _instance;

  static void initInstance() => _instance = AppAuthenticationBinding._();

  AppAuthenticationBinding._();

  final Set<AppAuthenticationBindingObserver> _observers =
      <AppAuthenticationBindingObserver>{};

  void addObserver(AppAuthenticationBindingObserver observer) =>
      _observers.add(observer);

  bool removeObserver(AppAuthenticationBindingObserver observer) {
    final result = _observers.remove(observer);
    return result;
  }

  void notifyAuthenticated() {
    for (final AppAuthenticationBindingObserver observer in _observers) {
      observer.didAuthenticated();
    }
  }

  void notifyUnauthenticated() {
    for (final AppAuthenticationBindingObserver observer in _observers) {
      observer.didUnauthenticated();
    }
  }

  void notifyTokenChanged() {
    for (final AppAuthenticationBindingObserver observer in _observers) {
      observer.didChangeAccessToken();
    }
  }

  void notifyAuthenticationFailed() {
    for (final AppAuthenticationBindingObserver observer in _observers) {
      observer.didAuthenticationFailed();
    }
  }

  void notifyLocked() {
    for (final AppAuthenticationBindingObserver observer in _observers) {
      observer.didLock();
    }
  }

  void notifyRefershTokenExpired() {
    for (final AppAuthenticationBindingObserver observer in _observers) {
      observer.didRefershTokenExpired();
    }
  }
}

abstract class AppAuthenticationBindingObserver {
  void didAuthenticated() {}

  void didUnauthenticated() {}

  void didChangeAccessToken() {}

  void didAuthenticationFailed() {}

  void didLock() {}

  void didRefershTokenExpired() {}
}
