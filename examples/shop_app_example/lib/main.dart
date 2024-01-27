import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/repositories/products/products.dart';
import 'package:talker_shop_app_example/ui/presentation_frame.dart';
import 'package:talker_shop_app_example/ui/ui.dart';
import 'package:talker_shop_app_example/utils/utils.dart';

import 'firebase_options.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initFirebase();
    _initTalker();
    _registerRepositories();
    Bloc.observer = TalkerBlocObserver(
      talker: DI<Talker>(),
      settings: const TalkerBlocLoggerSettings(
        printCreations: true,
        printClosings: true,
      ),
    );
    runApp(const MyApp());
  }, (Object error, StackTrace stack) {
    DI<Talker>().handle(error, stack, 'Uncaught app exception');
  });
}

Future<void> _initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final analytics = FirebaseAnalytics.instance;
    analytics.logAppOpen();
  }
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
        TalkerRouteObserver(DI<Talker>()),
      ],
      builder: (context, child) {
        return PresentationFrame(
          talkerTheme: talkerTheme,
          child: TalkerWrapper(
            talker: DI<Talker>(),
            child: child!,
          ),
        );
      },
    );
  }
}

void _initTalker() {
  final talker = TalkerFlutter.init();
  DI.registerSingleton<Talker>(talker);
  talker.verbose('Talker initialization completed');

  /// This logic is just for example here
  if (!DI.isRegistered<Talker>()) {
    DI.registerSingleton<Talker>(talker);
  } else {
    talker.warning('Trying to re-register an object in GetIt');
  }

  /// Dio logger initialization
  final talkerDioLogger = TalkerDioLogger(
    talker: DI<Talker>(),
    settings: const TalkerDioLoggerSettings(
      printRequestHeaders: true,
      printResponseHeaders: true,
      printRequestData: true,
      printResponseData: true,
    ),
  );

  DI.registerSingleton(talkerDioLogger);
}

void _registerRepositories() {
  final dio = Dio();
  dio.interceptors.add(DI<TalkerDioLogger>());

  DI.registerSingleton<AbstractProductsRepository>(
    ProductsRepository(dio: dio),
  );
  DI<Talker>().info('Repositories initialization completed');
}
