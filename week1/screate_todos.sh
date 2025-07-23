#!/bin/bash

# Set the target directory
TARGET_DIR="/Users/coditas/Desktop/wednesday/learningios/week1"

# Create the directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Loop to create files
for i in {1..21}; do
  touch "$TARGET_DIR/todo$i.swift"
done

echo "Created todo1.swift to todo21.swift in $TARGET_DIR"
