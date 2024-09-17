#!/bin/sh

# Source the index utilities
source shell-script/index-utils.sh

# Generate solidity docs
generate_solidity_docs() {
    forge doc -o soldocs/
}

# Move generated docs to appropriate directories
move_docs() {
    mv soldocs/src/src/std/* docs/04-plugin-functions/05-std
    mv soldocs/src/src/devkit/* docs/05-resources/04-devkit/02-utils
}

# Main function
main() {
    generate_solidity_docs
    move_docs

    # Process directories
    process_directory docs/04-plugin-functions/05-std
    process_directory docs/05-resources/04-devkit/02-utils

    # Remove unnecessary soldocs/
    rm -rf soldocs

    echo "Solidity docs successfully generated and index updated!"
}

# Run the main function
main
