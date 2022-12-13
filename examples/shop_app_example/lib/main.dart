import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/bloc/observer.dart';
import 'package:talker_shop_app_example/repositories/products/products.dart';
import 'package:talker_shop_app_example/ui/presentation_frame.dart';
import 'package:talker_shop_app_example/ui/ui.dart';

void main() {
  _initTalker();
  _registerRepositories();
  Bloc.observer = AppBlocObserver();
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (Object error, StackTrace stack) {
    GetIt.instance<Talker>().handle(error, stack, 'Uncaught app exception');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talker shop app',
      theme: lightTheme,
      initialRoute: Routes.productsList,
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      navigatorObservers: [
        TalkerRouteObserver(GetIt.instance<Talker>()),
      ],
      builder: (context, child) {
        if (_haveBigScreen) {
          return PresentationFrame(
            child: TalkerWrapper(
              talker: GetIt.instance<Talker>(),
              child: child!,
            ),
          );
        }
        return TalkerWrapper(
          talker: GetIt.instance<Talker>(),
          child: child!,
        );
      },
    );
  }
}

final _haveBigScreen = kIsWeb ||
    [TargetPlatform.windows, TargetPlatform.macOS, TargetPlatform.linux]
        .contains(defaultTargetPlatform);

void _initTalker() {
  final talker = TalkerFlutter.init();
  GetIt.instance.registerSingleton<Talker>(talker);
  talker.verbose('Talker initialization completed');

  /// This logic is just for example here
  if (!GetIt.instance.isRegistered<Talker>()) {
    GetIt.instance.registerSingleton<Talker>(talker);
  } else {
    talker.warning('Trying to re-register an object in GetIt');
  }
}

void _registerRepositories() {
  final dio = Dio();
  // _tryPrecacheDio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: GetIt.instance<Talker>(),
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printRequestData: true,
        printResponseData: true,
      ),
    ),
  );

  GetIt.instance.registerSingleton<AbstractProductsRepository>(
    ProductsRepository(dio: dio),
  );
  GetIt.instance<Talker>().info('Repositories initialization completed');
}

/// This logic is just for example here
// void _tryPrecacheDio() {
//   try {
//     throw Exception('Dio precache exception');
//   } catch (e, st) {
//     GetIt.instance<Talker>().handle(e, st);
//   }
// }
