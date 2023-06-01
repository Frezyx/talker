#!/bin/sh

echo "talker"
cd packages/talker
dart test

echo "talker_flutter"
cd ../talker_flutter
flutter test

echo "talker_logger"
cd ../talker_logger
dart test

echo "talker_dio_logger"
cd ../talker_dio_logger
dart test

echo "talker_bloc_logger"
cd ../talker_bloc_logger
dart test