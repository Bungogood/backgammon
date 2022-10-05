SRC_DIR := src
BIN_DIR := .
LIB_DIR := lib
INC_DIR := inc
OBJ_DIR := .obj

TARGET  := $(BIN_DIR)/backgammon

CXX	     = g++
CXXFLAGS = -std=c++20 -c -g -Wall

SOURCES := $(shell find $(SRC_DIR) -name "*.cpp")
OBJECTS := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SOURCES))
HEADERS := $(shell find $(INC_DIR) -name "*.hpp")
# sort is just to remove duplicates. Not necessary, but tidy
HEADERDIRS := $(sort $(dir $(HEADERS)))
INCLUDEFLAGS := $(addprefix -I,$(HEADERDIRS))

.PHONY: all clean

all: $(TARGET)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	@$(CXX) $< $(INCLUDEFLAGS) -o $@ $(CXXFLAGS)

$(TARGET): $(OBJECTS)
	@mkdir -p $(@D)
	$(CXX) $^ -o $@

clean:
	rm -f $(OBJECTS) $(TARGET)
