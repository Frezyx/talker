import 'package:chopper/chopper.dart';
import 'package:example/models/photo.dart';

part 'photos_service.chopper.dart';

@ChopperApi(baseUrl: '/photos')
abstract class PhotosService extends ChopperService {
  static PhotosService create([ChopperClient? client]) =>
      _$PhotosService(client);

  @GET(path: '/', timeout: Duration(seconds: 10))
  Future<Response<List<Photo>>> getAll({
    @Query('albumId') int? albumId,
  });

  @GET(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<Photo?>> get(@Path() int id);

  @POST(path: '/', timeout: Duration(seconds: 10))
  Future<Response<Photo?>> post(@Body() Photo body);

  @PUT(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<Photo?>> put(@Path() int id, @Body() Photo body);

  @PATCH(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<Photo?>> patch(@Path() int id, @Body() Photo body);

  @DELETE(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<void>> delete(@Path() int id);
}
