#!/usr/bin/env bash

set -e 

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <archive-file>"
    exit 1
fi

archive_file="$1"

if [ ! -f "$archive_file" ]; then
    echo "Error: File '$archive_file' not found."
    exit 1
fi

filename=$(basename -- "$archive_file")
extension="${filename##*.}"
basename="${filename%.*}"

while [[ "$basename" =~ \.(tar|gz|bz2|xz|zip|7z|rar)$ ]]; do
    extension="${basename##*.}.$extension"
    basename="${basename%.*}"
done

target_dir="$basename"
i=1
while [ -d "$target_dir" ]; do
    target_dir="${basename}_$i"
    ((i++))
done

echo "Extracting '$archive_file' into directory '$target_dir'"

mkdir "$target_dir"
cp "$archive_file" "$target_dir"
cd "$target_dir"

case "$archive_file" in
    *.tar.bz2|*.tbz2) tar xvjf "$archive_file"   ;;
    *.tar.gz|*.tgz)   tar xvzf "$archive_file"   ;;
    *.tar.xz)         tar xvJf "$archive_file"   ;;
    *.tar)            tar xvf  "$archive_file"   ;;
    *.zip)            unzip "$archive_file"      ;;
    *.rar)            unrar x "$archive_file"    ;;
    *.7z)             7z x "$archive_file"       ;;
    *.gz)             gunzip "$archive_file"     ;;
    *.bz2)            bunzip2 "$archive_file"    ;;
    *.xz)             unxz "$archive_file"       ;;
    *)
        echo "Error: Cannot extract '$archive_file' - unrecognized archive type"
        exit 1
        ;;
esac

cd ..
echo "Extraction complete."

