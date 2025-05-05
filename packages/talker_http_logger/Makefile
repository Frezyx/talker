# Makefile

help:
	@printf "%-20s %s\n" "Target" "Description"
	@printf "%-20s %s\n" "------" "-----------"
	@make -pqR : 2>/dev/null \
		| awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
		| sort \
		| egrep -v -e '^[^[:alnum:]]' -e '^$@$$' \
		| xargs -I _ sh -c 'printf "%-20s " _; make _ -nB | (grep -i "^# Help:" || echo "") | tail -1 | sed "s/^# Help: //g"'

analyze:
	@# Help: Analyze the project's Dart code.
	dart analyze --fatal-infos

check_format:
	@# Help: Check the formatting of one or more Dart files.
	dart format --output=none --set-exit-if-changed .

check_outdated:
	@# Help: Check which of the project's packages are outdated.
	dart pub outdated

check_style:
	@# Help: Analyze the project's Dart code and check the formatting one or more Dart files.
	make analyze && make check_format

code_gen:
	@# Help: Run the build system for Dart code generation and modular compilation.
	dart run build_runner build --delete-conflicting-outputs

code_gen_watcher:
	@# Help: Run the build system for Dart code generation and modular compilation as a watcher.
	dart run build_runner watch --delete-conflicting-outputs

format:
	@# Help: Format one or more Dart files.
	dart format .

install:
	@# Help: Install all the project's packages
	dart pub get

sure:
	@# Help: Analyze the project's Dart code, check the formatting one or more Dart files and run unit tests for the current project.
	make check_style && make tests

show_test_coverage:
	@# Help: Run Dart unit tests for the current project and show the coverage.
	dart pub global activate coverage && dart pub global run coverage:test_with_coverage
	lcov --remove coverage/lcov.info '**.g.dart' '**.mock.dart' -o coverage/lcov_without_generated_code.info --ignore-errors unused
	genhtml coverage/lcov_without_generated_code.info -o coverage/html
	source tool/makefile_helpers.sh && open_link "coverage/html/index.html"

tests:
	@# Help: Run Dart unit and widget tests for the current project.
	dart test

upgrade:
	@# Help: Upgrade all the project's packages.
	dart pub upgrade
