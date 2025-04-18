import 'package:example/interceptors/json_content_type_inerceptor.dart';
import 'package:example/interceptors/json_headers_interceptor.dart';
import 'package:example/models/address.dart';
import 'package:example/models/album.dart';
import 'package:example/models/article.dart';
import 'package:example/models/broken_article.dart';
import 'package:example/models/comment.dart';
import 'package:example/models/company.dart';
import 'package:example/models/geo_location.dart';
import 'package:example/models/photo.dart';
import 'package:example/models/todo.dart';
import 'package:example/models/user.dart';
import 'package:example/services/albums_service.dart';
import 'package:example/services/broken_articles_service.dart';
import 'package:example/services/comments_service.dart';
import 'package:example/services/converters/json_serializable_converter.dart';
import 'package:example/services/articles_service.dart';
import 'package:chopper/chopper.dart';
import 'package:example/services/photos_service.dart';
import 'package:example/services/todos_service.dart';
import 'package:example/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:talker_chopper_logger/talker_chopper_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  runApp(
    MaterialApp(
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Talker _talker = Talker();

  late final ChopperClient _chopper = ChopperClient(
    baseUrl: Uri.https('jsonplaceholder.typicode.com'),
    services: [
      AlbumsService.create(),
      ArticlesService.create(),
      CommentsService.create(),
      PhotosService.create(),
      TodosService.create(),
      UsersService.create(),
      BrokenArticlesService.create(),
    ],
    interceptors: [
      JsonHeadersInterceptor(),
      JsonContentTypeInterceptor(),
      TalkerChopperLogger(
        talker: _talker,
        settings: TalkerChopperLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          hiddenHeaders: {'authorization'},
        ),
      ),
    ],
    converter: const JsonSerializableConverter({
      Album: Album.fromJson,
      Article: Article.fromJson,
      Comment: Comment.fromJson,
      Photo: Photo.fromJson,
      Todo: Todo.fromJson,
      User: User.fromJson,
      BrokenArticle: BrokenArticle.fromJson,
    }),
  );

  late final AlbumsService albumsService = _chopper.getService<AlbumsService>();
  late final ArticlesService articlesService =
      _chopper.getService<ArticlesService>();
  late final CommentsService commentsService =
      _chopper.getService<CommentsService>();
  late final PhotosService photosService = _chopper.getService<PhotosService>();
  late final TodosService todosService = _chopper.getService<TodosService>();
  late final UsersService usersService = _chopper.getService<UsersService>();
  late final BrokenArticlesService brokenArticlesService =
      _chopper.getService<BrokenArticlesService>();

  /// Albums HTTP requests
  Future<void> _albumsRequests() async {
    albumsService.getAll();
    albumsService.getAll(userId: 1);
    albumsService.get(1);
    albumsService.getPhotos(1);
    albumsService.post(
      const Album(
        title: 'foo',
        userId: 1,
      ),
    );
    albumsService.put(
      1,
      const Album(
        id: 1,
        title: 'bar',
        userId: 1,
      ),
    );
    albumsService.patch(
      1,
      const Album(
        id: 1,
        title: 'baz',
        userId: 1,
      ),
    );
    albumsService.delete(1);
    albumsService.put(
      123456,
      const Album(
        id: 123456,
        title: 'qux',
        userId: 1,
      ),
    );
    albumsService.patch(
      123456,
      const Album(
        id: 123456,
        title: 'quux',
        userId: 1,
      ),
    );
    albumsService.get(123456);
    albumsService.delete(123456);
  }

  /// Articles (Posts) HTTP requests
  Future<void> _articlesRequests() async {
    articlesService.getAll();
    articlesService.getAll(userId: 2);
    articlesService.post(
      const Article(
        title: 'foo',
        body: 'bar',
        userId: 1,
      ),
    );
    articlesService.get(1);
    articlesService.getComments(1);
    articlesService.put(
      1,
      const Article(
        id: 1,
        title: 'baz',
        body: 'qux',
        userId: 1,
      ),
    );
    articlesService.patch(
      1,
      const Article(
        id: 1,
        title: 'lorem',
        body: 'ipsum',
        userId: 1,
      ),
    );
    articlesService.delete(1);
    articlesService.put(
      123456,
      const Article(
        id: 123456,
        title: 'dolor',
        body: 'sit',
        userId: 1,
      ),
    );
    articlesService.patch(
      123456,
      const Article(
        id: 123456,
        title: 'amet',
        body: 'consectetur',
        userId: 1,
      ),
    );
    articlesService.get(123456);
    articlesService.delete(123456);
  }

  /// Comments HTTP requests
  Future<void> _commentsRequests() async {
    commentsService.getAll();
    commentsService.getAll(articleId: 1);
    commentsService.getAll(email: 'Hayden@althea.biz');
  }

  /// Photos HTTP requests
  Future<void> _photosRequests() async {
    photosService.getAll();
    photosService.getAll(albumId: 1);
    photosService.get(1);
    photosService.post(
      Photo(
        title: 'foo',
        url: Uri.parse('https://via.placeholder.com/600/92c952'),
        thumbnailUrl: Uri.parse('https://via.placeholder.com/150/92c952'),
        albumId: 1,
      ),
    );
    photosService.put(
      1,
      Photo(
        id: 1,
        title: 'bar',
        url: Uri.parse('https://via.placeholder.com/600/92c952'),
        thumbnailUrl: Uri.parse('https://via.placeholder.com/150/92c952'),
        albumId: 1,
      ),
    );
    photosService.patch(
      1,
      Photo(
        id: 1,
        title: 'baz',
        url: Uri.parse('https://via.placeholder.com/600/92c952'),
        thumbnailUrl: Uri.parse('https://via.placeholder.com/150/92c952'),
        albumId: 1,
      ),
    );
    photosService.delete(1);
    photosService.put(
      123456,
      Photo(
        id: 123456,
        title: 'qux',
        url: Uri.parse('https://via.placeholder.com/600/92c952'),
        thumbnailUrl: Uri.parse('https://via.placeholder.com/150/92c952'),
        albumId: 1,
      ),
    );
    photosService.patch(
      123456,
      Photo(
        id: 123456,
        title: 'quux',
        url: Uri.parse('https://via.placeholder.com/600/92c952'),
        thumbnailUrl: Uri.parse('https://via.placeholder.com/150/92c952'),
        albumId: 1,
      ),
    );
    photosService.get(123456);
    photosService.delete(123456);
  }

  /// Todos HTTP requests
  Future<void> _todosRequests() async {
    todosService.getAll();
    todosService.getAll(userId: 1);
    todosService.get(1);
    todosService.post(
      const Todo(
        title: 'foo',
        completed: false,
        userId: 1,
      ),
    );
    todosService.put(
      1,
      const Todo(
        id: 1,
        title: 'bar',
        completed: false,
        userId: 1,
      ),
    );
    todosService.patch(
      1,
      const Todo(
        id: 1,
        title: 'baz',
        completed: false,
        userId: 1,
      ),
    );
    todosService.delete(1);
    todosService.put(
      123456,
      const Todo(
        id: 123456,
        title: 'qux',
        completed: false,
        userId: 1,
      ),
    );
    todosService.patch(
      123456,
      const Todo(
        id: 123456,
        title: 'quux',
        completed: false,
        userId: 1,
      ),
    );
    todosService.get(123456);
    todosService.delete(123456);
  }

  /// Users HTTP requests
  Future<void> _usersRequests() async {
    const User johnDoe = User(
      name: 'John Doe',
      username: 'johndoe',
      email: 'john@doe.test',
      phone: '+12025550123',
      website: 'john-doe.test',
      address: Address(
        street: '1234 Elm St',
        suite: 'Apt. 123',
        city: 'Springfield',
        zipCode: '12345-6789',
        geoLocation: GeoLocation(
          latitude: 37.1234,
          longitude: -122.1234,
        ),
      ),
      company: Company(
        name: 'John Doe Inc.',
        catchPhrase: 'Hello, World!',
        businessStrategy: 'Hello, World!',
      ),
    );

    usersService.getAll();
    usersService.getAll(id: 1);
    usersService.getAll(username: 'Antonette');
    usersService.getAll(email: 'Julianne.OConner@kory.org');
    usersService.getAll(phone: '(254)954-1289');
    usersService.getAll(website: 'elvis.io');
    usersService.get(1);
    usersService.getAlbums(1);
    usersService.getTodos(1);
    usersService.getArticles(1);
    usersService.post(johnDoe);
    usersService.put(
      1,
      johnDoe.copyWith(
        address: johnDoe.address.copyWith(
          city: 'New York',
          street: '1234 Main St',
          geoLocation: johnDoe.address.geoLocation.copyWith(
            latitude: 40.7128,
            longitude: -74.0060,
          ),
        ),
      ),
    );
    usersService.patch(
      1,
      johnDoe.copyWith(
        address: johnDoe.address.copyWith(
          city: 'Los Angeles',
          street: '1234 Maple St',
          geoLocation: johnDoe.address.geoLocation.copyWith(
            latitude: 34.0522,
            longitude: -118.2437,
          ),
        ),
      ),
    );
    usersService.delete(1);
    usersService.put(
      123456,
      johnDoe.copyWith(
        id: 123456,
        name: 'Jane Doe',
        username: 'janedoe',
        email: 'jane@doe.test',
        phone: '+12025550124',
        website: 'jane-doe.test',
        address: johnDoe.address.copyWith(
          street: '1234 Elm St',
          suite: 'Apt. 123',
          city: 'Springfield',
          zipCode: '12345-6789',
          geoLocation: johnDoe.address.geoLocation.copyWith(
            latitude: 37.1234,
            longitude: -122.1234,
          ),
        ),
        company: johnDoe.company.copyWith(
          name: 'Jane Doe Inc.',
          catchPhrase: 'Hello, World!',
          businessStrategy: 'Hello, World!',
        ),
      ),
    );
    usersService.patch(
      123456,
      johnDoe.copyWith(
        id: 123456,
        name: 'Jane Doe',
        username: 'janedoe',
        email: 'jane@doe.test',
        phone: '+12025550124',
        website: 'jane-doe.test',
        address: johnDoe.address.copyWith(
          street: '1234 Elm St',
          suite: 'Apt. 123',
          city: 'Springfield',
          zipCode: '12345-6789',
          geoLocation: johnDoe.address.geoLocation.copyWith(
            latitude: 37.1234,
            longitude: -122.1234,
          ),
        ),
        company: johnDoe.company.copyWith(
          name: 'Jane Doe Inc.',
          catchPhrase: 'Hello, World!',
          businessStrategy: 'Hello, World!',
        ),
      ),
    );
    usersService.get(123456);
    usersService.delete(123456);
  }

  Future<void> _brokenArticlesRequests() async {
    brokenArticlesService.getAll();
    brokenArticlesService.get(1);
  }

  late final List<({String title, VoidCallback onPressed})> _buttons = [
    (title: 'Run Albums HTTP Requests', onPressed: _albumsRequests),
    (title: 'Run Articles HTTP Requests', onPressed: _articlesRequests),
    (title: 'Run Comments HTTP Requests', onPressed: _commentsRequests),
    (title: 'Run Photos HTTP Requests', onPressed: _photosRequests),
    (title: 'Run Todos HTTP Requests', onPressed: _todosRequests),
    (title: 'Run Users HTTP Requests', onPressed: _usersRequests),
    (
      title: 'Run Broken Articles HTTP Requests',
      onPressed: _brokenArticlesRequests,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talker + Chopper - Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        children: [
          const Text(
            'Check result in console or open Talker Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          for (final ({String title, VoidCallback onPressed}) button
              in _buttons)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: button.onPressed,
                child: Text(button.title),
              ),
            ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              await Future.wait([
                _albumsRequests(),
                _articlesRequests(),
                _commentsRequests(),
                _photosRequests(),
                _todosRequests(),
                _usersRequests(),
              ]);

              _brokenArticlesRequests();
            },
            child: const Text(
              'Run ALL HTTP Requests',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(
                    talker: _talker,
                    isLogsExpanded: true,
                    isLogOrderReversed: true,
                  ),
                ),
              );
            },
            child: Text('Go to Talker Screen'),
          ),
        ],
      ),
    );
  }
}
