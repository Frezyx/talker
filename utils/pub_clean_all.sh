#!/bin/sh

cd packages

echo "talker"
cd talker
flutter clean
cd ..

echo "talker_flutter"
cd talker_flutter
flutter clean

echo "talker_flutter_example"
cd example
flutter clean
cd ../..

echo "talker_logger"
cd talker_logger
flutter clean
cd ..