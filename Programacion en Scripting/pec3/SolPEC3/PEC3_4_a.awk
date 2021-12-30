BEGIN {
        FS=",";
        totFinish = 0;
        totFinishSpeakingSwedish = 0;
}
{
        if ($4 ~ /finnish/) {
                totFinish += 1;
                        if ($5 ~ /swedish/) {
                                totFinishSpeakingSwedish += 1;
                        }
        }
}
END {
        printf("%.2f %", (totFinishSpeakingSwedish  / totFinish) * 100);
        print "";
}
