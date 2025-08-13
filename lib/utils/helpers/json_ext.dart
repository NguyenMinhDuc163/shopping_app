import 'dart:developer';

/// Example:
///
/// ```dart
/// const Map<String, dynamic> json = {
///   "a": "1",
///   "b": [
///     {},
///     { "c": "2" }
///   ],
///   "d": "2022-10-01 10:15:07.922"
/// };
///
/// print(json.pick<String>(['b', 0, 'c']));  // null
/// print(json.pick<String>(['b', 1, 'c']));  // 2
///
/// print(json.query<String>('b.#0.c'));      // null
/// print(json.query<String>('b.#1.c'));      // 2
///
/// print(json.lookup<String>('a'));          // 1
///
/// print(json.getAndApply<int, String>('aa', converter: int.parse));   // null
/// print(json.getAndApplyWhen<String, int>(
///   'a', converter: (int value) => value.toString()
/// )); // 1
///
/// print(json.lookupAndApply<int, String>('a', converter: int.parse)); // 1
///
/// // Key value aaa is missing from list, [defaultValue] is used
/// print(json.lookupAndApply<int, String>(
///   'aaa', defaultValue: 10, converter: int.parse
/// )); // 10
///
/// import 'package:intl/intl.dart';
///
/// print(json.lookupAndApply2<String, String, DateTime>(
///   'd',
///   converter1: DateTime.parse,
///   converter2: DateFormat('dd/MM/yyyy').format
/// )); // 01/10/2022print(json.getAndApply2<String, String, DateTime>(
///   'dd',
///   converter1: DateTime.parse,
///   converter2: DateFormat('dd/MM/yyyy').format
/// )); // null
/// ```
extension JsonExt on Map<String, dynamic> {
  /// Extract required value from specific keys or index (of nested List
  /// inside Map). (Like [g_json](https://pub.dev/packages/g_json) package).
  ///
  /// If the key is present, its type is not [R], throw an exception.
  ///
  /// Support optional key by using `?` character/operator.
  ///
  /// Support getting an item in a List by giving the item index.
  ///
  /// Example:
  ///
  /// ```dart
  /// const Map<String, dynamic> json = {
  ///   "a": 1,
  ///   "b": [
  ///     { "c": "2" },
  ///     { "d": 3   }
  ///   ]
  /// };
  ///
  /// print(json.pick<int>(['b', 0, 'd'])); // null
  /// print(json.pick<int>(['b', 1, 'd'])); // 3
  /// ```
  R? pick<R>(List keys) {
    final value = _pick(keys);

    return value;
  }

  R? _pick<R>(List keys) {
    bool foundOptionalValue = false;
    final value = keys.foldWithPrevElem<dynamic, dynamic>(this, (source, target, previousTarget) {
      if (source is Map) {
        foundOptionalValue = target is String && target.endsWith('?');

        final effectiveTarget = foundOptionalValue ? target.substring(0, target.length - 1) : target;

        if (keys.last == target) {
          foundOptionalValue = true;
        }

        return source.lookup(effectiveTarget, foundOptionalValue);
      }

      if (source is List) {
        foundOptionalValue = false;

        final int index;
        if (target is String) {
          assert(
            target.startsWith('#'),
            "\"$previousTarget\" is a List, expecting an index to start with the # sign (ex: #0, #1)",
          );

          index = int.parse(target.substring(1));
        } else {
          index = target;
        }

        assert(
          index < source.length,
          "\"$previousTarget\" length is ${source.length}, index at $index is out of range",
        );

        return source[index];
      }

      if (source == null && foundOptionalValue) {
        return null;
      }

      throw FormatException(
        "Mismatch for \"$target\": found \"${source.runtimeType}\"",
      );
    });

    if (value == null) {
      return null;
    }

    if (value is! R) {
      _valueTypeIsMismatch<R>(keys.last, value);
    }

    return value;
  }

  /// Extract required value from specific keys or index (of nested List
  /// inside Map).
  ///
  /// If the value is not present, [ifAbsent] is called to get
  /// a computed/altered value. Otherwise, return `null` if not provided.
  ///
  /// If the value is present, invoke [converter] with the current value.
  /// The output of [converter] MUST `non-null`.
  ///
  /// Example:
  ///
  /// ```dart
  /// const Map<String, dynamic> json = {
  ///   "a": "1",
  ///   "b": {
  ///     "c": "2",
  ///     "d": {
  ///       "e": "3"
  ///     }
  ///   }
  /// };
  ///
  /// print(json.pickAndApply<int, String>(
  ///   ['b', 'd', 'e'],
  ///   converter: int.parse,
  /// )); // 3
  ///
  /// // Key value `ff` is missing from `json`, `null` is returned
  /// print(json.pickAndApply<int, String>(
  ///   ['b', 'd', 'ff'],
  ///   converter: int.parse,
  /// )); // null
  ///
  /// // Key value `ff` is missing from `json`, `null` is returned
  /// print(json.pickAndApply<int, String>(
  ///   ['b', 'd', 'ff?', 'gg'],
  ///   converter: int.parse
  /// )); // null
  ///
  /// // Key value `aa` is missing from `json`, [ifAbsent] is used
  /// print(json.pickAndApply<int, String>(
  ///   ['aa'],
  ///   ifAbsent: () => '10',
  ///   converter: int.parse,
  /// )); // 10
  ///
  /// // Key value e has value type of `String`, an exception is throw
  /// print(json.pickAndApply<int, String>(
  ///   ['b', 'd', 'e?', 'gg'],
  ///   converter: int.parse
  /// )); // Uncaught Error: FormatException: Mismatch for "gg": found "String"
  /// ```
  /// See also:
  ///   * [pick]
  R? pickAndApply<R, V>(
    List keys, {
    V Function()? ifAbsent,
    bool Function(V value)? vetoable,
    required R Function(V value) converter,
  }) {
    final value = _pick(keys) ?? ifAbsent?.call();
    if (value == null) {
      return null;
    }

    if (vetoable?.call(value) == true) {
      return null;
    }

    return converter(value);
  }

  /// Extract required value from specific keys or index (of nested List
  /// inside Map).
  ///
  /// If the value is not present, call [ifAbsent] to get a
  /// computed/altered value. Otherwise, return `null` if not provided.
  ///
  /// If the value is present, invokes [converter1] with
  /// the current value, then invokes [converter2] with the output of
  /// [converter1]. The output of [converter2] MUST `non-null`.
  ///
  /// Example:
  ///
  /// ```dart
  /// import 'package:intl/intl.dart';
  ///
  /// const Map<String, dynamic> json = {
  ///   "a": "1",
  ///   "b": {
  ///     "time": "2022-10-01 10:15:07.922"
  ///   },
  ///   "c": 0,
  ///   "d": 5,
  ///   "e": -2
  /// };
  ///
  /// print(json.pickAndApply2<String, String, DateTime>(
  ///   ['b', 'time'],
  ///   converter1: DateTime.parse,
  ///   converter2: DateFormat('dd/MM/yyyy').format
  /// )); // 01/10/2022
  ///
  /// // Key value `datetime` is missing from `json`, `null` is returned
  /// print(json.pickAndApply2<String, String, DateTime>(
  ///   ['b', 'datetime'],
  ///   converter1: DateTime.parse,
  ///   converter2: DateFormat('dd/MM/yyyy').format
  /// )); // null
  ///
  /// print(json.pickAndApply2<String, int>(
  ///   ['c'],
  ///   converter: (value) => value > 0 ? value.toString() : '--',
  /// )); // --
  ///
  /// print(json.pickAndApply2<String, int>(
  ///   ['d'],
  ///   converter: (value) => value > 0 ? value.toString() : '--',
  /// )); // 5
  ///
  /// print(json.pickAndApply2<String, int>(
  ///   ['e'],
  ///   vetoable: (value) => value <= 0
  ///   converter: (value) => value.toString(),
  /// )); // null
  /// ```
  /// See also:
  ///   * [pick]
  R? pickAndApply2<R, V, CR>(
    List keys, {
    V Function()? ifAbsent,
    bool Function(V value)? vetoable,
    required CR Function(V value) converter1,
    required R Function(CR value) converter2,
  }) {
    final value = _pick(keys) ?? ifAbsent?.call();
    if (value == null) {
      return null;
    }

    if (vetoable?.call(value) == true) {
      return null;
    }

    return converter2(converter1(value));
  }

  /// Extract required value from specific paths like
  /// [path_selector](https://pub.dev/packages/path_selector) package.
  ///
  /// Each key is separated by dot character/operator.
  ///
  /// Support optional chaining.
  ///
  /// Support getting an item in a List by using `#` with the item index.
  ///
  /// Example:
  ///
  /// ```dart
  /// const Map<String, dynamic> json = {
  ///   "a": 1,
  ///   "b": [
  ///     { "c": "2" },
  ///     { "d": 3   }
  ///   ]
  /// };
  ///
  /// print(json.query<int>('b.#1.d')); // 3
  /// ```
  R? query<R>(String keys) => pick<R>(keys.split('.'));

  /// Extract required value from specific keys or index (of nested List
  /// inside Map).
  ///
  /// If the value is not present, [ifAbsent] is called to get
  /// a computed/altered value. Otherwise, return `null` if not provided.
  ///
  /// If the value is present, invoke [converter] with the current value.
  ///
  /// Example:
  ///
  /// ```dart
  /// const Map<String, dynamic> json = {
  ///   "a": "1",
  ///   "b": {
  ///     "c": "2",
  ///     "d": {
  ///       "e": "3"
  ///     }
  ///   }
  /// };
  ///
  /// print(json.queryAndApply<int, String>(
  ///   'b.d.e',
  ///   converter: int.parse,
  /// )); // 3
  ///
  /// // Key value ff is missing from `json`, `null` is returned
  /// print(json.queryAndApply<int, String>(
  ///   'b.d.ff',
  ///   converter: int.parse,
  /// )); // null
  ///
  /// // Key value gg is missing from `json`, `null` is returned
  /// print(json.queryAndApply<int, String>(
  ///   'b.d.ff?.gg',
  ///   converter: int.parse
  /// )); // null
  ///
  /// // Key value `aa` is missing from `json`, [ifAbsent] is used.
  /// print(json.queryAndApply<int, String>(
  ///   'aa',
  ///   ifAbsent: () => '10',
  ///   converter: int.parse,
  /// )); // 10
  /// ```
  /// See also:
  ///   * [query]
  R? queryAndApply<R, V>(
    String keys, {
    V Function()? ifAbsent,
    bool Function(V value)? vetoable,
    required R Function(V) converter,
  }) =>
      pickAndApply<R, V>(
        keys.split('.'),
        ifAbsent: ifAbsent,
        vetoable: vetoable,
        converter: converter,
      );

  /// Extract required value from specific keys or index (of nested List
  /// inside Map).
  ///
  /// If the value is not present, call [ifAbsent] to get a
  /// computed/altered value. Otherwise, return `null` if not provided.
  ///
  /// If the value is present, invokes [converter1] with
  /// the current value, then invokes [converter2] with the output of
  /// [converter1]. The output of [converter2] MUST `non-null`.
  ///
  /// Example:
  ///
  /// ```dart
  /// import 'package:intl/intl.dart';
  ///
  /// const Map<String, dynamic> json = {
  ///   "a": "1",
  ///   "b": {
  ///     time": "2022-10-01 10:15:07.922"
  ///   },
  ///   "e": -1,
  /// };
  ///
  /// print(json.queryAndApply2<String, String, DateTime>(
  ///   'b.time',
  ///   converter1: DateTime.parse,
  ///   converter2: DateFormat('dd/MM/yyyy').format
  /// )); // 01/10/2022
  ///
  /// // Key value `datetime` is missing from `json`, `null` is returned
  /// print(json.queryAndApply2<String, String, DateTime>(
  ///   'b.datetime',
  ///   converter1: DateTime.parse,
  ///   converter2: DateFormat('dd/MM/yyyy').format
  /// )); // null
  ///
  /// print(json.queryAndApply2<String, int>(
  ///   'e',
  ///   vetoable: (value) => value <= 0
  ///   converter: (value) => value.toString(),
  /// )); // null
  /// ```
  /// See also:
  ///   * [query]
  R? queryAndApply2<R, V, CR>(
    String keys, {
    V Function()? ifAbsent,
    bool Function(V value)? vetoable,
    required CR Function(V value) converter1,
    required R Function(CR value) converter2,
  }) =>
      pickAndApply2<R, V, CR>(
        keys.split('.'),
        ifAbsent: ifAbsent,
        vetoable: vetoable,
        converter1: converter1,
        converter2: converter2,
      );

  /// Look up the value of [key], or return [defaultValue] if it isn't there.
  ///
  /// Example:
  ///
  /// ```dart
  /// const Map<String, dynamic> json = {
  ///   "a": "1",
  ///   "b": "2"
  /// };
  ///
  /// print(json.lookup<String>('a'));  // 1
  /// ```
  R lookup<R>(
    String key, {
    R? defaultValue,
  }) {
    final value = this[key];
    if (value == null) {
      if (defaultValue != null) {
        return defaultValue;
      }

      _valueIsNull<R>(key);
    }

    if (value is! R) {
      _valueTypeIsMismatch<R>(key, value);
    }

    return value;
  }

  /// Look up the value of [key] with type [V], or call [ifAbsent] if it isn't
  /// there to get a computed/altered value. Otherwise, return null if not
  /// provided.
  ///
  /// If the key is present, invoke [converter] with the associated value.
  /// The output of [converter] MUST `non-null`.
  ///
  /// If the key is not present, [ifAbsent] is not provided and [defaultValue]
  /// is provided, returns [defaultValue].
  ///
  /// If the key is not present, [ifAbsent] is not provided, and [defaultValue]
  /// is not provided, throw an exception.
  ///
  /// Example:
  ///
  /// ```dart
  /// const Map<String, dynamic> json = {
  ///   "a": "1",
  ///   "b": "2"
  /// };
  ///
  /// print(json.lookupAndApply<int, String>('a', converter: int.parse)); // 1
  ///
  /// // Key value `aaa` is missing from `json`, [defaultValue] is used
  /// print(json.lookupAndApply<int, String>(
  ///   'aaa', defaultValue: 10, converter: int.parse
  /// )); // 10
  /// ```
  R lookupAndApply<R extends Object, V>(
    String key, {
    R? defaultValue,
    V Function()? ifAbsent,
    required R Function(V value) converter,
  }) {
    final value = this[key] ?? ifAbsent?.call();
    if (value == null) {
      if (defaultValue != null) {
        return defaultValue;
      }

      _valueIsNull<R>(key);
    }

    return converter(value);
  }

  /// Look up the value of [key] with type [V], or call [ifAbsent] if it isn't
  /// there to get a computed/altered value. Otherwise, return [defaultValue]
  /// if provided.
  ///
  /// If the key is present, invokes [converter1] with the current value,
  /// then invokes [converter2] with the output of [converter1].
  /// The output of [converter2] MUST `non-null`.
  ///
  /// If the key is not present, [ifAbsent] is not provided and [defaultValue]
  /// is provided, returns [defaultValue].
  ///
  /// If the key is not present, [ifAbsent] is not provided, and [defaultValue]
  /// is not provided, throw an exception.
  ///
  /// Example:
  ///
  /// ```dart
  /// const Map<String, dynamic> json = {
  ///   "time": "2022-10-01 10:15:07.922"
  /// };
  ///
  /// print(json.lookupAndApply2<String, String, DateTime>(
  ///   'time',
  ///   converter1: DateTime.parse,
  ///   converter2: DateFormat('dd/MM/yyyy').format
  /// )); // 01/10/2022
  /// ```
  R lookupAndApply2<R extends Object, V extends Object, CR>(
    String key, {
    R? defaultValue,
    V Function()? ifAbsent,
    required CR Function(V value) converter1,
    required R Function(CR value) converter2,
  }) {
    final value = this[key] ?? ifAbsent?.call();

    if (value == null) {
      if (defaultValue != null) {
        return defaultValue;
      }

      _valueIsNull<R>(key);
    }

    assert(value is V);

    return converter2(converter1(value));
  }

  /// Get the value of [key], or call [ifAbsent] if it isn't there to get
  /// a computed/altered value. Otherwise, return `null` if not provided.
  ///
  /// If the key is present, invoke [converter] if provided with
  /// the current value. The output of [converter] MUST `non-null`.
  ///
  /// Example:
  ///
  /// ```dart
  /// const Map<String, dynamic> json = {
  ///   "a": "1",
  ///   "b": "2"
  /// };
  ///
  /// print(json.getAndApply<int, String>('a', converter: int.parse)); // 1
  ///
  /// // Key value `aa` is missing from `json`, `null` is returned
  /// print(json.getAndApply<int, String>('aa', converter: int.parse)); // null
  ///
  /// // Key value `aa` is missing from `json`, [ifAbsent] is used.
  /// print(json.getAndApply<int, String>(
  ///   'aa',
  ///   ifAbsent: () => '10',
  ///   converter: int.parse,
  /// )); // 10
  /// ```
  R? getAndApply<R, V>(
    String key, {
    V Function()? ifAbsent,
    R Function(V value)? converter,
  }) {
    final value = this[key] ?? ifAbsent?.call();
    if (value == null) {
      return null;
    }

    if (converter != null) {
      return converter(value);
    }

    return value;
  }

  /// Get the value of [key], or return null if it is not provided.
  ///
  /// If the key is present, its type is not [R], invokes [converter] if
  /// provided with the current value.
  ///
  /// If the key is present, its type is not [R], and [converter] is not
  /// provided, throw an exception.
  ///
  /// Example:
  ///
  /// ```dart
  /// const Map<String, dynamic> json = {
  ///   "a": 1,
  ///   "b": 2
  /// };
  ///
  /// print(json.getAndApplyWhen<String, int>(
  ///   'a', converter: (int value) => value.toString()
  /// )); // 1
  /// ```
  R? getAndApplyWhen<R, V>(
    String key, {
    R? Function(V value)? converter,
  }) {
    final value = this[key];
    if (value == null) {
      return null;
    }

    if (value is! R) {
      if (converter != null) {
        return converter(value);
      }

      _valueTypeIsMismatch<R>(key, value);
    }

    return value;
  }

  /// Get the value of [key], or call [ifAbsent] if it isn't there to get a
  /// computed/altered value. Otherwise, return null if it is not provided.
  ///
  /// If the key is present, invokes [converter1] with the current value,
  /// then invokes [converter2] with the output of [converter1].
  /// The output of [converter2] MUST `non-null`.
  ///
  /// Example:
  ///
  /// ```dart
  /// const Map<String, dynamic> json = {
  ///   "time": "2022-10-01 10:15:07.922"
  /// };
  ///
  /// print(json.getAndApply2<String, String, DateTime>(
  ///   'time',
  ///   converter1: DateTime.parse,
  ///   converter2: DateFormat('dd/MM/yyyy').format
  /// )); // 01/10/2022
  ///
  /// // Key value `datetime` is missing from `json`, `null` is returned
  /// print(json.getAndApply2<String, String, DateTime>(
  ///   'datetime',
  ///   converter1: DateTime.parse,
  ///   converter2: DateFormat('dd/MM/yyyy').format
  /// )); // null
  /// ```
  R? getAndApply2<R, V, CR>(
    String key, {
    V Function()? ifAbsent,
    required CR Function(V value) converter1,
    required R Function(CR value) converter2,
  }) {
    final value = this[key] ?? ifAbsent?.call();
    if (value == null) {
      return null;
    }

    return converter2(converter1(value));
  }
}

extension JsonArrayExtension on Iterable {
  static List<R> Function(Iterable array) listOf<R, E>(R Function(Map<String, dynamic> json) mapper) {
    return (Iterable array) {
      return array.mapJsonTo(mapper);
    };
  }

  static List<R> Function(Iterable array) notNullFilteredListOf<R, E>(
    R? Function(Map<String, dynamic> json) mapper, {
    bool ignoreError = true,
  }) {
    return (Iterable array) {
      return array.mapNullableJsonTo(mapper, ignoreError: ignoreError);
    };
  }

  List<R> mapJsonTo<R>(R Function(Map<String, dynamic> json) mapper) {
    return map((e) {
      final Map<String, dynamic> json = Map.castFrom(e);

      return mapper(json);
    }).toList();
  }

  List<R> mapNullableJsonTo<R>(
    R? Function(Map<String, dynamic> json) mapper, {
    bool ignoreError = true,
  }) {
    return map((e) {
      try {
        final Map<String, dynamic> json = Map.castFrom(e);

        return mapper(json);
      } catch (ex) {
        if (ignoreError) {
          log("$ex\nIGNORING ELEMENT: $e", name: 'mapNullableJsonTo');
          return null;
        }

        rethrow;
      }
    }).whereType<R>().toList();
  }
}

extension on Map {
  R? lookup<R extends Object?>(String key, bool nullable) {
    final value = this[key];
    if (value == null) {
      if (nullable) return null;

      _valueIsNull<R>(key);
    }

    if (value is! R) {
      _valueTypeIsMismatch<R>(key, value);
    }

    return value;
  }
}

extension on List {
  T foldWithPrevElem<T, E>(
    T initialValue,
    // ignore: use_function_type_syntax_for_parameters
    T combine(T previousValue, E element, E? previousElement),
  ) {
    var value = initialValue;
    E? oldElement;
    for (E element in this) {
      value = combine(value, element, oldElement);
      oldElement = element;
    }
    return value;
  }
}

Never _valueIsNull<R>(key) => _valueTypeIsMismatch<R>(key, null);

Never _valueTypeIsMismatch<R>(key, current) {
  throw FormatException(
    "Mismatch for \"$key\": expected '$R', found '${current.runtimeType}'",
  );
}
