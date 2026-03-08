# Examples

## Interactive DartPad Examples

### Basic Logging

Try Talker's logging levels in your browser:

<div class="dartpad-embed">
  <iframe
    src="https://dartpad.dev/embed-dart.html?run=true&split=50&theme=dark&code=aW1wb3J0ICdwYWNrYWdlOnRhbGtlci90YWxrZXIuZGFydCc7Cgp2b2lkIG1haW4oKSB7CiAgZmluYWwgdGFsa2VyID0gVGFsa2VyKCk7CgogIHRhbGtlci5pbmZvKCdBcHAgc3RhcnRlZCBzdWNjZXNzZnVsbHkhJyk7CiAgdGFsa2VyLmRlYnVnKCdMb2FkaW5nIHVzZXIgcHJlZmVyZW5jZXMuLi4nKTsKICB0YWxrZXIud2FybmluZygnQ2FjaGUgaXMgYWxtb3N0IGZ1bGwnKTsKICB0YWxrZXIuZ29vZCgnVXNlciBwcm9maWxlIGxvYWRlZCEnKTsKICB0YWxrZXIudmVyYm9zZSgnRGV0YWlsZWQgdHJhY2UgaW5mb3JtYXRpb24nKTsKICB0YWxrZXIuY3JpdGljYWwoJ0RhdGFiYXNlIGNvbm5lY3Rpb24gbG9zdCEnKTsKfQ%3D%3D"
    loading="lazy"
    style="width: 100%; height: 400px; border: none;"
  ></iframe>
</div>

### Error Handling

See how Talker handles exceptions with stack traces:

<div class="dartpad-embed">
  <iframe
    src="https://dartpad.dev/embed-dart.html?run=true&split=50&theme=dark&code=aW1wb3J0ICdwYWNrYWdlOnRhbGtlci90YWxrZXIuZGFydCc7Cgp2b2lkIG1haW4oKSB7CiAgZmluYWwgdGFsa2VyID0gVGFsa2VyKCk7CgogIC8vIEhhbmRsZSBhbiBFeGNlcHRpb24KICB0cnkgewogICAgdGhyb3cgRXhjZXB0aW9uKCdOZXR3b3JrIHJlcXVlc3QgZmFpbGVkJyk7CiAgfSBjYXRjaCAoZSwgc3QpIHsKICAgIHRhbGtlci5oYW5kbGUoZSwgc3QsICdGYWlsZWQgdG8gZmV0Y2ggdXNlciBkYXRhJyk7CiAgfQoKICAvLyBIYW5kbGUgYW4gRXJyb3IKICB0cnkgewogICAgdGhyb3cgQXJndW1lbnRFcnJvcignSW52YWxpZCB1c2VyIElEJyk7CiAgfSBjYXRjaCAoZSwgc3QpIHsKICAgIHRhbGtlci5oYW5kbGUoZSwgc3QsICdWYWxpZGF0aW9uIGVycm9yJyk7CiAgfQoKICAvLyBBY2Nlc3MgaGlzdG9yeQogIHByaW50KCdcbi0tLSBIaXN0b3J5ICgtLS0nKTsKICBwcmludCgnVG90YWwgbG9nczogJHt0YWxrZXIuaGlzdG9yeS5sZW5ndGh9Jyk7Cn0%3D"
    loading="lazy"
    style="width: 100%; height: 450px; border: none;"
  ></iframe>
</div>

### Custom Log Types

Create your own log types:

<div class="dartpad-embed">
  <iframe
    src="https://dartpad.dev/embed-dart.html?run=true&split=50&theme=dark&code=aW1wb3J0ICdwYWNrYWdlOnRhbGtlci90YWxrZXIuZGFydCc7CgpjbGFzcyBIdHRwTG9nIGV4dGVuZHMgVGFsa2VyTG9nIHsKICBIdHRwTG9nKFN0cmluZyBzdXBlci5tZXNzYWdlKTsKCiAgQG92ZXJyaWRlCiAgU3RyaW5nIGdldCBrZXkgPT4gJ2h0dHBfbG9nJzsKCiAgQG92ZXJyaWRlCiAgU3RyaW5nIGdldCB0aXRsZSA9PiAnSFRUUCc7CgogIEBvdmVycmlkZQogIEFuc2lQZW4gZ2V0IHBlbiA9PiBBbnNpUGVuKCkuLmN5YW4oKTsKfQoKY2xhc3MgQW5hbHl0aWNzTG9nIGV4dGVuZHMgVGFsa2VyTG9nIHsKICBBbmFseXRpY3NMb2coU3RyaW5nIGV2ZW50LCB0aGlzLnBhcmFtcykgOiBzdXBlcihldmVudCk7CgogIGZpbmFsIE1hcDxTdHJpbmcsIGR5bmFtaWM%2BIHBhcmFtczsKCiAgQG92ZXJyaWRlCiAgU3RyaW5nIGdldCBrZXkgPT4gJ2FuYWx5dGljcyc7CgogIEBvdmVycmlkZQogIFN0cmluZyBnZXQgdGl0bGUgPT4gJ0FOQUxZVElDUyc7CgogIEBvdmVycmlkZQogIEFuc2lQZW4gZ2V0IHBlbiA9PiBBbnNpUGVuKCkuLm1hZ2VudGEoKTsKCiAgQG92ZXJyaWRlCiAgU3RyaW5nIGdlbmVyYXRlVGV4dE1lc3NhZ2Uoe1RpbWVGb3JtYXQ%2FIHRpbWVGb3JtYXR9KSB7CiAgICByZXR1cm4gJyR7c3VwZXIuZ2VuZXJhdGVUZXh0TWVzc2FnZSh0aW1lRm9ybWF0OiB0aW1lRm9ybWF0KX1cblBhcmFtczogJHBhcmFtcyc7CiAgfQp9Cgp2b2lkIG1haW4oKSB7CiAgZmluYWwgdGFsa2VyID0gVGFsa2VyKCk7CgogIHRhbGtlci5sb2dDdXN0b20oSHR0cExvZygnR0VUIC9hcGkvdXNlcnMg4oCUICAyMDAgT0snKSk7CgogIHRhbGtlci5sb2dDdXN0b20oCiAgICBBbmFseXRpY3NMb2coJ3VzZXJfbG9naW4nLCB7J21ldGhvZCc6ICdnb29nbGUnfSksCiAgKTsKCiAgdGFsa2VyLmluZm8oJ1JlZ3VsYXIgaW5mbyBsb2cgZm9yIGNvbXBhcmlzb24nKTsKfQ%3D%3D"
    loading="lazy"
    style="width: 100%; height: 500px; border: none;"
  ></iframe>
</div>

## Shop App Example

A full production-like Flutter application demonstrating Talker integration:

- Talker setup with DI
- HTTP logging with Dio
- BLoC state management logging
- TalkerScreen and TalkerMonitor
- Error handling with TalkerWrapper
- Route logging

📂 [View Shop App on GitHub](https://github.com/Frezyx/talker/tree/master/examples/shop_app_example)

## Web Demo

Try the fully interactive Flutter web demo with `TalkerScreen` and `TalkerMonitor`:

🌐 [Open Web Demo](https://frezyx.github.io/talker)

<style>
.dartpad-embed {
  border: 1px solid var(--vp-c-divider);
  border-radius: 12px;
  overflow: hidden;
  margin: 16px 0;
}
</style>
