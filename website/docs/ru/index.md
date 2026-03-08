---
layout: home

hero:
  name: Talker
  text: Продвинутый обработчик ошибок и логгер
  tagline: Логируйте действия приложения, перехватывайте ошибки, показывайте алерты и отправляйте отчёты для Dart и Flutter
  image:
    src: /logo.png
    alt: Talker
  actions:
    - theme: brand
      text: Начать
      link: /ru/getting-started/installation
    - theme: alt
      text: GitHub
      link: https://github.com/Frezyx/talker
    - theme: alt
      text: Веб-демо
      link: https://frezyx.github.io/talker

features:
  - icon: 📝
    title: Мощное логирование
    details: Логи с несколькими уровнями — info, debug, warning, error, critical, verbose и good. Полная кастомизация цветов и поддержка пользовательских типов логов.
  - icon: 🛡️
    title: Обработка ошибок
    details: Перехват Exception и Error с StackTrace. Отправка данных в Crashlytics, Sentry или ваш собственный сервис через TalkerObserver.
  - icon: 📱
    title: Flutter UI
    details: Встроенный TalkerScreen для просмотра логов в приложении, TalkerMonitor для быстрого обзора, TalkerWrapper для алертов об ошибках и TalkerRouteObserver для навигации.
  - icon: 🔌
    title: Богатые интеграции
    details: Поддержка Dio, http, BLoC, Riverpod, Chopper и gRPC из коробки. Каждая с полной кастомизацией, фильтрацией и цветами.
  - icon: 🎨
    title: Полная кастомизация
    details: Свои цвета, заголовки, форматтеры и фильтры для любого типа логов. Создавайте собственные типы логов с полным контролем.
  - icon: ✅
    title: Готов к продакшену
    details: 100% покрытие тестами, MIT лицензия, совместим с любым state management, работает на всех платформах — Android, iOS, Web, macOS, Windows, Linux.
---

<style>
.dartpad-section {
  max-width: 960px;
  margin: 0 auto;
  padding: 48px 24px;
}

.dartpad-section h2 {
  font-size: 28px;
  font-weight: 700;
  margin-bottom: 8px;
  background: -webkit-linear-gradient(120deg, #7C4DFF 30%, #B388FF);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.dartpad-section p {
  color: var(--vp-c-text-2);
  margin-bottom: 24px;
  font-size: 16px;
}

.dartpad-embed {
  border: 1px solid var(--vp-c-divider);
  border-radius: 12px;
  overflow: hidden;
}

.dartpad-embed iframe {
  width: 100%;
  height: 480px;
  border: none;
}

.packages-section {
  max-width: 960px;
  margin: 0 auto;
  padding: 48px 24px;
}

.packages-section h2 {
  font-size: 28px;
  font-weight: 700;
  margin-bottom: 24px;
  text-align: center;
}

.packages-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 16px;
}

.package-card {
  border: 1px solid var(--vp-c-divider);
  border-radius: 12px;
  padding: 20px;
  transition: border-color 0.3s, box-shadow 0.3s;
}

.package-card:hover {
  border-color: var(--vp-c-brand-1);
  box-shadow: 0 2px 12px rgba(124, 77, 255, 0.1);
}

.package-card h3 {
  margin: 0 0 8px;
  font-size: 16px;
}

.package-card h3 a {
  color: var(--vp-c-brand-1);
  text-decoration: none;
}

.package-card p {
  margin: 0;
  font-size: 14px;
  color: var(--vp-c-text-2);
}
</style>

<div class="dartpad-section">

## Попробуйте Talker прямо сейчас

Поиграйтесь с Talker прямо в браузере — без установки:

<div class="dartpad-embed">
  <iframe
    src="https://dartpad.dev/embed-dart.html?id=&run=true&split=50&theme=dark&code=aW1wb3J0ICdwYWNrYWdlOnRhbGtlci90YWxrZXIuZGFydCc7Cgp2b2lkIG1haW4oKSB7CiAgZmluYWwgdGFsa2VyID0gVGFsa2VyKCk7CgogIC8vIExvZyBtZXNzYWdlcyB3aXRoIGRpZmZlcmVudCBsZXZlbHMKICB0YWxrZXIuaW5mbygnQXBwIHN0YXJ0ZWQgc3VjY2Vzc2Z1bGx5IScpOwogIHRhbGtlci5kZWJ1ZygnTG9hZGluZyB1c2VyIHByZWZlcmVuY2VzLi4uJyk7CiAgdGFsa2VyLndhcm5pbmcoJ0NhY2hlIGlzIGFsbW9zdCBmdWxsJyk7CiAgdGFsa2VyLmdvb2QoJ1VzZXIgcHJvZmlsZSBsb2FkZWQhJyk7CgogIC8vIEhhbmRsZSBleGNlcHRpb25zCiAgdHJ5IHsKICAgIHRocm93IEV4Y2VwdGlvbignTmV0d29yayByZXF1ZXN0IGZhaWxlZCcpOwogIH0gY2F0Y2ggKGUsIHN0KSB7CiAgICB0YWxrZXIuaGFuZGxlKGUsIHN0LCAnRmFpbGVkIHRvIGZldGNoIGRhdGEnKTsKICB9CgogIHRhbGtlci5jcml0aWNhbCgnRGF0YWJhc2UgY29ubmVjdGlvbiBsb3N0IScpOwogIHRhbGtlci5pbmZvKCdSZXRyeWluZyBjb25uZWN0aW9uLi4uJyk7CiAgdGFsa2VyLmdvb2QoJ0Nvbm5lY3Rpb24gcmVzdG9yZWQhJyk7Cn0%3D"
    loading="lazy"
  ></iframe>
</div>

</div>

<div class="packages-section">

## Экосистема пакетов

Talker спроектирован для любого уровня кастомизации — выбирайте то, что вам нужно:

<div class="packages-grid">

<div class="package-card">

### [talker](https://pub.dev/packages/talker)

Основной Dart-пакет для логирования и обработки ошибок. Ядро экосистемы.

</div>

<div class="package-card">

### [talker_flutter](https://pub.dev/packages/talker_flutter)

Flutter-расширения — цветные логи, TalkerScreen, TalkerMonitor, route observer и многое другое.

</div>

<div class="package-card">

### [talker_logger](https://pub.dev/packages/talker_logger)

Настраиваемый pretty-логгер для Dart/Flutter приложений. Может использоваться отдельно.

</div>

<div class="package-card">

### [talker_dio_logger](https://pub.dev/packages/talker_dio_logger)

Красивое логирование HTTP запросов/ответов для Dio.

</div>

<div class="package-card">

### [talker_http_logger](https://pub.dev/packages/talker_http_logger)

HTTP-логирование для стандартного пакета http с http_interceptor.

</div>

<div class="package-card">

### [talker_bloc_logger](https://pub.dev/packages/talker_bloc_logger)

Логирование state management для BLoC — события, переходы, изменения состояний.

</div>

<div class="package-card">

### [talker_riverpod_logger](https://pub.dev/packages/talker_riverpod_logger)

Логирование жизненного цикла провайдеров Riverpod — add, update, dispose, fail.

</div>

<div class="package-card">

### [talker_chopper_logger](https://pub.dev/packages/talker_chopper_logger)

HTTP-логирование для Chopper с поддержкой curl команд.

</div>

<div class="package-card">

### [talker_grpc_logger](https://pub.dev/packages/talker_grpc_logger)

Логирование gRPC запросов/ответов с обфускацией токенов.

</div>

</div>

</div>
