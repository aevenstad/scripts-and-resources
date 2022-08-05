Useful commands for unix


## Misc.
 
`less -S somefile`   # do not wrap lines
 
`column -t -s '  '` somefile | less  # view as tab delimited table 
 
`wc -m` # count characters in string
 
`dirname $VARIABLE` # outputs path to file(can be useful for bash variables where $file is in different directories: DIR=(dirname $file))
`basename $VARIABLE`


## awk
`awk -F: '$3>1000 inputfile` # extract specific values from file

awk '/^>/ {$3 = $3 -($4-1)}1' FS='_' OFS='_' c_eur_iso.fa | awk '/^>/ {$3=sprintf("%05d", $3)}1' FS='_' OFS='_' `

`awk '{$(NF+1)="666"}1'` # Insert new column witouth header, every row assigned the same value 666

`awk 'NR==1{$(NF+1)="column name"} NR>1{$(NF+1)="666"}1'` # Insert new column with name, every row assigned the same value 666

`awk '{t[$1]?t[$1]=t[$1]","$2:t[$1]=$2}END{for (i in t){print i,t[i]}}' infile`

turns
in_file:
id1 1
id1 2
id2 1
id2 2
to
out_file:
id1 1,2
id2 1,2

`awk '{$4=$4"_"++a[$4]}1' file` # add string and number (starting from 1) to duplicated "cells" in column $4: turns gene1 into gene1_1 & gene_1_2 etc.



## Find ##
`find /dir_to_search/*pattern* -type f ! -size 0` # Find non empty files matching pattern in directory

## sed
`sed 's/\.[0-9]//g'` # Remove isoform information from gene identifier (Cc047653.1 -> Cc047653)

`sed -i s/^/string/ file` # add string to start of every line in file

`sed -i s/$/string/ file` # add string to end of every line in file

`sed '/*pattern*/s/old_string/new_string/g'` # replace string/character only on lines that match a pattern

`sed 's/\.[^.]*$//g' file` # Remove characters after last dot

## grep

`grep '\<string\>' file` # extract lines matching exact string
 
`grep -E 'pattern[[:alnum:]]' file.txt` # extract lines mathcing pattern with different alphanumeric character as last character
 
`grep -wFf file1 file2`  # grep with file and only print lines with the exact match (useful for transcript/gene ids to only extract the specific ids and not strings that contain the pattern)
 
`grep 'pattern[ABC]' file1` # grep lines that matches the string patternA, patternB and patternC
 
`grep -oh "\w*th\w*" file` # find and print any word containing the string 'th', can remove the first '\w*' to only print words starting with 'th'


## FASTA

\# Convert multiline fasta to single line
`awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n }' sample1.fa > sample1_singleline.fa`

\# Get the length of a fasta sequence (must be single line)
`cat sample1_singleline.fa | awk 'NR%2==0' | awk '{print length($1)}'`

\# Format back to multiline FASTA. Header needs to be shorter than 60 characters (or increase fold value)
`tr "\t" "\n" < linearized.fa | fold -w 60 > multiline.fasta` 

\# Calculate sequence lengths using bioawk
`bioawk -c fastx '{print $name, length($seq)}' input.fast `

\# subset fasta by length (all seqs shorter than 300nt in new file)
`bioawk -c fastx '{ if(length($seq) < 300) { print ">"$name; print $seq }}' in.fasta > out.fasta` 


### PERL

`export PERL5LIB=/path/to/lib # add directory with perl module to @INC




