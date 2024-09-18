#!/usr/bin/env sh

set -e  # Exit immediately if a command exits with a non-zero status.

gen_index_format_relative_links() {
    file="$1"
    basepath="$2"
    temp_file="${file}.tmp"

    while IFS= read -r line; do
        if echo "$line" | grep -q '^\- \[.*\](.*)'
        then
            name=$(echo "$line" | sed -E 's/^\- \[(.*)\]\(.*\)$/\1/')
            path=$(echo "$line" | sed -E 's/^\- \[.*\]\((.*)\)$/\1/')

            # Check if the path already starts with ./ and ends with index.md
            if echo "$path" | grep -q '^\.\/.*index\.md$'; then
                echo "$line"
            else
                # Remove everything before ./docs/ if present
                path=$(echo "$path" | sed 's/.*\.\/docs\///')

                # Extract the last two parts of the path
                path=$(echo "$path" | awk -F'/' '{if (NF>1) print $(NF-1)"/"$NF; else print $NF}')

                # If the second-to-last part doesn't end with .sol, use only the last part
                if ! echo "$path" | grep -q '\.sol/'; then
                    path=$(echo "$path" | awk -F'/' '{print $NF}')
                fi

                # If the path doesn't end with .md, assume it's a directory and add index.md
                if ! echo "$path" | grep -q '\.md$'; then
                    path="${path%/}/index.md"
                fi

                # Print the formatted link
                echo "- [$name](./$path)"
            fi
        else
            echo "$line"
        fi
    done < "$file" > "$temp_file"

    mv "$temp_file" "$file"
    echo "Formatted relative links in $file"
}

# Use the function if this script is run directly
if [ "$(basename "$0")" = "gen_index_format_relative_links.sh" ]; then
    gen_index_format_relative_links "$1" "$2"
fi
