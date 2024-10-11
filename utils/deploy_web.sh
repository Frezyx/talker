#!/bin/sh

cd examples/shop_app_example
flutter pub get
flutter pub global run peanut 
git push origin --set-upstream gh-pages -f