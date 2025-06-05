import 'package:http_interceptor/http_interceptor.dart';

extension MultipartRequestExtension on Request {
  MultipartRequest toMultipartRequest(
    Iterable<({String name, dynamic value})> parts,
  ) {
    final MultipartRequest request = MultipartRequest(method, url)
      ..headers.addAll(headers);

    for (final ({String name, dynamic value}) part in parts) {
      if (part.value == null) continue;

      if (part.value is MultipartFile) {
        request.files.add(part.value);
      } else if (part.value is Iterable<MultipartFile>) {
        request.files.addAll(part.value);
      } else if (part.value is Iterable) {
        request.fields.addAll({
          for (int i = 0; i < part.value.length; i++)
            '${part.name}[$i]': part.value.elementAt(i).toString(),
        });
      } else {
        request.fields[part.name] = part.value.toString();
      }
    }

    return request;
  }
}
