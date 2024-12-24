# Makefile for Flutter Project (Nam)

# Variables
FLUTTER=flutter
DEVICE=chrome    # Default target device (can be overridden)

# Default target: Build and run the app
.PHONY: run
run:
	$(FLUTTER) run -d $(DEVICE)

# Run app on macOS
.PHONY: run-macos
run-macos:
	$(FLUTTER) run -d macos

# Run app on Chrome
.PHONY: run-chrome
run-chrome:
	$(FLUTTER) run -d chrome

# Build the app (Debug Build)
.PHONY: build
build:
	$(FLUTTER) build apk --debug

# Build the app for release
.PHONY: build-release
build-release:
	$(FLUTTER) build apk --release

# Build the app for web
.PHONY: build-web
build-web:
	$(FLUTTER) build web

# Build the app for macOS
.PHONY: build-macos
build-macos:
	$(FLUTTER) build macos

# Clean build files
.PHONY: clean
clean:
	$(FLUTTER) clean

# Format code
.PHONY: format
format:
	$(FLUTTER) format .

# Run tests
.PHONY: test
test:
	$(FLUTTER) test

# Analyze code
.PHONY: analyze
analyze:
	$(FLUTTER) analyze

# Upgrade Flutter dependencies
.PHONY: pub-upgrade
pub-upgrade:
	$(FLUTTER) pub upgrade

# Generate documentation
.PHONY: doc
doc:
	dartdoc

# Pre-push checks
.PHONY: pre-push
pre-push:
	@echo "Running pre-push checks..."
	@$(FLUTTER) analyze || { echo "Static analysis failed!"; exit 1; }
	@$(FLUTTER) test || { echo "Tests failed!"; exit 1; }
	@$(FLUTTER) format --set-exit-if-changed . || { echo "Code formatting issues detected! Run 'make format' to fix them."; exit 1; }
	@echo "All pre-push checks passed. Ready to push."

# Test coverage
.PHONY: coverage
coverage:
	@echo "Running tests with coverage..."
	$(FLUTTER) test --coverage
	@echo "Coverage report generated at coverage/lcov.info"

# View coverage report
.PHONY: view-coverage
view-coverage:
	@echo "Generating HTML coverage report..."
	genhtml coverage/lcov.info -o coverage/html
	@echo "Opening HTML coverage report..."
	open coverage/html/index.html

# Clean coverage files
.PHONY: clean-coverage
clean-coverage:
	@echo "Cleaning up coverage files..."
	rm -rf coverage/

# Full coverage workflow
.PHONY: full-coverage
full-coverage: coverage view-coverage

# Help menu
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  run            - Build and run the app on the default device ($(DEVICE))"
	@echo "  run-macos      - Build and run the app on macOS"
	@echo "  run-chrome     - Build and run the app on Chrome"
	@echo "  build          - Build the app (Debug Build)"
	@echo "  build-release  - Build the app for release (APK for Android)"
	@echo "  build-web      - Build the app for web"
	@echo "  build-macos    - Build the app for macOS"
	@echo "  clean          - Clean the build files"
	@echo "  format         - Format the Dart code"
	@echo "  test           - Run all tests"
	@echo "  analyze        - Analyze the code for potential issues"
	@echo "  pub-upgrade    - Upgrade Flutter dependencies"
	@echo "  doc            - Generate documentation using dartdoc"
	@echo "  pre-push       - Run pre-push checks (analyze, test, and format)"
	@echo "  coverage       - Generate test coverage report (lcov format)"
	@echo "  view-coverage  - Generate and view HTML test coverage report"
	@echo "  clean-coverage - Clean test coverage files"
	@echo "  full-coverage  - Run tests with coverage and view the HTML report"
