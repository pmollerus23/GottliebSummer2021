

%cleaning IR data
cleaned.force.IR.data = horzcat(finalTrialData.force.trialData.allTrialData, finalTrialData.force.results.allTrialsResponseDataMatrix)
indecies = find(cleaned.force.IR.data(:,6)==1);
cleaned.force.IR.data(indecies,:) = [];
cleaned.force.IR.data(60,:) = [];

cleaned.free.IR.data = horzcat(finalTrialData.free.trialData.allTrialData, finalTrialData.free.results.allTrialsResponseDataMatrix)
indecies = find(cleaned.free.IR.data(:,6)==1);
cleaned.free.IR.data(indecies,:) = [];



%cleaning CB data
cleaned.force.CB.data = horzcat(finalTrialData.force.trialData.allTrialData, finalTrialData.force.results.allTrialsResponseDataMatrix);
indecies = find(cleaned.force.CB.data(:,6)==1);
cleaned.force.CB.data(indecies,:) = [];
cleaned.free.CB.data = horzcat(finalTrialData.free.trialData.allTrialData, finalTrialData.free.results.allTrialsResponseDataMatrix);
indecies = find(cleaned.free.CB.data(:,6) == 1);
cleaned.free.CB.data(indecies,:) = [];



%cleaning PM data
cleaned.force.PM.data = horzcat(finalTrialData.force.trialData.allTrialData, finalTrialData.force.results.allTrialsResponseDataMatrix);
indecies = find(cleaned.force.PM.data(:,6)==1);
cleaned.force.PM.data(indecies,:) = [];
cleaned.free.PM.data = horzcat(finalTrialData.free.trialData.allTrialData, finalTrialData.free.results.allTrialsResponseDataMatrix);
indecies = find(cleaned.free.PM.data(:,6)==1);
cleaned.free.PM.data(indecies,:) = [];






 sortPlot2(cleaned.free.PM.data, cleaned.force.PM.data)
 sortPlot2(cleaned.free.CB.data, cleaned.force.CB.data)
 sortPlot2(cleaned.free.IR.data, cleaned.force.IR.data)
 sortPlotINC(cleaned.free.PM.data);
 sortPlotINC(cleaned.free.IR.data);
 sortPlotINC(cleaned.free.CB.data);
 polarPlots(cleaned.free.CB.data);
 polarPlots(cleaned.force.CB.data);
  polarPlots(cleaned.force.PM.data);
   polarPlots(cleaned.force.IR.data);




clean = cleaned;
save('clean')

plotPerSubject(all.cleaned.data, all.cleaned.practiceData, 2);

