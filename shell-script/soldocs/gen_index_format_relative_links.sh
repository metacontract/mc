#!/usr/bin/env sh

set -e  # Exit immediately if a command exits with a non-zero status.

format_link() {
    name="$1"
    path="$2"

    # Remove everything before ./docs/ if present
    path="${path#*./docs/}"

    # Extract the last two parts of the path
    path=$(echo "$path" | awk -F'/' '{if (NF>1) print $(NF-1)"/"$NF; else print $NF}')

    # If the second-to-last part doesn't end with .sol, use only the last part
    case "$path" in
        *".sol/"*) ;;
        *) path=$(echo "$path" | awk -F'/' '{print $NF}') ;;
    esac

    # If the path doesn't end with .md, assume it's a directory and add index.md
    case "$path" in
        *.md) ;;
        *) path="${path%/}/index.md" ;;
    esac

    echo "- [$name](./$path)"
}

gen_index_format_relative_links() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Error: File and base path are required" >&2
        return 1
    fi
    file="$1"
    basepath="$2"
    temp_file="${file}.tmp"

    while IFS= read -r line; do
        case "$line" in
            "- ["*)
                name="${line#- [}"
                name="${name%%]*}"
                path="${line#*](}"
                path="${path%)}"

                if echo "$path" | grep -q '^\.\/.*index\.md$'; then
                    echo "$line"
                else
                    format_link "$name" "$path"
                fi
                ;;
            *) echo "$line" ;;
        esac
    done < "$file" > "$temp_file"

    mv "$temp_file" "$file"
    echo "Formatted relative links in $file"
}

# Use the function if this script is run directly
if [ "$(basename "$0")" = "gen_index_format_relative_links.sh" ]; then
    if [ $# -lt 2 ]; then
        echo "Error: Please provide a file and a base path" >&2
        exit 1
    fi
    gen_index_format_relative_links "$1" "$2"
fi
