import 'dart:math';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  await Future.delayed(Duration(milliseconds: Random().nextInt(1500)));

  return Response.json(
    body: [
      {
        'name': 'talker_dart_frog_logger',
        'type': 'package',
        'tags': ['error-handler', 'logger', 'logs'],
        'rating': 5,
        'description': 'Best package in the world',
      }
    ],
  );
}
