# Compiler and flags
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -pthread

# Project directories
INCLUDE_DIR = include
SRC_DIR = src
FRONTEND_DIR = frontend
BUILD_DIR = build
BIN_DIR = bin

# vcpkg configuration (adjust this path if your vcpkg is elsewhere)
VCPKG_DIR = $(HOME)/vcpkg
VCPKG_INC = vcpkg/installed/x64-linux/include
VCPKG_LIB = vcpkg/installed/x64-linux/lib

# Optional Wt includes (if you're using Wt)
WT_INC = /usr/local/include
WT_LIB = /usr/local/lib

# Linked libraries (from vcpkg)
LIBS = -lboost_system -lpthread -lsqlite3

# Source and object files
SRC_FILES := $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(SRC_FILES:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)

# Output binary
BACKEND_BIN = $(BIN_DIR)/taskmaster_backend

# Create build and bin dirs if not present
$(shell mkdir -p $(BUILD_DIR) $(BIN_DIR))

# Default target
all: $(BACKEND_BIN)

# Linking
$(BACKEND_BIN): $(OBJ_FILES)
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -I$(WT_INC) -I$(VCPKG_INC) $^ -L$(WT_LIB) -L$(VCPKG_LIB) $(LIBS) -o $@

# Compiling
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -I$(INCLUDE_DIR) -I$(WT_INC) -I$(VCPKG_INC) -c $< -o $@

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)/*.o $(BACKEND_BIN)

.PHONY: all clean