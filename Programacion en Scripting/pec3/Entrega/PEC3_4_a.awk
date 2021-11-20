BEGIN {FS=","} /,finnish,.*swedish/ {fin=fin+1} 
END {printf "%.2f", (fin/$1)*100}

