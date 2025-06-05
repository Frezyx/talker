// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photos_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$PhotosService extends PhotosService {
  _$PhotosService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = PhotosService;

  @override
  Future<Response<List<Photo>>> getAll({int? albumId}) {
    final Uri $url = Uri.parse('/photos/');
    final Map<String, dynamic> $params = <String, dynamic>{'albumId': albumId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<Photo>, Photo>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Photo>> get(int id) {
    final Uri $url = Uri.parse('/photos/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<Photo, Photo>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Photo>> post(Photo body) {
    final Uri $url = Uri.parse('/photos/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Photo, Photo>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Photo>> put(
    int id,
    Photo body,
  ) {
    final Uri $url = Uri.parse('/photos/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Photo, Photo>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Photo>> patch(
    int id,
    Photo body,
  ) {
    final Uri $url = Uri.parse('/photos/${id}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Photo, Photo>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<void>> delete(int id) {
    final Uri $url = Uri.parse('/photos/${id}');
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
