BEGIN {FS=","} /spanish/ {age+=$3; spanish=spanish+1} 
END  {printf "%.2f\n",age/spanish}
