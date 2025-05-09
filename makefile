CXX = g++
CXXFLAGS = -g -Wall
LDFLAGS = -pthread -lgtest -lgtest_main -L/resources/dmbcs -ldmbcs-kraken-api -L/usr/local/lib -lcurlpp -lcurl -lssl -lcrypto

# Directories
SRC_DIR = src
TEST_DIR = test
BUILD_DIR = build
APP_NAME = my_application

# Simdjson
SIMDJSON = resources/simdjson/simdjson.cpp

# Application source files
APP_SOURCES = $(wildcard $(SRC_DIR)/*.cpp)

# Test source files
TEST_SOURCES = $(wildcard $(TEST_DIR)/*.cpp)

# Build targets
APP_EXEC = $(BUILD_DIR)/$(APP_NAME)
TEST_EXEC = $(BUILD_DIR)/run_tests

# Default target
.PHONY: all test clean run

# Build both the application and the tests
all: $(APP_EXEC) $(TEST_EXEC)

# Compile the application
$(APP_EXEC): $(APP_SOURCES) $(SIMDJSON)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

# Compile the tests
$(TEST_EXEC): $(TEST_SOURCES)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

# Run the application
run: $(APP_EXEC)
	$(APP_EXEC)

# Run the tests
test: $(TEST_EXEC)
	$(TEST_EXEC)

# Clean build files
clean:
	rm -rf $(BUILD_DIR)