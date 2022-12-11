import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/bloc/observer.dart';
import 'package:talker_shop_app_example/repositories/products/products.dart';
import 'package:talker_shop_app_example/ui/presentation_widget.dart';
import 'package:talker_shop_app_example/ui/ui.dart';

void main() {
  _initTalker();
  _registerRepositories();
  runZonedGuarded(() {
    BlocOverrides.runZoned(
      () => runApp(const MyApp()),
      blocObserver: AppBlocObserver(),
    );
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
      routes: appRoutes,
      navigatorObservers: [
        TalkerRouteObserver(GetIt.instance<Talker>()),
      ],
      builder: (context, child) {
        if (_haveBigScreen) {
          return PresentationWidget(
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

final _haveBigScreen =
    Platform.isMacOS || Platform.isWindows || Platform.isLinux || kIsWeb;

void _initTalker() {
  final talker = TalkerFlutter.init();
  GetIt.instance.registerSingleton<Talker>(talker);
  talker.verbose('Talker initialization complete');
}

void _registerRepositories() {
  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: GetIt.instance<Talker>(),
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
      ),
    ),
  );

  GetIt.instance.registerSingleton<AbstractProductsRepository>(
    ProductsRepository(dio: dio),
  );
  GetIt.instance<Talker>().verbose('Repositories initialization complete');
}
