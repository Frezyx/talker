import 'package:talker/talker.dart';

void main() {
  Talker.instance.stream.listen((d) {
    print(d);
  });
  Talker.instance.handleException('wtf where ?', Exception('aaaa'));
}
