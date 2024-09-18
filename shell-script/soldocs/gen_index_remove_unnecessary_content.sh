#!/usr/bin/env sh

set -e  # Exit immediately if a command exits with a non-zero status.

gen_index_remove_unnecessary_content() {
    file="$1"
    # Remove "# Contents" line and keep only the link list
    sed -i.bak '/^# Contents$/d; /^- /,$!d' "$file" && rm -f "${file}.bak"
    echo "Removed unnecessary content from $file"
}

# Use the function if this script is run directly
if [ "$(basename "$0")" = "gen_index_remove_unnecessary_content.sh" ]; then
    gen_index_remove_unnecessary_content "$1"
fi
