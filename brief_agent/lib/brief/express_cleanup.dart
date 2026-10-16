import 'package:a2ui_agent/a2ui_agent.dart';

/// Cleans up the slips Gemini makes in Express before it is compiled:
///
/// - a colon after an argument name in a call (`caption: "x"`) and an equals
///   sign after a key in a map (`{tone="warning"}`) are swapped back;
/// - a map entry written as null (`"image": null`) is left out, as Express
///   leaves out a property written as null.
///
/// None of these is valid Express, so a valid block comes back unchanged.
/// Strings, comments and data paths are skipped. Fixes keep every offset and
/// line break, so a syntax error still points at the right place.
class ExpressCleanup {
  static final RegExp _identifierStart = RegExp('[a-zA-Z_]');
  static final RegExp _identifierPart = RegExp('[a-zA-Z0-9_]');
  static final RegExp _pathPart = RegExp('[a-zA-Z0-9_/]');
  static final RegExp _space = RegExp(r'\s');

  static const String _tripleQuote = '"""';
  static const String _blockCommentStart = '/*';
  static const String _blockCommentEnd = '*/';
  static const String _null = 'null';

  /// A backslash and the character it escapes.
  static const int _escapeLength = 2;

  /// The wrong separator inside each bracket, and the one it should be.
  static const Map<String, (String, String)> _swaps =
      <String, (String, String)>{'(': (':', '='), '{': ('=', ':')};

  static const Set<String> _opening = <String>{'(', '[', '{'};
  static const Set<String> _closing = <String>{')', ']', '}'};

  final String _source;
  final List<String> _brackets = <String>[];
  final Map<int, String> _replacements = <int, String>{};
  int _fixes = 0;
  int _i = 0;

  ExpressCleanup._(this._source);

  /// [express] with its slips cleaned up, and how many there were.
  static ({String express, int fixes}) clean(String express) =>
      ExpressCleanup._(express)._run();

  /// [reply] with each Express block [parser] finds in it cleaned up, and
  /// how many slips there were. Text outside the blocks is left alone, and a
  /// reply with no slips comes back as it was.
  static ({String reply, int fixes}) cleanReply(Parser parser, String reply) {
    int fixes = 0;
    final List<RawResponsePart> parts = <RawResponsePart>[];
    for (final RawResponsePart part in parser.unwrap(reply)) {
      if (part is RawA2uiPart) {
        final ({String express, int fixes}) cleaned = clean(part.a2uiRaw);
        fixes += cleaned.fixes;
        parts.add(RawA2uiPart(cleaned.express, isFinal: part.isFinal));
      } else {
        parts.add(part);
      }
    }

    return (reply: fixes == 0 ? reply : parser.wrap(parts), fixes: fixes);
  }

  ({String express, int fixes}) _run() {
    while (_i < _source.length) {
      _step();
    }
    if (_fixes == 0) return (express: _source, fixes: 0);
    final StringBuffer cleaned = StringBuffer();
    for (int i = 0; i < _source.length; i++) {
      cleaned.write(_replacements[i] ?? _source[i]);
    }

    return (express: cleaned.toString(), fixes: _fixes);
  }

  /// Moves past the token at the cursor, as the Express lexer reads it.
  void _step() {
    final String c = _source[_i];
    if (c == '"') {
      final int end = _stringEnd(_i, isRaw: false);
      _dropNullEntry(_i, end);
      _i = end;
    } else if (c == '#' || _source.startsWith('//', _i)) {
      final int end = _source.indexOf('\n', _i);
      _i = end < 0 ? _source.length : end;
    } else if (_source.startsWith(_blockCommentStart, _i)) {
      final int end = _source.indexOf(
        _blockCommentEnd,
        _i + _blockCommentStart.length,
      );
      _i = end < 0 ? _source.length : end + _blockCommentEnd.length;
    } else if (c == r'$') {
      _i = _end(_pathPart, _i + 1);
    } else if (_identifierStart.hasMatch(c)) {
      _i = _wordEnd(_i);
    } else {
      _bracket(c);
      _i++;
    }
  }

  /// Moves past the word at [start]: the prefix of a raw string, or a name
  /// whose map entry or misplaced separator is cleaned up.
  int _wordEnd(int start) {
    final String c = _source[start];
    if ((c == 'r' || c == 'R') && _source.startsWith('"', start + 1)) {
      return _stringEnd(start + 1, isRaw: true);
    }
    final int end = _end(_identifierPart, start + 1);
    if (!_dropNullEntry(start, end)) {
      _fixSeparatorAt(_end(_space, end));
    }

    return end;
  }

  /// Blanks the map entry whose key spans [keyStart] to [keyEnd], with its
  /// comma, if its value is null.
  bool _dropNullEntry(int keyStart, int keyEnd) {
    final int separator = _end(_space, keyEnd);
    final int? valueEnd =
        _brackets.lastOrNull == '{' && _isMapSeparator(_charAt(separator))
        ? _nullEnd(_end(_space, separator + 1))
        : null;
    if (valueEnd == null) return false;
    final int next = _end(_space, valueEnd);
    _blank(keyStart, _charAt(next) == ',' ? next + 1 : valueEnd);
    _fixes++;

    return true;
  }

  void _fixSeparatorAt(int index) {
    if (_swaps[_brackets.lastOrNull]
        case (final String wrong, final String right)
        when _charAt(index) == wrong) {
      _replacements[index] = right;
      _fixes++;
    }
  }

  void _bracket(String c) {
    if (_opening.contains(c)) {
      _brackets.add(c);
    } else if (_closing.contains(c) && _brackets.isNotEmpty) {
      _brackets.removeLast();
    }
  }

  /// The end of the `null` at [index], or null if no `null` is there.
  int? _nullEnd(int index) {
    final int end = index + _null.length;

    return _source.startsWith(_null, index) &&
            !_identifierPart.hasMatch(_charAt(end))
        ? end
        : null;
  }

  /// Blanks [start] to [end], keeping line breaks so lines still match.
  void _blank(int start, int end) {
    for (int i = start; i < end; i++) {
      if (_source[i] != '\n') {
        _replacements[i] = ' ';
      }
    }
  }

  /// The character at [index], or an empty string past the end.
  String _charAt(int index) => index < _source.length ? _source[index] : '';

  /// The first index at or after [from] that [pattern] does not match.
  int _end(RegExp pattern, int from) {
    int i = from;
    while (i < _source.length && pattern.hasMatch(_source[i])) {
      i++;
    }

    return i;
  }

  /// The index just past the string whose opening quote is at [quote].
  int _stringEnd(int quote, {required bool isRaw}) {
    final String delimiter = _source.startsWith(_tripleQuote, quote)
        ? _tripleQuote
        : '"';
    int i = quote + delimiter.length;
    while (i < _source.length) {
      if (!isRaw && _source[i] == r'\') {
        i += _escapeLength;
      } else if (_source.startsWith(delimiter, i)) {
        return i + delimiter.length;
      } else {
        i++;
      }
    }

    return _source.length;
  }

  /// Whether [c] separates a map key from its value, rightly or not.
  static bool _isMapSeparator(String c) => c == ':' || c == '=';
}
