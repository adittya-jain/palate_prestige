#!/bin/bash

# Specify the directory containing your project files
project_directory="/mnt/c/Users/jaina/OneDrive/Desktop/minorProject/palate_prestige/lib"

# Specify the output file name
output_file="aggregated_code.txt"

# Create or empty the output file
> $output_file

# Find and concatenate files with specified extensions
find $project_directory -type f \( -name "*.dart" -o -name "*.js" \) | while read file; do
  echo "File: $file" >> $output_file
  cat "$file" >> $output_file
  echo -e "\n\n" >> $output_file
done
