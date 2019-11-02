DARTANALYZER_FLAGS=--fatal-warnings

build: lib/*dart test/*dart deps
	dartanalyzer ${DARTANALYZER_FLAGS} lib/
	dartfmt -n --set-exit-if-changed lib/ test/
	flutter test --coverage --coverage-path ./coverage/lcov.info

deps: pubspec.yaml
	flutter packages get -v

reformatting:
	dartfmt -w lib/ test/

build-local: reformatting build
	genhtml -o coverage coverage/lcov.info
	open coverage/index.html

docs:
	rm -rf doc
	dartdoc

publish:
	pub publish