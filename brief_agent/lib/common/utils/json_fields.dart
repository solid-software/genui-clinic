/// Typed reads of decoded JSON, throwing [FormatException] on a mismatch.
abstract final class JsonFields {
  /// [value] as an object; [name] says what it was meant to be.
  static Map<String, Object?> asObject(Object? value, String name) =>
      switch (value) {
        final Map<String, Object?> object => object,
        _ => throw FormatException('The $name must be an object.'),
      };

  /// The object under [key] in [json].
  static Map<String, Object?> object(Map<String, Object?> json, String key) =>
      asObject(json[key], "'$key'");

  /// The list under [key] in [json].
  static List<Object?> list(Map<String, Object?> json, String key) =>
      switch (json[key]) {
        final List<Object?> list => list,
        _ => throw FormatException("'$key' must be a list."),
      };

  /// The string under [key] in [json].
  static String string(Map<String, Object?> json, String key) =>
      switch (json[key]) {
        final String text => text,
        _ => throw FormatException("'$key' must be a string."),
      };
}
