// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ArticlesService extends ArticlesService {
  _$ArticlesService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ArticlesService;

  @override
  Future<Response<List<Article>>> getAll({int? userId}) {
    final Uri $url = Uri.parse('/posts/');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<Article>, Article>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Article>> get(int id) {
    final Uri $url = Uri.parse('/posts/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<Article, Article>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<List<Comment>>> getComments(int id) {
    final Uri $url = Uri.parse('/posts/${id}/comments');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<Comment>, Comment>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Article>> post(Article body) {
    final Uri $url = Uri.parse('/posts/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Article, Article>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Article>> put(
    int id,
    Article body,
  ) {
    final Uri $url = Uri.parse('/posts/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Article, Article>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Article>> patch(
    int id,
    Article body,
  ) {
    final Uri $url = Uri.parse('/posts/${id}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Article, Article>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<void>> delete(int id) {
    final Uri $url = Uri.parse('/posts/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client
        .send<void, void>($request)
        .timeout(const Duration(microseconds: 10000000));
  }
}
