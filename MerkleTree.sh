#!/bin/bash

################################################################################
#                                Merkle Tree Script                            #
# This script generates a Merkle Tree from files in a specified directory.     #
# It outputs each level of the tree and the final root hash (Top Hash).        #
#                                                                              #
# Author: AFPL                                                    #
# Date: March 30, 2025                                                          #
################################################################################

# Pretty print function
print_level() {
  echo "Level $1:"
  local prefix="Node_"
  local index=0
  for h in "${@:2}"; do
    echo "  ${prefix}${index}: $h"
    ((index++))
  done
  echo
}

# Hashing function
hash_data() {
  echo -n "$1" | sha256sum | cut -d ' ' -f1
}

# Check usage
if [ $# -ne 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

DIR="$1"
if [ ! -d "$DIR" ]; then
  echo "Error: '$DIR' is not a directory"
  exit 1
fi

# Step 1: Gather file hashes
mapfile -t files < <(find "$DIR" -type f | sort)
if [ ${#files[@]} -eq 0 ]; then
  echo "No files found in $DIR"
  exit 1
fi

hashes=()
for f in "${files[@]}"; do
  filename=$(basename "$f")
  h=$(sha256sum "$f" | cut -d ' ' -f1)
  hashes+=("$filename: $h")
done

level=0
print_level $level "${hashes[@]}"

# Step 2: Build the tree
while [ ${#hashes[@]} -gt 1 ]; do
  new_hashes=()
  for ((i=0; i<${#hashes[@]}; i+=2)); do
    h1="${hashes[i]##*: }"
    if [ $((i+1)) -lt ${#hashes[@]} ]; then
      h2="${hashes[i+1]##*: }"
    else
      h2="$h1"
    fi
    combined_hash="$(hash_data "$h1$h2")"
    new_hashes+=("$combined_hash")
  done
  ((level++))
  print_level $level "${new_hashes[@]}"
  hashes=("${new_hashes[@]}")
done

# Step 3: Show final root
echo "🌳 Merkle Root: ${hashes[0]}"
