import 'package:chopper/chopper.dart';
import 'package:example/models/album.dart';
import 'package:example/models/article.dart';
import 'package:example/models/todo.dart';
import 'package:example/models/user.dart';

part 'users_service.chopper.dart';

@ChopperApi(baseUrl: '/users')
abstract class UsersService extends ChopperService {
  static UsersService create([ChopperClient? client]) => _$UsersService(client);

  @GET(path: '/', timeout: Duration(seconds: 10))
  Future<Response<List<User>>> getAll({
    @Query('id') int? id,
    @Query('username') String? username,
    @Query('email') String? email,
    @Query('phone') String? phone,
    @Query('website') String? website,
  });

  @GET(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<User?>> get(@Path() int id);

  @GET(path: '/{id}/albums', timeout: Duration(seconds: 10))
  Future<Response<List<Album>>> getAlbums(@Path() int id);

  @GET(path: '/{id}/todos', timeout: Duration(seconds: 10))
  Future<Response<List<Todo>>> getTodos(@Path() int id);

  @GET(path: '/{id}/posts', timeout: Duration(seconds: 10))
  Future<Response<List<Article>>> getArticles(@Path() int id);

  @POST(path: '/', timeout: Duration(seconds: 10))
  Future<Response<User?>> post(@Body() User body);

  @PUT(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<User?>> put(@Path() int id, @Body() User body);

  @PATCH(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<User?>> patch(@Path() int id, @Body() User body);

  @DELETE(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<void>> delete(@Path() int id);
}
