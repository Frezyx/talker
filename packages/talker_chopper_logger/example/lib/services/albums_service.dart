import 'package:chopper/chopper.dart';
import 'package:example/models/album.dart';
import 'package:example/models/photo.dart';

part 'albums_service.chopper.dart';

@ChopperApi(baseUrl: '/albums')
abstract class AlbumsService extends ChopperService {
  static AlbumsService create([ChopperClient? client]) =>
      _$AlbumsService(client);

  @GET(path: '/', timeout: Duration(seconds: 10))
  Future<Response<List<Album>>> getAll({
    @Query('userId') int? userId,
  });

  @GET(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<Album?>> get(@Path() int id);

  @GET(path: '/{id}/photos', timeout: Duration(seconds: 10))
  Future<Response<List<Photo>>> getPhotos(@Path() int id);

  @POST(path: '/', timeout: Duration(seconds: 10))
  Future<Response<Album?>> post(@Body() Album body);

  @PUT(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<Album?>> put(@Path() int id, @Body() Album body);

  @PATCH(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<Album?>> patch(@Path() int id, @Body() Album body);

  @DELETE(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<void>> delete(@Path() int id);
}
