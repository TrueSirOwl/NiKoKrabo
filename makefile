CXX = g++
CXXFLAGS = -g3 -Wall
LDFLAGS = -pthread -L./resources/dmbcs -ldmbcs-kraken-api -lcurlpp -lcurl -lssl -lcrypto -Wl,-rpath=./resources/dmbcs
TESTFLAGS = -lgtest -lgtest_main

# Directories
SRC_DIR = src
TEST_DIR = test
OBJ_DIR = obj
BUILD_DIR = build
APP_NAME = my_application

# Simdjson
SIMDJSON_SRC = resources/simdjson/simdjson.cpp

# Application source files
APP_SOURCES = $(wildcard $(SRC_DIR)/*.cpp)

# Test source files
TEST_SOURCES = $(wildcard $(TEST_DIR)/*.cpp)

# Obj Files
TEST_OBJS = $(patsubst %.cpp,$(OBJ_DIR)/%.o,$(TEST_SOURCES))
APP_OBJS = $(patsubst %.cpp,$(OBJ_DIR)/%.o,$(APP_SOURCES)) $(patsubst %.cpp,$(OBJ_DIR)/%.o,$(SIMDJSON_SRC))

# Obj Files rule
$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Build targets
APP_EXEC = $(BUILD_DIR)/$(APP_NAME)
TEST_EXEC = $(BUILD_DIR)/run_tests

# Default target
.PHONY: all test clean fclean re run 

# Build both the application and the tests
all: $(APP_EXEC) $(TEST_EXEC)


# Compile the application
$(APP_EXEC): $(APP_OBJS)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

# Compile the tests
$(TEST_EXEC): $(TEST_OBJS)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS) $(TESTFLAGS)

# Run the application
run: $(APP_EXEC)
	$(APP_EXEC)

# Run the tests
test: $(TEST_EXEC)
	$(TEST_EXEC)

# Clean build files
clean:
	rm -rf $(OBJ_DIR)

# Clean executable files
fclean: clean
	rm -rf $(BUILD_DIR)

# redo: clean all -> recompile
re: fclean all
