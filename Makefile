DARTANALYZER_FLAGS=--fatal-warnings

build: lib/*dart test/*dart deps
	flutter analyze ${DARTANALYZER_FLAGS} lib/
	dart format --set-exit-if-changed .
	flutter test --coverage --coverage-path ./coverage/lcov.info

deps: pubspec.yaml
	flutter packages get -v

reformatting:
	dart format .

build-local: reformatting build
	genhtml -o coverage coverage/lcov.info
	lcov --list coverage/lcov.info
	lcov --summary coverage/lcov.info
	open coverage/index.html

pana:
	pana -s path . --no-warning

docs:
	rm -rf doc
	flutter pub global run dartdoc

publish:
	dart pub publish