#!/usr/bin/env sh

set -e  # Exit immediately if a command exits with a non-zero status.

convert_links() {
    docs_dir="./docs"

    find "$docs_dir" -type f -name "*.md" | while read -r file; do
        tmp_file=$(mktemp)

        sed -E '
            s|(/src/std/)([^)]+)\.md(#[^)]*)?|/plugin-functions/std/\2\3|g
            s|(/src/std/)|/plugin-functions/std/|g
            s|(/src/devkit/)([^)]+)\.md(#[^)]*)?|/resources/devkit/api-reference/\2\3|g
            s|(/src/devkit/)|/resources/devkit/api-reference/|g
        ' "$file" > "$tmp_file"

        if ! cmp -s "$file" "$tmp_file"; then
            mv "$tmp_file" "$file"
            echo "Updated: $file"
        else
            rm "$tmp_file"
            echo "No changes: $file"
        fi
    done

    echo "Link conversion completed."
}

# Use the function if this script is run directly
if [ "$(basename "$0")" = "convert_links.sh" ]; then
    convert_links
fi
