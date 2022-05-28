import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/bloc/observer.dart';
import 'package:talker_shop_app_example/features/products/products.dart';
import 'package:talker_shop_app_example/repositories/products/products.dart';
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
    );
  }
}

void _initTalker() {
  final talker = Talker(
    loggerSettings: TalkerLoggerSettings(
      enableColors: !Platform.isIOS,
    ),
  );
  GetIt.instance.registerSingleton<Talker>(talker);
}

void _registerRepositories() {
  GetIt.instance.registerSingleton<AbstractProductsRepository>(
    ProductsRepository(),
  );
}
