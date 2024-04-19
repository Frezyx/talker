A pure Dart script that fetches the list of comics from https://developer.marvel.com/

This showcases how to use [riverpod] without Flutter.\
It also shows how a provider can depend on another provider asynchronously loaded.

# Installation

To run this example, you will need to set your public key and private key on the models.dart file and generate files

```dart
final hash = md5
        .convert(
          utf8.encode(
            '$timestamp${"<your private key>"}${"<your public key>"}',
          ),
        )
        .toString();

final result = await _client.get<Map<String, Object?>>(
      'http://gateway.marvel.com/v1/public/comics',
      queryParameters: <String, Object?>{
        'ts': timestamp,
        'apikey': "<your public key>",
        'hash': hash,
      },
    );
```

```bash
dart run build_runner build --delete-conflicting-outputs
```

Where `public_key` and `private_key` are obtained from https://developer.marvel.com/account