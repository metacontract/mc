#!/usr/bin/env sh

set -e  # Exit immediately if a command exits with a non-zero status.

# Import functions from other scripts
. "$(dirname "$0")/soldocs/gen_index_remove_unnecessary_content.sh"
. "$(dirname "$0")/soldocs/gen_index_format_relative_links.sh"
. "$(dirname "$0")/soldocs/gen_index_copy_readme_to_index.sh"

count_md_files() {
    dir="$1"
    find "$dir" -maxdepth 1 -type f -name "*.md" ! -name "index.md" ! -name "README.md" | wc -l
}

generate_links_for_directory() {
    dir="$1"
    for file in "$dir"/*; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            case "$filename" in
                index.md|README.md)
                    # Skip index.md and README.md
                    ;;
                *.md)
                    # For .md files, use the file name as the link text
                    echo "- [$(basename "$filename" .md)](./$filename)"
                    ;;
                *)
                    # For non-.md files, use the full filename as the link text
                    echo "- [$filename](./$filename)"
                    ;;
            esac
        fi
    done
}

gen_index_update_index() {
    if [ -z "$1" ]; then
        echo "Error: Base path is required" >&2
        return 1
    fi
    basepath="$1"
    readme_file="${basepath}README.md"
    index_file="${basepath}index.md"

    echo "Starting update_index for $basepath"
    echo "README file: $readme_file"
    echo "Index file: $index_file"

    # Check if README.md exists
    if [ -f "$readme_file" ]; then
        echo "README.md found. Processing..."
        # Step 1: Remove unnecessary content from README.md
        gen_index_remove_unnecessary_content "$readme_file" || { echo "Failed to remove unnecessary content"; return 1; }

        # Step 2: Format links to be relative in README.md
        gen_index_format_relative_links "$readme_file" "$basepath" || { echo "Failed to format relative links"; return 1; }

        # Step 3: Copy processed content to index.md
        gen_index_copy_readme_to_index "$basepath" "$readme_file" || { echo "Failed to copy content to index.md"; return 1; }

        # Step 4: Remove README.md
        rm "$readme_file"
    else
        echo "README.md not found. Checking directory contents..."
        md_count=$(count_md_files "$basepath")
        if [ "$md_count" -eq 0 ] || [ "$md_count" -gt 1 ]; then
            echo "Generating links for directory contents..."
            {
                echo "# Index"
                echo
                echo "<!-- START_INDEX -->"
                generate_links_for_directory "$basepath"
                echo "<!-- END_INDEX -->"
            } > "$index_file"
        else
            echo "Only one .md file found (excluding README.md and index.md). Skipping index.md creation."
        fi
    fi

    echo "Index update completed for $basepath"
}

# Use the function if this script is run directly
if [ "$(basename "$0")" = "gen_index_update_index.sh" ]; then
    if [ $# -eq 0 ]; then
        echo "Error: Please provide a base path" >&2
        exit 1
    fi
    gen_index_update_index "$1"
fi
