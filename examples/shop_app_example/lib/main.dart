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
import 'package:talker_shop_app_example/utils/good_log.dart';
import 'package:talker_shop_app_example/utils/scroll_behavior.dart';
import 'package:talker_shop_app_example/utils/utils.dart';

import 'firebase_options.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initFirebase();
    _initDependencies();
    runApp(const MyApp());
  }, (Object error, StackTrace stack) {
    DI<Talker>().handle(error, stack, 'Uncaught app exception');
  });
}

void _initDependencies() {
  final talker = TalkerFlutter.init(
    settings: TalkerSettings(
      colors: {
        TalkerLogType.verbose.key: AnsiPen()..yellow(),
        GoodLog.getKey: GoodLog.getPen,
      },
    ),
  );
  DI.registerSingleton<Talker>(talker);
  talker.verbose('Talker initialization completed');

  final talkerDioLogger = TalkerDioLogger(
    talker: talker,
    settings: const TalkerDioLoggerSettings(
      printRequestHeaders: true,
      printResponseHeaders: false,
      printRequestData: true,
      printResponseData: false,
    ),
  );

  final dio = Dio();
  dio.interceptors.add(talkerDioLogger);

  DI.registerSingleton<AbstractProductsRepository>(
    ProductsRepository(dio: dio),
  );
  talker.logTyped(GoodLog('Repositories initialization completed'));

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printCreations: false,
      printClosings: false,
      printStateFullData: false,
    ),
  );
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: kIsWeb ? WebScrollBehavior() : null,
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
