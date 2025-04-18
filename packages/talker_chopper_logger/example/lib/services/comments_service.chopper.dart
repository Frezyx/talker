// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$CommentsService extends CommentsService {
  _$CommentsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = CommentsService;

  @override
  Future<Response<List<Comment>>> getAll({
    int? articleId,
    String? email,
  }) {
    final Uri $url = Uri.parse('/comments/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'postId': articleId,
      'email': email,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<Comment>, Comment>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Comment>> get(int id) {
    final Uri $url = Uri.parse('/comments/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<Comment, Comment>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Comment>> post(Comment body) {
    final Uri $url = Uri.parse('/comments/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Comment, Comment>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Comment>> put(
    int id,
    Comment body,
  ) {
    final Uri $url = Uri.parse('/comments/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Comment, Comment>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Comment>> patch(
    int id,
    Comment body,
  ) {
    final Uri $url = Uri.parse('/comments/${id}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Comment, Comment>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<void>> delete(int id) {
    final Uri $url = Uri.parse('/comments/${id}');
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
