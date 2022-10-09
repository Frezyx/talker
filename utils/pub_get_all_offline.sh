#!/bin/sh

echo "talker"
cd packages/talker
flutter pub get --offline

echo "talker_flutter"
cd ../talker_flutter
flutter pub get --offline

echo "talker_logger"
cd ../talker_logger
flutter pub get --offline

echo "talker_dio_logger"
cd ../talker_dio_logger
flutter pub get --offline