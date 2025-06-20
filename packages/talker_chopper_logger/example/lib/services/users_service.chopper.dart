// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$UsersService extends UsersService {
  _$UsersService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = UsersService;

  @override
  Future<Response<List<User>>> getAll({
    int? id,
    String? username,
    String? email,
    String? phone,
    String? website,
  }) {
    final Uri $url = Uri.parse('/users/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<User>, User>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<User>> get(int id) {
    final Uri $url = Uri.parse('/users/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<User, User>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<List<Album>>> getAlbums(int id) {
    final Uri $url = Uri.parse('/users/${id}/albums');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<Album>, Album>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<List<Todo>>> getTodos(int id) {
    final Uri $url = Uri.parse('/users/${id}/todos');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<Todo>, Todo>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<List<Article>>> getArticles(int id) {
    final Uri $url = Uri.parse('/users/${id}/posts');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<Article>, Article>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<User>> post(User body) {
    final Uri $url = Uri.parse('/users/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<User, User>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<User>> put(
    int id,
    User body,
  ) {
    final Uri $url = Uri.parse('/users/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<User, User>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<User>> patch(
    int id,
    User body,
  ) {
    final Uri $url = Uri.parse('/users/${id}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<User, User>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<void>> delete(int id) {
    final Uri $url = Uri.parse('/users/${id}');
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
