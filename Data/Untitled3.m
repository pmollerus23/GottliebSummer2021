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
polarPlotsRT(cleaned.allDataFree, 4)
polarPlotsPC(cleaned.allDataFree, 4)
plotPerSubject(cleaned.allDataFree, 4);
