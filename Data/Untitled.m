
 
cleaned.free.PM.dataDescription = {'Column 1 represents the trial number(1-72 + aborted trials)'; 'Column 2 represents the position of T in the circle (0 is farthest right and increases traveling counterclock wise around the circle)';...
        'Column 3 represents the orientation of T (1 = upright T, 0 = upsidedown)'; ' Column 4 where the incentive is drawm (1 = drawn on right, 2 = drawn on left)';'Column 5 represents the incentive value shown 1-6 where an incentive value of 1 will be handled as a 2';'Column 6 is where aborted trials are represented (1= aborted, 0 = completed)';'Coloum 7 represents weather or not a trial was speeded or slowed (1 = slow, 2 = fast)';'Column 8 represents the response time for choosing incentive'; 'Column 9 represents the reward choice(difficult = 2, easy = 1)'; 'Columnn 10 represents self assessed fatigue on a scale of 1 to 10';...
        'Column 11 represents key presses to decide the orientation of t( 1 = up, 0 = down)'; 'Columnn 12 represents weather or not a trial was correct (1 = correct, 0 = incorrect)';...
       'Column 13 represents the time it took for a person to decide the orientation of T'; 'Column 14 represents the aborted trials (1 = aborted, 0 = succesful)'};
   
   cleaned.free.PM.data = horzcat(finalTrialData.free.trialData.allTrialData, finalTrialData.free.results.allTrialsResponseDataMatrix);
   
   indices = find(cleaned.free.PM.data(:,14)==1);
    cleaned.free.PM.data(indices,:) = [];

    cleaned.force.PM.data = horzcat(finalTrialData.force.trialData.allTrialData, finalTrialData.force.results.allTrialsResponseDataMatrix);
    
    cleaned.force.PM.dataDescription = {'Column 1 represents the trial number(1-12 + aborted trials)'; 'Column 2 represents the position of T in the circle (0 is farthest right and increases traveling counterclock wise around the circle)';...
            'Column 3 represents the orientation of T (1 = upright T, 0 = upsidedown)';' Column 4 where the incentive is drawm (1 = drawn on right, 2 = drawn on left)';'Column 5 represents the incentive value shown 1-6 where an incentive value of 1 will be handled as a 2';'Column 6 is where aborted trials are represented (1= aborted, 0 = completed)';'Coloum 7 represents weather or not a trial was speeded or slowed (1 = slow, 2 = fast)';...
            'Column 8 represents the time it took for a person to decide the orientation of T';'Column 9 represents the aborted trials (1 = aborted, 0 = succesful)';...
            'Columnn 10 represents self assessed fatigue on a scale of 1 to 10';'Column 11 represents key presses to decide the orientation of t( 1 = up, 0 = down)';'Columnn 12 represents weather or not a trial was correct (1 = correct, 0 = incorrect)'};
            
     indices = find(cleaned.force.PM.data(:,9)==1);
    cleaned.force.PM.data(indices,:) = [];

    rtplots(cleaned.force.PM.data(:,8), cleaned.force.PM.data(:,12), cleaned.force.PM.data(:,7), 10);
    
    rtplots(cleaned.free.PM.data(:,13), cleaned.free.PM.data(:,12), cleaned.free.PM.data(:,7), 10);
    hist(cleaned.free.PM.data(:,13));
    
    
    cleaned.free.IR.data = horzcat(finalTrialData.free.trialData.allTrialData, finalTrialData.free.results.allTrialsResponseDataMatrix);
    indices = find(cleaned.free.IR.data(:,14)==1);
    cleaned.free.IR.data(indices,:) = [];
    cleaned.free.IR.dataDescription = {'Column 1 represents the trial number(1-72 + aborted trials)'; 'Column 2 represents the position of T in the circle (0 is farthest right and increases traveling counterclock wise around the circle)';...
        'Column 3 represents the orientation of T (1 = upright T, 0 = upsidedown)'; ' Column 4 where the incentive is drawm (1 = drawn on right, 2 = drawn on left)';'Column 5 represents the incentive value shown 1-6 where an incentive value of 1 will be handled as a 2';'Column 6 is where aborted trials are represented (1= aborted, 0 = completed)';'Coloum 7 represents weather or not a trial was speeded or slowed (1 = slow, 2 = fast)';'Column 8 represents the response time for choosing incentive'; 'Column 9 represents the reward choice(difficult = 2, easy = 1)'; 'Columnn 10 represents self assessed fatigue on a scale of 1 to 10';...
        'Column 11 represents key presses to decide the orientation of t( 1 = up, 0 = down)'; 'Columnn 12 represents weather or not a trial was correct (1 = correct, 0 = incorrect)';...
       'Column 13 represents the time it took for a person to decide the orientation of T'; 'Column 14 represents the aborted trials (1 = aborted, 0 = succesful)'};
    
     rtplots(cleaned.force.IR.data(:,8), cleaned.force.IR.data(:,12), cleaned.force.IR.data(:,7), 10);
    
    rtplots(cleaned.free.IR.data(:,13), cleaned.free.IR.data(:,12), cleaned.free.IR.data(:,7), 10);
    
    cleaned.PM.free = horzcat(cleaned.free.PM.data);
    cleaned.PM.force = horzcat(cleaned.force.PM.data);
    
    cleaned.PM.force.dataDescription = {'Column 1 represents the trial number(1-12 + aborted trials)'; 'Column 2 represents the position of T in the circle (0 is farthest right and increases traveling counterclock wise around the circle)';...
            'Column 3 represents the orientation of T (1 = upright T, 0 = upsidedown)';' Column 4 where the incentive is drawm (1 = drawn on right, 2 = drawn on left)';'Column 5 represents the incentive value shown 1-6 where an incentive value of 1 will be handled as a 2';'Column 6 is where aborted trials are represented (1= aborted, 0 = completed)';'Coloum 7 represents weather or not a trial was speeded or slowed (1 = slow, 2 = fast)';...
            'Column 8 represents the time it took for a person to decide the orientation of T';'Column 9 represents the aborted trials (1 = aborted, 0 = succesful)';...
            'Columnn 10 represents self assessed fatigue on a scale of 1 to 10';'Column 11 represents key presses to decide the orientation of t( 1 = up, 0 = down)';'Columnn 12 represents weather or not a trial was correct (1 = correct, 0 = incorrect)'};
        
        
    cleaned.PM.free.dataDescription = {'Column 1 represents the trial number(1-72 + aborted trials)'; 'Column 2 represents the position of T in the circle (0 is farthest right and increases traveling counterclock wise around the circle)';...
        'Column 3 represents the orientation of T (1 = upright T, 0 = upsidedown)'; ' Column 4 where the incentive is drawm (1 = drawn on right, 2 = drawn on left)';'Column 5 represents the incentive value shown 1-6 where an incentive value of 1 will be handled as a 2';'Column 6 is where aborted trials are represented (1= aborted, 0 = completed)';'Coloum 7 represents weather or not a trial was speeded or slowed (1 = slow, 2 = fast)';'Column 8 represents the response time for choosing incentive'; 'Column 9 represents the reward choice(difficult = 2, easy = 1)'; 'Columnn 10 represents self assessed fatigue on a scale of 1 to 10';...
        'Column 11 represents key presses to decide the orientation of t( 1 = up, 0 = down)'; 'Columnn 12 represents weather or not a trial was correct (1 = correct, 0 = incorrect)';...
       'Column 13 represents the time it took for a person to decide the orientation of T'; 'Column 14 represents the aborted trials (1 = aborted, 0 = succesful)'};
   
   cleaned.PM.freeSlow.data = horzcat(cleaned.free.PM.data);
   cleaned.PM.forceSlow.data = horzcat(cleaned.force.PM.data);
   
   indices = find(cleaned.PM.freeSlow.data(:,7)==2);
    cleaned.PM.freeSlow.data(indices,:) = [];
   
    indices = find(cleaned.PM.forceSlow.data(:,7)==2);
    cleaned.PM.forceSlow.data(indices,:) = [];
    
    cleaned.PM.freeFast.data = horzcat(cleaned.free.PM.data);
   cleaned.PM.forceFast.data = horzcat(cleaned.force.PM.data);
   
   indices = find(cleaned.PM.freeFast.data(:,7)==1);
    cleaned.PM.freeFast.data(indices,:) = [];
    
       indices = find(cleaned.PM.forceFast.data(:,7)==1);
    cleaned.PM.forceFast.data(indices,:) = [];
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    cleaned.PM.freeSlow.freeSlowSS1.data = horzcat(cleaned.PM.freeSlow.data);
    
      cleaned.PM.freeSlow.freeSlowSS8.data = horzcat(cleaned.PM.freeSlow.data);
      
      
      indices = find(cleaned.PM.freeSlow.freeSlowSS1.data(:,9)==2);
    cleaned.PM.freeSlow.freeSlowSS1.data(indices,:) = [];
    
    indices = find(cleaned.PM.freeSlow.freeSlowSS8.data(:,9)==1);
    cleaned.PM.freeSlow.freeSlowSS8.data(indices,:) = [];
      
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      
      cleaned.PM.freeFast.freeFastSS1.data = horzcat(cleaned.PM.freeFast.data);
      
cleaned.PM.freeFast.freeFastSS8.data = horzcat(cleaned.PM.freeFast.data);

      indices = find(isnan(cleaned.PM.freeFast.freeFastSS1.data(:,9)));
    cleaned.PM.freeFast.freeFastSS1.data(indices,:) = [];
    
    indices = find(isnan(cleaned.PM.freeFast.freeFastSS8.data(:,9)));
    cleaned.PM.freeFast.freeFastSS8.data(indices,:) = [];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


cleaned.PM.forceSlow.forceSlowSS8.data = horzcat(cleaned.PM.forceSlow.data);

cleaned.PM.forceFast.forceFastSS8.data = horzcat(cleaned.PM.forceFast.data);

 indices = find(cleaned.PM.forceSlow.forceSlowSS8.data(:,10)==0);
    cleaned.PM.forceSlow.forceSlowSS8.data(indices,:) = [];
    
     indices = find(data(:,10)==0);
    data(indices,:) = [];
    
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        
        
        reactionPlot(cleaned.PM.free(:,13), cleaned.PM.free(:,12), cleaned.PM.free(:,7), cleaned.PM.free(:,9), 10);


 sortPlot(cleaned.free.PM.data, cleaned.force.PM.data)
        
 Untitled2(cleaned.free.PM.data);
   
 get(gca)
 
 RTincPlot(final.data, 2, 1);
 RTincPlot(final.data, 3, 1);
 

   