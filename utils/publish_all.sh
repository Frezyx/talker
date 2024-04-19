#!/bin/sh

cd packages/talker_logger
flutter pub publish
cd ../../

cd packages/talker
flutter pub publish
cd ../../

cd packages/talker_flutter
flutter pub publish
cd ../../

cd packages/talker_dio_logger
flutter pub publish
cd ../../

cd packages/talker_bloc_logger
flutter pub publish
cd ../../

cd packages/talker_riverpod_logger
flutter pub publish
cd ../../