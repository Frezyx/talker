# Кастомные сообщения об ошибках

Показывайте user-friendly алерты и кастомные сообщения в Flutter-приложении с помощью виджетов Talker.

## TalkerWrapper

Самый простой способ показать алерты об ошибках. Оберните приложение (или поддерево) в `TalkerWrapper`:

```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

TalkerWrapper(
  talker: talker,
  options: const TalkerWrapperOptions(
    enableErrorAlerts: true,
    enableExceptionAlerts: true,
  ),
  child: MaterialApp(
    home: HomeScreen(),
  ),
)
```

Теперь при каждом вызове `talker.handle()` с исключением или ошибкой автоматически появится SnackBar внизу экрана.

## TalkerListener

Для большего контроля используйте `TalkerListener`:

```dart
TalkerListener(
  talker: talker,
  listener: (data) {
    if (data is TalkerException) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка: ${data.displayMessage}'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Подробнее',
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TalkerScreen(talker: talker),
                ),
              );
            },
          ),
        ),
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
    final errors = data.whereType<TalkerError>().toList();
    final exceptions = data.whereType<TalkerException>().toList();

    if (errors.isEmpty && exceptions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.red.shade100,
      child: Text(
        '${errors.length + exceptions.length} ошибок произошло',
        style: const TextStyle(color: Colors.red),
      ),
    );
  },
)
```

## Диалог для критических ошибок

```dart
TalkerListener(
  talker: talker,
  listener: (data) {
    if (data is TalkerError && data.logLevel == LogLevel.critical) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Критическая ошибка'),
          content: Text(data.displayMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TalkerScreen(talker: talker),
                  ),
                );
              },
              child: const Text('Просмотр логов'),
            ),
          ],
        ),
      );
    }
  },
  child: MyApp(),
)
```

## Комбинация с Crashlytics

Используйте `TalkerWrapper` для алертов пользователю И `TalkerObserver` для крэш-репортинга одновременно:

```dart
final talker = TalkerFlutter.init(
  observer: CrashlyticsTalkerObserver(FirebaseCrashlytics.instance),
);

TalkerWrapper(
  talker: talker,
  options: const TalkerWrapperOptions(
    enableErrorAlerts: true,
    enableExceptionAlerts: true,
  ),
  child: MaterialApp(home: HomeScreen()),
)
```

Теперь каждая ошибка:
1. Логируется в консоль
2. Сохраняется в историю
3. Показывается пользователю как SnackBar
4. Отправляется в Crashlytics

## Лучшие практики

1. **Не показывайте технические детали** — используйте `displayMessage` или создавайте понятные сообщения.

2. **Используйте TalkerWrapper для разработки** — быстрый способ видеть ошибки. Замените на кастомный UI для продакшена.

3. **Предлагайте «Просмотр логов»** — позвольте тестировщикам открыть `TalkerScreen` из алертов.

4. **Ограничивайте частоту алертов** — при массовых ошибках используйте debounce, чтобы не засыпать пользователя SnackBar-ами.
