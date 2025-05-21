import 'package:chopper/chopper.dart';
import 'package:example/models/broken_article.dart';

part 'broken_articles_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class BrokenArticlesService extends ChopperService {
  // helper methods that help you instantiate your service
  static BrokenArticlesService create([ChopperClient? client]) =>
      _$BrokenArticlesService(client);

  @GET(path: '/', timeout: Duration(seconds: 10))
  Future<Response<List<BrokenArticle>>> getAll({
    @Query() int? userId,
  });

  @GET(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<BrokenArticle?>> get(@Path() int id);
}
