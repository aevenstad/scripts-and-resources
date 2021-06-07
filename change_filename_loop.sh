#!bin/bash
 for file in ./*.txt
do


## make variable with new filename. To remove start of filename use #string, end of filename use %string
NAME="${file#./trans_counts}"

        mv -- "$file" "$NAME"


done
