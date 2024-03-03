#!/bin/bash

# Check the number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory_path> <file_format>"
    exit 1
fi

# Extract arguments
directory_path=$1
file_format=$2

# Check if the directory exists
if [ ! -d "$directory_path" ]; then
    echo "Error: Directory not found."
    exit 1
fi

# Change to the specified directory
cd "$directory_path" || exit 1

# List files with the specified format
files=(*."$file_format")

# Check if there are any files with the specified format
if [ ${#files[@]} -eq 0 ]; then
    echo "No files found with the specified format."
    exit 0
fi

# Replace character 'a' with a random character in each file name
for file in "${files[@]}"; do
    new_name=$(echo "$file" | sed "s/a/$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c1)/")
    mv "$file" "$new_name"
    echo "Renamed: $file to $new_name"
done

echo "Operation completed successfully."



# run it by "sh changer.sh <directory_path> <file_format>"
# e.g "sh changer.sh ./ .txt"