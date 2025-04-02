#####################################
    Merkle Tree Script             
#####################################
Description

This script generates a Merkle Tree from files in a specified directory. It outputs each level of the tree and the final root hash (Top Hash). 
The purpose of the Merkle Tree is to ensure data integrity by allowing verification of all files within a directory through a single root hash.

Author: AFPL
Date: march 30, 2025

#####################################
            Features
#####################################
1. Generates a Merkle Tree from all files in a specified directory.
2. Outputs hashes at each level of the tree.
3. Produces a final root hash known as the Top Hash.
4. Supports large directories with numerous files.
5. Uses SHA-256 for hashing.

#####################################
          Requirements
#####################################
1. Linux or macOS environment (or Windows with WSL).
2. Bash shell.
3. sha256sum command available (usually pre-installed on Linux systems).

#####################################
        Usage
#####################################
./merkle_tree.sh <directory>
./merkle_tree.sh <directory>

#####################################
      Output Format
#####################################
Level 0:
  Node_0: filename1: hash1
  Node_1: filename2: hash2
  ...

Level 1:
  Node_0: combined_hash1
  Node_1: combined_hash2
  ...


 Merkle Root: final_top_hash
 
#####################################
          Troubleshooting
#####################################

Ensure the specified directory exists and contains files.
Hidden files (e.g., .DS_Store on macOS) may affect the hash if not excluded.
If the hash changes unexpectedly, check for files that may have been modified or added.
