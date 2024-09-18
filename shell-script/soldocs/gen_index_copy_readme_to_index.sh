#!/usr/bin/env sh

set -e  # Exit immediately if a command exits with a non-zero status.

gen_index_copy_readme_to_index() {
    basepath=$1
    readme_file=$2
    index_file="${basepath}index.md"

    # Define markers
    start_marker="<!-- START_INDEX -->"
    end_marker="<!-- END_INDEX -->"

    # Update or create index.md
    if [ -f "$index_file" ]; then
        # File exists, update the index section
        awk -v start="$start_marker" -v end="$end_marker" -v readme="$readme_file" '
        BEGIN {in_index=0; printed=0}
        $0 ~ start {in_index=1; print; while((getline line < readme) > 0) {print line}; printed=1; next}
        $0 ~ end {in_index=0; print; next}
        !in_index {print}
        END {if (!printed) {print ""; print start; while((getline line < readme) > 0) {print line}; print ""; print end}}
        ' "$index_file" > "${index_file}.tmp" && mv "${index_file}.tmp" "$index_file"
    else
        # File doesn't exist, create new content
        {
            echo "# Index"
            echo ""
            echo "$start_marker"
            cat "$readme_file"
            echo ""
            echo "$end_marker"
        } > "$index_file"
    fi

    # Replace index.md with the updated content
    echo "Copied processed content to $index_file"
}

# Use the function if this script is run directly
if [ "$(basename "$0")" = "gen_index_copy_readme_to_index.sh" ]; then
    gen_index_copy_readme_to_index "$1" "$2"
fi
