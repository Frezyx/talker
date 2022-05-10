#!/bin/sh

echo "talker"
cd packages/talker
flutter pub get

echo "talker_flutter"
cd ../talker_flutter
flutter pub get

echo "talker_logger"
cd ../talker_logger
flutter pub get