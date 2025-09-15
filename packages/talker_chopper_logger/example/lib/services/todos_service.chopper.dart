// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$TodosService extends TodosService {
  _$TodosService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = TodosService;

  @override
  Future<Response<List<Todo>>> getAll({
    int? userId,
    bool? completed,
  }) {
    final Uri $url = Uri.parse('/todos/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'completed': completed,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<Todo>, Todo>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Todo>> get(int id) {
    final Uri $url = Uri.parse('/todos/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<Todo, Todo>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Todo>> post(Todo body) {
    final Uri $url = Uri.parse('/todos/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Todo, Todo>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Todo>> put(
    int id,
    Todo body,
  ) {
    final Uri $url = Uri.parse('/todos/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Todo, Todo>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Todo>> patch(
    int id,
    Todo body,
  ) {
    final Uri $url = Uri.parse('/todos/${id}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Todo, Todo>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<void>> delete(int id) {
    final Uri $url = Uri.parse('/todos/${id}');
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
