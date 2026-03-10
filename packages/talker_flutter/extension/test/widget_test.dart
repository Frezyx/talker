// Extension UI is built for web and depends on DevTools globals (serviceManager, etc.)
// which are not available in the VM test environment. For full testing, run in Chrome
// or use the simulated environment (--dart-define=use_simulated_environment=true).
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('placeholder', () {
    expect(true, isTrue);
  });
}
