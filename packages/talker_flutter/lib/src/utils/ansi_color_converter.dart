import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Utility class to convert AnsiPen colors to Flutter Colors
class AnsiColorConverter {
  /// Attempts to convert an AnsiPen to a Flutter Color
  /// Returns null if conversion is not possible
  static Color? tryConvertAnsiPenToColor(AnsiPen? pen) {
    if (pen == null) {
      return null;
    }

    // Try to extract color information from the AnsiPen
    // AnsiPen doesn't expose its internal state directly, so we'll
    // apply it to a test string and parse the ANSI codes
    final testString = 'test';
    final coloredString = pen(testString);

    // If the string hasn't been colored (no ANSI codes), return null
    if (coloredString == testString) {
      return null;
    }

    // Extract ANSI color codes from the colored string
    // ANSI format: \x1B[<codes>m<text>\x1B[0m
    final regex = RegExp(r'\x1B\[([0-9;]+)m');
    final match = regex.firstMatch(coloredString);

    if (match == null) {
      return null;
    }

    final codes = match.group(1)?.split(';').map(int.tryParse).whereType<int>().toList();
    if (codes == null || codes.isEmpty) {
      return null;
    }

    // Parse ANSI color codes
    // Standard colors: 30-37 (foreground), 90-97 (bright foreground)
    // 256 colors: 38;5;<n>
    // RGB colors: 38;2;<r>;<g>;<b>
    for (int i = 0; i < codes.length; i++) {
      final code = codes[i];

      // Handle 256 color mode: 38;5;<n>
      if (code == 38 && i + 2 < codes.length && codes[i + 1] == 5) {
        final colorIndex = codes[i + 2];
        return _xterm256ToColor(colorIndex);
      }

      // Handle RGB mode: 38;2;<r>;<g>;<b>
      if (code == 38 && i + 4 < codes.length && codes[i + 1] == 2) {
        final r = codes[i + 2];
        final g = codes[i + 3];
        final b = codes[i + 4];
        return Color.fromRGBO(r, g, b, 1.0);
      }

      // Handle standard foreground colors (30-37)
      if (code >= 30 && code <= 37) {
        return _standardColorToFlutter(code - 30);
      }

      // Handle bright foreground colors (90-97)
      if (code >= 90 && code <= 97) {
        return _brightColorToFlutter(code - 90);
      }
    }

    return null;
  }

  /// Converts standard ANSI color (0-7) to Flutter Color
  static Color _standardColorToFlutter(int colorIndex) {
    switch (colorIndex) {
      case 0: // Black
        return const Color(0xFF000000);
      case 1: // Red
        return const Color.fromARGB(255, 239, 83, 80);
      case 2: // Green
        return const Color(0xFF26FF3C);
      case 3: // Yellow
        return const Color.fromARGB(255, 239, 108, 0);
      case 4: // Blue
        return const Color.fromARGB(255, 66, 165, 245);
      case 5: // Magenta
        return const Color(0xFFF602C1);
      case 6: // Cyan
        return const Color(0xFF63FAFE);
      case 7: // White
        return const Color(0xFFFFFFFF);
      default:
        return Colors.grey;
    }
  }

  /// Converts bright ANSI color (0-7) to Flutter Color
  static Color _brightColorToFlutter(int colorIndex) {
    switch (colorIndex) {
      case 0: // Bright Black (Gray)
        return const Color.fromARGB(255, 158, 158, 158);
      case 1: // Bright Red
        return const Color.fromARGB(255, 255, 118, 118);
      case 2: // Bright Green
        return const Color(0xFF56FEA8);
      case 3: // Bright Yellow
        return const Color.fromARGB(255, 255, 213, 79);
      case 4: // Bright Blue
        return const Color.fromARGB(255, 100, 181, 246);
      case 5: // Bright Magenta
        return const Color(0xFFAF5FFF);
      case 6: // Bright Cyan
        return const Color(0xFF84FFFF);
      case 7: // Bright White
        return const Color(0xFFFFFFFF);
      default:
        return Colors.grey;
    }
  }

  /// Converts xterm-256 color index to Flutter Color
  /// This is a simplified conversion focusing on common colors
  static Color _xterm256ToColor(int index) {
    // System colors (0-15)
    if (index < 8) {
      return _standardColorToFlutter(index);
    }
    if (index < 16) {
      return _brightColorToFlutter(index - 8);
    }

    // 216 colors (16-231): 6x6x6 RGB cube
    if (index < 232) {
      final i = index - 16;
      final r = ((i / 36).floor() * 255 / 5).round();
      final g = (((i % 36) / 6).floor() * 255 / 5).round();
      final b = ((i % 6) * 255 / 5).round();
      return Color.fromRGBO(r, g, b, 1.0);
    }

    // Grayscale (232-255)
    if (index < 256) {
      final gray = ((index - 232) * 255 / 23).round();
      return Color.fromRGBO(gray, gray, gray, 1.0);
    }

    return Colors.grey;
  }
}
