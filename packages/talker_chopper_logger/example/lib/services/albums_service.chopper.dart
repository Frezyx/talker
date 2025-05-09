// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AlbumsService extends AlbumsService {
  _$AlbumsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AlbumsService;

  @override
  Future<Response<List<Album>>> getAll({int? userId}) {
    final Uri $url = Uri.parse('/albums/');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<Album>, Album>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Album>> get(int id) {
    final Uri $url = Uri.parse('/albums/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<Album, Album>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<List<Photo>>> getPhotos(int id) {
    final Uri $url = Uri.parse('/albums/${id}/photos');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<Photo>, Photo>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Album>> post(Album body) {
    final Uri $url = Uri.parse('/albums/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Album, Album>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Album>> put(
    int id,
    Album body,
  ) {
    final Uri $url = Uri.parse('/albums/${id}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Album, Album>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<Album>> patch(
    int id,
    Album body,
  ) {
    final Uri $url = Uri.parse('/albums/${id}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<Album, Album>($request)
        .timeout(const Duration(microseconds: 10000000));
  }

  @override
  Future<Response<void>> delete(int id) {
    final Uri $url = Uri.parse('/albums/${id}');
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
