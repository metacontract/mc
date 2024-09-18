#!/usr/bin/env sh

set -e  # Exit immediately if a command exits with a non-zero status.

# Import functions from other scripts
. "$(dirname "$0")/soldocs/gen_index_update_index.sh"

# Function to recursively process directories
gen_index_process_directory() {
    if [ -z "$1" ]; then
        echo "Error: Directory path is required" >&2
        return 1
    fi
    dir="$1"

    echo "Processing directory: $dir"

    # Process current directory
    gen_index_update_index "$dir"

    # Process subdirectories
    find "$dir" -mindepth 1 -type d | while read -r subdir; do
        gen_index_process_directory "$subdir/"
    done

    echo "Index files have been updated successfully in $dir and its subdirectories."
}

# Main function
generate_index() {
    if [ -z "$1" ]; then
        echo "Error: Directory path is required" >&2
        return 1
    fi
    gen_index_process_directory "$1"
}

# Use the function if this script is run directly
if [ "$(basename "$0")" = "generate_index.sh" ]; then
    if [ $# -eq 0 ]; then
        echo "Error: Please provide a directory path" >&2
        exit 1
    fi
    generate_index "$1"
fi
