---
layout: home

hero:
  name: Talker
  text: Advanced Error Handler & Logger
  tagline: Log your app actions, catch and handle exceptions, show alerts and share log reports for Dart & Flutter
  image:
    src: /logo.png
    alt: Talker
  actions:
    - theme: brand
      text: Get Started
      link: /getting-started/installation
    - theme: alt
      text: View on GitHub
      link: https://github.com/Frezyx/talker
    - theme: alt
      text: Web Demo
      link: https://frezyx.github.io/talker

features:
  - icon: 📝
    title: Powerful Logging
    details: Log with multiple levels — info, debug, warning, error, critical, verbose, and good. Full color customization and custom log types support.
  - icon: 🛡️
    title: Error Handling
    details: Catch and handle Exceptions and Errors with StackTrace. Send error data to Crashlytics, Sentry, or your own analytics service via TalkerObserver.
  - icon: 📱
    title: Flutter UI
    details: Built-in TalkerScreen to view logs in-app, TalkerMonitor for quick status overview, TalkerWrapper for error alerts, and TalkerRouteObserver for navigation logging.
  - icon: 🔌
    title: Rich Integrations
    details: Out-of-the-box support for Dio, http, BLoC, Riverpod, Chopper, and gRPC. Each with full customization, filtering, and color options.
  - icon: 🎨
    title: Fully Customizable
    details: Custom colors, titles, formatters, and filters for every log type. Create your own log types with full control over appearance and behavior.
  - icon: ✅
    title: Production Ready
    details: 100% test coverage, MIT licensed, compatible with any state management, works on all platforms — Android, iOS, Web, macOS, Windows, Linux.
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

## Try Talker Now

Play with Talker directly in your browser — no setup needed:

<div class="dartpad-embed">
  <iframe
    src="https://dartpad.dev/embed-dart.html?id=&run=true&split=50&theme=dark&code=aW1wb3J0ICdwYWNrYWdlOnRhbGtlci90YWxrZXIuZGFydCc7Cgp2b2lkIG1haW4oKSB7CiAgZmluYWwgdGFsa2VyID0gVGFsa2VyKCk7CgogIC8vIExvZyBtZXNzYWdlcyB3aXRoIGRpZmZlcmVudCBsZXZlbHMKICB0YWxrZXIuaW5mbygnQXBwIHN0YXJ0ZWQgc3VjY2Vzc2Z1bGx5IScpOwogIHRhbGtlci5kZWJ1ZygnTG9hZGluZyB1c2VyIHByZWZlcmVuY2VzLi4uJyk7CiAgdGFsa2VyLndhcm5pbmcoJ0NhY2hlIGlzIGFsbW9zdCBmdWxsJyk7CiAgdGFsa2VyLmdvb2QoJ1VzZXIgcHJvZmlsZSBsb2FkZWQhJyk7CgogIC8vIEhhbmRsZSBleGNlcHRpb25zCiAgdHJ5IHsKICAgIHRocm93IEV4Y2VwdGlvbignTmV0d29yayByZXF1ZXN0IGZhaWxlZCcpOwogIH0gY2F0Y2ggKGUsIHN0KSB7CiAgICB0YWxrZXIuaGFuZGxlKGUsIHN0LCAnRmFpbGVkIHRvIGZldGNoIGRhdGEnKTsKICB9CgogIHRhbGtlci5jcml0aWNhbCgnRGF0YWJhc2UgY29ubmVjdGlvbiBsb3N0IScpOwogIHRhbGtlci5pbmZvKCdSZXRyeWluZyBjb25uZWN0aW9uLi4uJyk7CiAgdGFsa2VyLmdvb2QoJ0Nvbm5lY3Rpb24gcmVzdG9yZWQhJyk7Cn0%3D"
    loading="lazy"
  ></iframe>
</div>

</div>

<div class="packages-section">

## Packages Ecosystem

Talker is designed for any level of customization — pick what you need:

<div class="packages-grid">

<div class="package-card">

### [talker](https://pub.dev/packages/talker)

Main Dart package for logging and error handling. The core of the ecosystem.

</div>

<div class="package-card">

### [talker_flutter](https://pub.dev/packages/talker_flutter)

Flutter extensions — colored logs, TalkerScreen, TalkerMonitor, route observer, and more.

</div>

<div class="package-card">

### [talker_logger](https://pub.dev/packages/talker_logger)

Customizable pretty logger for Dart/Flutter apps. Can be used standalone.

</div>

<div class="package-card">

### [talker_dio_logger](https://pub.dev/packages/talker_dio_logger)

Beautiful HTTP request/response logging for Dio http client.

</div>

<div class="package-card">

### [talker_http_logger](https://pub.dev/packages/talker_http_logger)

HTTP logging for the standard http package with http_interceptor.

</div>

<div class="package-card">

### [talker_bloc_logger](https://pub.dev/packages/talker_bloc_logger)

State management logging for BLoC — events, transitions, state changes.

</div>

<div class="package-card">

### [talker_riverpod_logger](https://pub.dev/packages/talker_riverpod_logger)

Provider lifecycle logging for Riverpod — add, update, dispose, fail.

</div>

<div class="package-card">

### [talker_chopper_logger](https://pub.dev/packages/talker_chopper_logger)

HTTP logging for Chopper client with curl command support.

</div>

<div class="package-card">

### [talker_grpc_logger](https://pub.dev/packages/talker_grpc_logger)

gRPC request/response logging with token obfuscation.

</div>

</div>

</div>
