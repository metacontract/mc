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
    has_content=false

    for item in "$dir"/*; do
        if [ -f "$item" ]; then
            filename=$(basename "$item")
            case "$filename" in
                index.md|README.md)
                    # Skip index.md and README.md
                    ;;
                *.md)
                    # For .md files, use the file name as the link text
                    printf -- "- [%s](./%s)\n" "$(basename "$filename" .md)" "$filename"
                    has_content=true
                    ;;
                *)
                    # For non-.md files, use the full filename as the link text
                    printf -- "- [%s](./%s)\n" "$filename" "$filename"
                    has_content=true
                    ;;
            esac
        elif [ -d "$item" ]; then
            dirname=$(basename "$item")
            # For directories, create a link to the index.md file inside
            printf -- "- [%s](./%s/index.md)\n" "$dirname" "$dirname"
            has_content=true
        fi
    done

    # If no content was generated, return non-zero exit code
    if [ "$has_content" = false ]; then
        return 1
    fi
}

update_index_content() {
    index_file="$1"
    temp_file="${index_file}.tmp"
    start_marker="<!-- START_INDEX -->"
    end_marker="<!-- END_INDEX -->"

    # Generate new content
    new_content=$(generate_links_for_directory "$(dirname "$index_file")") || {
        echo "No content generated for index. The directory might be empty or contain only index.md/README.md."
        return 1
    }

    # Check if the file exists and contains markers
    if [ -f "$index_file" ] && grep -q "$start_marker" "$index_file" && grep -q "$end_marker" "$index_file"; then
        # Update existing file while preserving marker positions
        {
            sed -n "1,/$start_marker/p" "$index_file"
            echo "$new_content"
            sed -n "/$end_marker/,\$p" "$index_file"
        } > "$temp_file"

        # Check if the temp file was created successfully
        if [ -s "$temp_file" ]; then
            mv "$temp_file" "$index_file"
        else
            echo "Error: Failed to update index file" >&2
            rm -f "$temp_file"
            return 1
        fi
    else
        # Create new file with content
        {
            echo "# Index"
            echo
            echo "$start_marker"
            echo "$new_content"
            echo "$end_marker"
        } > "$index_file"
    fi
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
        update_index_content "$index_file" || {
            echo "Failed to update index.md. The directory might be empty or contain only index.md/README.md."
            return 1
        }
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
