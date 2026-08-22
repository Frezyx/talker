# Логирование маршрутов

Логируйте навигационные события Flutter-приложения с `TalkerRouteObserver`. Работает с Navigator, go_router, auto_route и любым маршрутизатором, совместимым с NavigatorObserver.

## Настройка

### Navigator 1.0

```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

MaterialApp(
  navigatorObservers: [
    TalkerRouteObserver(talker),
  ],
  home: HomeScreen(),
)
```

### go_router

```dart
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

final router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  routes: [
    GoRoute(path: '/', builder: (_, __) => HomeScreen()),
    GoRoute(path: '/profile', builder: (_, __) => ProfileScreen()),
  ],
);

MaterialApp.router(routerConfig: router)
```

### auto_route v7+

```dart
import 'package:auto_route/auto_route.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

MaterialApp.router(
  routerConfig: _appRouter.config(
    navigatorObservers: () => [
      TalkerRouteObserver(talker),
    ],
  ),
)
```

### auto_route (legacy)

```dart
MaterialApp.router(
  routerDelegate: AutoRouterDelegate(
    appRouter,
    navigatorObservers: () => [
      TalkerRouteObserver(talker),
    ],
  ),
  routeInformationParser: appRouter.defaultRouteParser(),
)
```

## Что логируется

`TalkerRouteObserver` логирует следующие события:

| Событие | Описание | Пример |
|---------|----------|--------|
| **Push** | Новый маршрут добавлен в стек | `Route pushed: /profile` |
| **Pop** | Маршрут удалён из стека | `Route popped: /profile` |
| **Replace** | Маршрут заменён | `Route replaced: /login → /home` |
| **Remove** | Маршрут удалён | `Route removed: /splash` |

Все логи навигации отображаются в консоли, TalkerScreen и истории с фиолетовым цветом по умолчанию.

## Просмотр в TalkerScreen

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => TalkerScreen(talker: talker),
  ),
);
```

Логи маршрутов имеют цветовую маркировку и легко отличаются от других типов. Их можно фильтровать в TalkerScreen, выбрав фильтр "Route".

## Кастомизация

### Свой цвет маршрутов

```dart
final talker = Talker(
  settings: TalkerSettings(
    colors: {
      TalkerLogType.route.key: AnsiPen()..cyan(),
    },
  ),
);
```

### Свой заголовок

```dart
final talker = Talker(
  settings: TalkerSettings(
    titles: {
      TalkerLogType.route.key: 'NAV',
    },
  ),
);
```

## Лучшие практики

1. **Используйте один экземпляр Talker** во всём приложении — логи маршрутов, HTTP, BLoC-событий и ошибок в одном месте.

2. **Комбинируйте с TalkerScreen** — добавьте кнопку отладки или жест встряхивания для открытия `TalkerScreen` и просмотра полной истории навигации.

3. **Используйте с Crashlytics** — логи маршрутов — отличные breadcrumbs для отчётов о крэшах.
