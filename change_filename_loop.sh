#!bin/bash
# Remove string in the beginning of filename for all .txt files in current directory

for file in *.txt
do


NAME="${file#trans_counts}"

        mv -- "$file" "$NAME"


done
