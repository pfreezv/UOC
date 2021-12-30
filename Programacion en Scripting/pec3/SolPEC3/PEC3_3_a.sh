sed "{
s/\(.*,\)\(F\)\(.*\)/\1Female\3/
s/\(.*,\)\(M\)\(.*\)/\1Male\3/
/\(.*,\)[^F-M],.*/d
}" demographic_info.csv
