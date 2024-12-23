#!/bin/sh

echo "talker"
cd packages/talker
flutter pub get

echo "talker_flutter"
cd ../talker_flutter
flutter pub get

echo "talker_flutter_example"
cd example
flutter pub get
cd ..

echo "talker_logger"
cd ../talker_logger
flutter pub get

echo "talker_dio_logger"
cd ../talker_dio_logger
flutter pub get

echo "talker_bloc_logger"
cd ../talker_bloc_logger
flutter pub get

echo "talker_http_logger"
cd ../talker_http_logger
flutter pub get

echo "talker_riverpod_logger"
cd ../talker_riverpod_logger
flutter pub get

echo "shop_app_example"
cd ../../examples/shop_app_example
flutter pub get

echo "custom_logs_example"
cd ../../examples/custom_logs_example
flutter pub get