#!/bin/sh

# Function to generate index content
generate_index() {
    local dir=$1
    local indent=$2

    for item in "$dir"/*; do
        if [ -d "$item" ]; then
            local basename=$(basename "$item")
            echo "${indent}- [$basename]($basename)"
            generate_index "$item" "  $indent"
        elif [ -f "$item" ] && [ "${item##*.}" = "md" ] && [ "$(basename "$item")" != "index.md" ]; then
            local filename=$(basename "$item")
            local name="${filename%.*}"
            echo "${indent}- [$name]($filename)"
        fi
    done
}

# Function to update index in a file
update_index() {
    local file="$1"
    local dir=$(dirname "$file")
    local temp_file=$(mktemp)

    # Generate new index content
    local index_content=$(generate_index "$dir" "")

    # Check if the file exists and has content
    if [ -s "$file" ]; then
        # File exists and has content, update only the index section
        awk -v start="<!-- START_INDEX -->" -v end="<!-- END_INDEX -->" -v content="$index_content" '
        BEGIN {p=1; found=0}
        $0 ~ start {
            print
            print content
            p=0
            found=1
            next
        }
        $0 ~ end {
            p=1
        }
        p
        END {
            if (!found) {
                print start
                print content
                print end
            }
        }
        ' "$file" > "$temp_file"
    else
        # File doesn't exist or is empty, create new content
        echo "# Index" > "$temp_file"
        echo "" >> "$temp_file"
        echo "<!-- START_INDEX -->" >> "$temp_file"
        echo "$index_content" >> "$temp_file"
        echo "<!-- END_INDEX -->" >> "$temp_file"
    fi

    # Only update if changes were made
    if ! cmp -s "$file" "$temp_file"; then
        mv "$temp_file" "$file"
        echo "Updated index in: $file"
    else
        rm "$temp_file"
        echo "No changes needed in: $file"
    fi
}

# Function to recursively process directories
process_directory() {
    local dir="$1"

    find "$dir" -type f -name "index.md" | while read -r index_file; do
        update_index "$index_file"
    done

    # Create index.md if it doesn't exist
    find "$dir" -type d | while read -r subdir; do
        if [ ! -f "$subdir/index.md" ]; then
            touch "$subdir/index.md"
            update_index "$subdir/index.md"
        fi
    done

    # Remove README.md files
    find "$dir" -type f -name "README.md" -delete
}

# Main execution
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

process_directory $1

echo "Index files have been updated successfully."
