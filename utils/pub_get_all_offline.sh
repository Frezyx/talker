#!/bin/sh

cd packages

echo "talker"
cd talker
flutter pub get --offline
cd ..

echo "talker_flutter"
cd talker_flutter
flutter pub get --offline

echo "talker_flutter_example"
cd example
flutter pub get --offline
cd ../..

echo "talker_logger"
cd talker_logger
flutter pub get --offline
cd ..