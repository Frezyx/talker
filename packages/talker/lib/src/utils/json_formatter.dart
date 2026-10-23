import 'dart:convert';

const _compactEncoder = JsonEncoder();
const _defaultEncoder = JsonEncoder.withIndent('  ');

/// Formatter for converting data to pretty JSON strings.
///
/// Use `const TalkerJsonFormatter()` for standard JSON formatting,
/// `TalkerJsonFormatter(prettyPrint: false)` for compact single-line JSON,
/// `TalkerJsonFormatter(stripQuotes: true)` to strip quotes,
/// or `TalkerJsonFormatter.custom(fn)` for custom formatting.
class TalkerJsonFormatter {
  /// Creates a formatter with optional quote stripping and pretty printing.
  ///
  /// If [stripQuotes] is true, double quotes will be stripped from
  /// the JSON output (except escaped quotes within values).
  const TalkerJsonFormatter({
    this.stripQuotes = false,
    this.prettyPrint = true,
  }) : _customFormatter = null;

  /// Creates a formatter with a custom formatting function.
  const TalkerJsonFormatter.custom(this._customFormatter)
      : stripQuotes = false,
        prettyPrint = true;

  /// Whether to strip double quotes from JSON output.
  final bool stripQuotes;

  /// Whether to format JSON with indentation.
  final bool prettyPrint;

  final String Function(dynamic data)? _customFormatter;

  /// Formats the given data to a pretty JSON string.
  String format(dynamic data) {
    if (_customFormatter != null) {
      return _customFormatter!(data);
    }
    final json =
        (prettyPrint ? _defaultEncoder : _compactEncoder).convert(data);
    if (stripQuotes) {
      // Use \x00 (null byte) as a temporary placeholder for escaped quotes.
      // This is safe because JsonEncoder escapes control characters (U+0000-U+001F)
      // as \uXXXX sequences, so \x00 never appears in valid JSON output.
      return json
          .replaceAll(r'\"', '\x00')
          .replaceAll('"', '')
          .replaceAll('\x00', '"');
    }
    return json;
  }
}
