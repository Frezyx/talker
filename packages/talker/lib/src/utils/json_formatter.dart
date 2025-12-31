import 'dart:convert';

const _defaultEncoder = JsonEncoder.withIndent('  ');

/// Formatter for converting data to pretty JSON strings.
///
/// Use `const TalkerJsonFormatter()` for standard JSON formatting,
/// `TalkerJsonFormatter(stripQuotes: true)` to strip quotes,
/// or `TalkerJsonFormatter.custom(fn)` for custom formatting.
class TalkerJsonFormatter {
  /// Creates a formatter with optional quote stripping.
  ///
  /// If [stripQuotes] is true, double quotes will be stripped from
  /// the JSON output (except escaped quotes within values).
  const TalkerJsonFormatter({this.stripQuotes = false})
      : _customFormatter = null;

  /// Creates a formatter with a custom formatting function.
  const TalkerJsonFormatter.custom(this._customFormatter) : stripQuotes = false;

  /// Whether to strip double quotes from JSON output.
  final bool stripQuotes;

  final String Function(dynamic data)? _customFormatter;

  /// Formats the given data to a pretty JSON string.
  String format(dynamic data) {
    if (_customFormatter != null) {
      return _customFormatter!(data);
    }
    final json = _defaultEncoder.convert(data);
    if (stripQuotes) {
      return json
          .replaceAll(r'\"', '\x00')
          .replaceAll('"', '')
          .replaceAll('\x00', '"');
    }
    return json;
  }
}
