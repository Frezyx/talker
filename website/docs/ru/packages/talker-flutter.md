# talker_flutter

<a href="https://pub.dev/packages/talker_flutter"><img src="https://img.shields.io/pub/v/talker_flutter.svg" alt="Pub"></a>

Flutter-расширения для Talker — цветные логи, просмотр логов в приложении, алерты об ошибках, observer навигации и многое другое.

## Установка

```yaml
dependencies:
  talker_flutter: ^5.1.13
```

## Настройка

```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();
```

::: tip Почему TalkerFlutter.init()?
Этот метод использует оптимальный способ вывода для каждой платформы:
- **Web** — `print()`
- **iOS / macOS** — `dart:developer.log` (сохраняет цвета)
- **Android / Windows / Linux** — `debugPrint` (не обрезает сообщения)
:::

## TalkerScreen

Полнофункциональный виджет просмотра логов. Просматривайте, фильтруйте, ищите и делитесь логами прямо в приложении.

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => TalkerScreen(talker: talker),
  ),
);
```

### Параметры TalkerScreen

| Параметр | Тип | По умолч. | Описание |
|----------|-----|-----------|----------|
| `talker` | `Talker` | _обязат._ | Экземпляр Talker для отображения |
| `theme` | `TalkerScreenTheme` | `TalkerScreenTheme()` | Тема оформления |
| `appBarTitle` | `String` | `'Talker'` | Заголовок AppBar |
| `appBarLeading` | `Widget?` | `null` | Ведущий виджет AppBar |
| `itemsBuilder` | `TalkerDataBuilder?` | `null` | Кастомный билдер карточек |
| `isLogsExpanded` | `bool` | `true` | Логи развёрнуты по умолчанию |
| `isLogOrderReversed` | `bool` | `true` | Новые логи сверху |

### Кастомные цвета темы

```dart
TalkerScreen(
  talker: talker,
  theme: const TalkerScreenTheme(
    logColors: {
      TalkerLogType.httpResponse.key: Color(0xFF26FF3C),
      TalkerLogType.error.key: Colors.redAccent,
      TalkerLogType.info.key: Color.fromARGB(255, 0, 255, 247),
      'custom_log_key': Colors.green,
    },
  ),
)
```

## TalkerView

То же, что TalkerScreen, но без `Scaffold` — для встраивания в свои layout-ы:

```dart
Scaffold(
  appBar: AppBar(title: Text('Мой экран')),
  body: TalkerView(
    talker: talker,
    theme: const TalkerScreenTheme(),
  ),
)
```

## TalkerMonitor

Быстрый обзор статуса — количество HTTP-запросов, исключений, ошибок, предупреждений и т.д. Доступен из настроек `TalkerScreen`.

## TalkerWrapper

Автоматические алерты об ошибках в UI:

```dart
TalkerWrapper(
  talker: talker,
  options: const TalkerWrapperOptions(
    enableErrorAlerts: true,
  ),
  child: MyApp(),
)
```

## TalkerListener

Слушайте события Talker в дереве виджетов:

```dart
TalkerListener(
  talker: talker,
  listener: (data) {
    if (data is TalkerException || data is TalkerError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data.displayMessage)),
      );
    }
  },
  child: MyApp(),
)
```

## TalkerBuilder

Реактивно стройте UI на основе логов:

```dart
TalkerBuilder(
  talker: talker,
  builder: (context, data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(data[index].message));
      },
    );
  },
)
```

## TalkerRouteObserver

Логируйте события навигации. Работает с любым пакетом маршрутизации.

### Navigator

```dart
MaterialApp(
  navigatorObservers: [
    TalkerRouteObserver(talker),
  ],
)
```

### go_router

```dart
GoRouter(
  observers: [TalkerRouteObserver(talker)],
)
```

### auto_route v7+

```dart
MaterialApp.router(
  routerConfig: _appRouter.config(
    navigatorObservers: () => [
      TalkerRouteObserver(talker),
    ],
  ),
)
```

Подробнее в руководстве [Логирование маршрутов](/ru/guides/routing).

## runTalkerZonedGuarded

Перехват всех неперехваченных ошибок:

```dart
void main() {
  final talker = TalkerFlutter.init();

  runTalkerZonedGuarded(
    talker,
    () => runApp(MyApp()),
  );
}
```

## Справка по API

Полная документация API доступна на [pub.dev](https://pub.dev/documentation/talker_flutter/latest/).
