import 'package:chopper/chopper.dart';
import 'package:example/models/article.dart';
import 'package:example/models/comment.dart';

part 'articles_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class ArticlesService extends ChopperService {
  // helper methods that help you instantiate your service
  static ArticlesService create([ChopperClient? client]) =>
      _$ArticlesService(client);

  @GET(path: '/', timeout: Duration(seconds: 10))
  Future<Response<List<Article>>> getAll({
    @Query() int? userId,
  });

  @GET(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<Article?>> get(@Path() int id);

  @GET(path: '/{id}/comments', timeout: Duration(seconds: 10))
  Future<Response<List<Comment>>> getComments(@Path() int id);

  @POST(path: '/', timeout: Duration(seconds: 10))
  Future<Response<Article?>> post(@Body() Article body);

  @PUT(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<Article?>> put(@Path() int id, @Body() Article body);

  @PATCH(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<Article?>> patch(@Path() int id, @Body() Article body);

  @DELETE(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<void>> delete(@Path() int id);
}
