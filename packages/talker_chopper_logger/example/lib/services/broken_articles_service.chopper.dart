// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broken_articles_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$BrokenArticlesService extends BrokenArticlesService {
  _$BrokenArticlesService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = BrokenArticlesService;

  @override
  Future<Response<List<BrokenArticle>>> getAll({int? userId}) {
    final Uri $url = Uri.parse('/posts/');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<BrokenArticle>, BrokenArticle>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<BrokenArticle>> get(int id) {
    final Uri $url = Uri.parse('/posts/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<BrokenArticle, BrokenArticle>($request)
        .timeout(const Duration(microseconds: 10000000));
  }
}
