import 'dart:io';

/// Outputs log message to stdout
///
/// Uses [stdout.writeln] instead of [print] to ensure proper output
/// on iOS simulators. The standard [print] function may not flush
/// its buffer properly on iOS simulators, causing logs to not appear.
void outputLog(String message) => message.split('\n').forEach(stdout.writeln);
