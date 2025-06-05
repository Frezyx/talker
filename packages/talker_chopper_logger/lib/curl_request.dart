import 'dart:convert' show JsonEncoder, jsonDecode;

import 'package:chopper/chopper.dart' as chopper show Request;
import 'package:http/http.dart' as http
    show BaseRequest, MultipartFile, MultipartRequest, Request;

const JsonEncoder _encoder = JsonEncoder();

extension CurlRequest on http.BaseRequest {
  /// Converts the request to a curl command string.
  String toCurl({Map<String, String>? headers}) {
    final List<String> curl = ['curl', '-v', '-X', method];

    curl.addAll((headers ?? this.headers)
        .entries
        .map((e) => "-H ${_q('${e.key}: ${e.value}')}"));

    switch (this) {
      case chopper.Request req when req.body != null:
        curl.addAll(['-d', _q(_encoder.convert(req.body))]);
        break;
      case http.Request req when req.body.isNotEmpty:
        try {
          curl.addAll(['-d', _q(_encoder.convert(jsonDecode(req.body)))]);
        } on FormatException {
          curl.addAll(['-d', _q(req.body)]);
        }
        break;
      case http.MultipartRequest req:
        for (final MapEntry<String, String> field in req.fields.entries) {
          curl.addAll(['-F', _q('${field.key}=${field.value}')]);
        }
        for (final http.MultipartFile file in req.files) {
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
