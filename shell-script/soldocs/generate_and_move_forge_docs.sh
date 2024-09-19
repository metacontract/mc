#!/usr/bin/env sh

set -e  # Exit immediately if a command exits with a non-zero status.

# Generate solidity docs using `forge doc``
generate_forge_docs() {
    forge doc -o soldocs/ || { echo "Failed to generate solidity docs"; exit 1; }
}

# Move generated docs to appropriate directories
move_forge_docs() {
    cp -r soldocs/src/src/std/ docs/04-plugin-functions/05-std/ || { echo "Failed to move plugin docs"; exit 1; }
    cp -r soldocs/src/src/devkit/ docs/05-resources/03-devkit/03-api-reference/ || { echo "Failed to move devkit docs"; exit 1; }
}

# Remove unnecessary soldocs/
remove_forge_docs() {
    rm -rf soldocs
}

# Main function
generate_and_move_forge_docs() {
    generate_forge_docs
    move_forge_docs
    remove_forge_docs
}

# Use the function if this script is run directly
if [ "$(basename "$0")" = "generate_and_move_forge_docs.sh" ]; then
    generate_and_move_forge_docs
fi
