# Compiler
CC = gcc

# Source file
SRCS = main.c

# Target executable
TARGET = cache

# Default target
all: $(TARGET)

# Link source file into the target executable
$(TARGET): $(SRCS)
	$(CC) $(SRCS) -o $(TARGET)

# Clean up the target executable
clean:
	rm -f $(TARGET)
