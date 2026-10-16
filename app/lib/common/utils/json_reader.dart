/// Lenient reads from untyped JSON: stored data and model payloads.
///
/// Missing or mistyped keys give fallbacks so bad data cannot break a build.
extension JsonReader on Map<String, Object?> {
  /// A string, or [fallback].
  String readString(String key, {String fallback = ''}) {
    final Object? value = this[key];

    return value is String ? value : fallback;
  }

  /// A non-blank string, or `null`.
  String? readOptionalString(String key) {
    final Object? value = this[key];

    return value is String && value.trim().isNotEmpty ? value : null;
  }

  /// An integer from any number, or [fallback].
  int readInt(String key, {int fallback = 0}) =>
      readOptionalInt(key) ?? fallback;

  /// An integer from any number, or `null`.
  int? readOptionalInt(String key) => _number(key)?.toInt();

  /// A double from any number, or [fallback].
  double readDouble(String key, {double fallback = 0.0}) =>
      readOptionalDouble(key) ?? fallback;

  /// A double from any number, or `null`.
  double? readOptionalDouble(String key) => _number(key)?.toDouble();

  /// A boolean, or [fallback].
  bool readBool(String key, {bool fallback = false}) {
    final Object? value = this[key];

    return value is bool ? value : fallback;
  }

  /// An ISO-8601 date, or [fallback], or the epoch.
  DateTime readDate(String key, {DateTime? fallback}) =>
      readOptionalDate(key) ??
      fallback ??
      DateTime.fromMillisecondsSinceEpoch(0);

  /// An ISO-8601 date, or `null`.
  DateTime? readOptionalDate(String key) {
    final Object? value = this[key];

    return value is String ? DateTime.tryParse(value) : null;
  }

  /// A nested object, or an empty map.
  Map<String, Object?> readObject(String key) =>
      _stringKeyed(this[key]) ?? <String, Object?>{};

  /// The strings in a list, skipping anything else.
  List<String> readStringList(String key) =>
      _list(key).whereType<String>().toList();

  /// The whole numbers in a list, skipping anything else.
  List<int> readIntList(String key) =>
      _list(key).whereType<num>().map((value) => value.toInt()).toList();

  /// The objects in a list, skipping anything else.
  List<Map<String, Object?>> readObjectList(String key) =>
      _list(key).map(_stringKeyed).nonNulls.toList();

  /// The objects in a list, each read with [fromJson].
  List<T> readList<T>(
    String key,
    T Function(Map<String, Object?> json) fromJson,
  ) => readObjectList(key).map(fromJson).toList();

  num? _number(String key) {
    final Object? value = this[key];

    return value is num ? value : null;
  }

  List<Object?> _list(String key) {
    final Object? value = this[key];

    return value is List<Object?> ? value : const <Object?>[];
  }

  static Map<String, Object?>? _stringKeyed(Object? value) =>
      value is Map<Object?, Object?>
      ? value.map(
          (key, entry) => MapEntry<String, Object?>('$key', entry),
        )
      : null;
}
