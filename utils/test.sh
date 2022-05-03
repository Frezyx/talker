#!/bin/sh

echo "talker"
cd packages/talker
flutter test

echo "talker_flutter"
cd ../talker_flutter
flutter test

echo "talker_logger"
cd ../talker_logger
flutter test