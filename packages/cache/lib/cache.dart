library cache;

/// An In memory cache client
class CacheClient {
  /// initialize cache
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  /// Stores the [key], [value] pair in memory
  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  /// Return value stored with [key] and null if not found
  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}
