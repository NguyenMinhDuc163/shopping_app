import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'in_memory_cache_client.dart';

class SecureStorage {
  late final FlutterSecureStorage _storage;

  /// The cache that holds all preferences.
  ///
  /// It is NOT guaranteed that this cache and the device prefs will remain
  /// in sync since the setter method might fail for any reason.
  late final InMemoryCacheClient _cacheClient;

  static SecureStorage? _instance;

  factory SecureStorage({
    bool? shouldReset,
  }) =>
      _instance ??= SecureStorage._(shouldReset ?? false);

  SecureStorage._(bool shouldReset)
      : _storage = FlutterSecureStorage(
          aOptions: AndroidOptions.defaultOptions.copyWith(
            encryptedSharedPreferences: true,
          ),
        ),
        _cacheClient = InMemoryCacheClient() {
    if (shouldReset) {
      _storage.deleteAll();
    }
  }

  Future<bool> containsKey(String key) => _storage.containsKey(key: key);

  Future<String?> read(String key) async {
    final String? oldCache = _cacheClient.read(key);
    if (oldCache != null) {
      return oldCache;
    }

    final result = await _storage.read(key: key);

    if (result != null) {
      _cacheClient.write(key: key, value: result);
    }

    return _cacheClient.read(key);
  }

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
    _cacheClient.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
    _cacheClient.delete(key);
  }

  /// Fetches the latest values from the host platform.
  ///
  /// Use this method to observe modifications that were made in native code
  /// (without using the plugin) while the app is running.
  Future<void> reload() async {
    _cacheClient.clear();
    _cacheClient.writeAll(await _storage.readAll());
  }
}
