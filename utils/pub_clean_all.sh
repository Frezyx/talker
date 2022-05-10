#!/bin/sh

echo "talker"
cd packages/talker
flutter clean

echo "talker_flutter"
cd ../talker_flutter
flutter clean

echo "talker_logger"
cd ../talker_logger
flutter clean