import 'dart:convert' show JsonEncoder, jsonDecode;

import 'package:http_interceptor/http_interceptor.dart';

const JsonEncoder _encoder = JsonEncoder();

extension CurlRequest on BaseRequest {
  /// Converts the request to a curl command string.
  String toCurl({Map<String, String>? headers}) {
    final List<String> curl = ['curl', '-v', '-X', method];

    curl.addAll((headers ?? this.headers)
        .entries
        .map((e) => "-H ${_q('${e.key}: ${e.value}')}"));

    switch (this) {
      case Request req when req.body.isNotEmpty:
        try {
          curl.addAll(['-d', _q(_encoder.convert(jsonDecode(req.body)))]);
        } on FormatException {
          curl.addAll(['-d', _q(req.body)]);
        }
        break;
      case MultipartRequest req:
        for (final MapEntry<String, String> field in req.fields.entries) {
          curl.addAll(['-F', _q('${field.key}=${field.value}')]);
        }
        for (final MultipartFile file in req.files) {
          curl.addAll(['-F', _q('${file.field}=@${file.filename}')]);
        }
        break;
      default:
        break;
    }

    curl.add(_q(url.toString()));

    return curl.join(' ');
  }

  /// single-quoting with sane escaping of `'`
  String _q(String s) => "'${s.replaceAll("'", r"'\''")}'";
}
