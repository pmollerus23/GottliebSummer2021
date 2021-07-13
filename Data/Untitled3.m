SC = [1 2 3];
plotPerSubject(final.data, SC);

percentAbortBlock(final.data, 1);
cleaned.allDataFree(:,10) = cleaned.allDataFree(:,18)
replace = cleaned.allDataFree(:,10);
cleaned.allDataFree = horzcat(cleaned.allDataFree,replace);
cleaned.allDataFree(:,10) = []; 
SC = [1 4];
plotPerSubject(cleaned.allDataFree, 4);
