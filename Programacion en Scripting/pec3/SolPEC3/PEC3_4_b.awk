BEGIN {
        FS=",";
        totSpanishAge = 0;
        spanishCounter = 0;
}
{
	if ($4 ~ /spanish/) {
		totSpanishAge += $3;
		spanishCounter += 1;
	} else if ($5 ~ /spanish/) {
		totSpanishAge += $3;
		spanishCounter += 1;
    }
}
END {
	printf("%.2f", (totSpanishAge  / spanishCounter));
	print "";
}
