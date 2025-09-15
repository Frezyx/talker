import 'package:chopper/chopper.dart';
import 'package:example/models/todo.dart';

part 'todos_service.chopper.dart';

@ChopperApi(baseUrl: '/todos')
abstract class TodosService extends ChopperService {
  static TodosService create([ChopperClient? client]) => _$TodosService(client);

  @GET(path: '/', timeout: Duration(seconds: 10))
  Future<Response<List<Todo>>> getAll({
    @Query('userId') int? userId,
    @Query('completed') bool? completed,
  });

  @GET(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<Todo?>> get(@Path() int id);

  @POST(path: '/', timeout: Duration(seconds: 10))
  Future<Response<Todo?>> post(@Body() Todo body);

  @PUT(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<Todo?>> put(@Path() int id, @Body() Todo body);

  @PATCH(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<Todo?>> patch(@Path() int id, @Body() Todo body);

  @DELETE(path: '/{id}', timeout: Duration(seconds: 10))
  Future<Response<void>> delete(@Path() int id);
}
