SC = [1 2 3];
plotPerSubject(final.data, SC);

percentAbortBlock(final.data, 1);

replace = cleaned.allDataFree (:,10);
cleaned.allDataFree   = horzcat(cleaned.allDataFree , replace)
cleaned.allDataFree (:,10) = [];
cleaned.allDataFree= cleaned.allData;
NewDATAMATRIX = cleaned.allDataFree;



SC = [1 2 3];
plotPerSubject(final.data, SC);
pcFR(cleaned.allDataFree, 4, 0);
polarPlotsRT(cleaned.allDataFree, 9)
polarPlotsPC(cleaned.allDataFree, 9)
plotPerSubjectPrac(cleaned.practiceData, 9);
plotPerSubject(all.cleaned.data, 3);
indecies = find(cleaned.practiceData(:,7) == 1 |cleaned.practiceData(:,7) == 2 |cleaned.practiceData(:,7) == 3 );
cleaned.practiceData(indecies,7) = 1;
indecies = find(cleaned.practiceData(:,7) == 4 |cleaned.practiceData(:,7) == 5 |cleaned.practiceData(:,7) == 6 );
cleaned.practiceData(indecies,7) = 6;
