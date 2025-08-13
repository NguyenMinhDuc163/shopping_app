/// {@template cache_client}
/// An in-memory cache client.
/// {@endtemplate}
class InMemoryCacheClient {
  /// {@macro cache_client}
  InMemoryCacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  T? read<T extends Object>(String key) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }

  /// Writes the provide [key], [value] pair to the in-memory cache.
  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  /// Writes the provide [key], [value] pair to the in-memory cache.
  void writeAll<T extends Object>(Map<String, T> value) {
    _cache.addAll(value);
  }

  /// Returns the value associated with `key` before it was removed.
  ///
  /// A returned `null` value doesn't always mean that the key was absent.
  T? delete<T extends Object>(String key) {
    return _cache.remove(key) as T?;
  }

  void clear() {
    _cache.clear();
  }
}
