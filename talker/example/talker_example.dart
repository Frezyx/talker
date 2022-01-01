import 'package:talker/talker.dart';

void main() {
  Talker.instance.stream.listen((d) {
    print(d.message);
    print(d.logLevel);
  });
  Talker.instance.handleException('wtf where ?', Exception('aaaa'));
  Talker.instance.log('Fuck', LogLevel.critical);
}
