function [] = sortPlot2(freeArray, forceArray)
% Input RTs, Accuracy, and Speed ratings as vertical freeArrays.
% Accuracy coding: 1 = correct, 0 = error (error by choice, not breaking
%   fixation)
% Speed coding: 2 = speeded, 1 = regular
% nbins = number of bins used in histograms

% check that rt and acc data are same size



nbins = 10;
% organize binning parameters for histograms
rng = [0.3 1.1];
step = 0.05; %range(rng)/nbins;
edges = rng(1):step:rng(2);
binmids = edges(1:end-1)+step/2;

figure;
clf;
fs = 14;






col = size(freeArray, 2);
if col == 14;
    %%%FREE CHOICE SORT
    
    indices = find(freeArray(:,7)==1);
    slowfreeArray = freeArray(indices,:);
    indices = find(freeArray(:,7)==2);
    fastfreeArray = freeArray(indices,:);
    
    %%%%%
    
    indices = find(slowfreeArray(:,9)==1);
    slowEasyfreeArray = slowfreeArray(indices,:);
    
    subplot(2,3,1); hold on;
    rtstoplotIncorrect = [];
    rtstoplotCorrect = [];
    
    for a = 0:1
        
        accs = slowEasyfreeArray(:,12);
        
        rts = slowEasyfreeArray(:,13);
        nt = size(rts,1);
        
        for i = 1:nt
            if accs(i) == 0
                rtstoplotIncorrect(end+1) = rts(i);
                
            elseif accs(i) == 1
                rtstoplotCorrect(end+1) = rts(i);
                
                
            end
           total = nt;
           pc = length(rtstoplotCorrect)/(length(rtstoplotCorrect)+length(rtstoplotIncorrect));
           pc =  round(pc * 100);
        end
        
        h(a+1) = histogram(rtstoplotIncorrect, edges, 'Normalization','count'); h(a+1).FaceColor = 'red';
        hold on
        h(a+1) = histogram(rtstoplotCorrect, edges, 'Normalization','count'); h(a+1).FaceColor = 'green';
      
       
       m = mean(rts);
       line([m m], [min(get(gca, 'YLim')), max(get(gca, 'YLim'))]);
        
    end
    
    xlim(rng);
               titleText = sprintf('Free Regular SS1 PC = %d %', pc);

    xlabel('RT (ms)'); ylabel('p(RT bin)'); title(titleText);
    
        legend('Error','Correct');
       % text(.5,.5,{'first','second'})
    
    
    ax = gca; ax.FontSize = fs;
    ax.LineWidth = 1.5;
    ax.TickLength = [0.02 0.02];
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    indices = find(fastfreeArray(:,9)==1);
    fastEasyfreeArray = fastfreeArray(indices,:)
    
    
    subplot(2,3,4); hold on;
    rtstoplotIncorrect = [];
    rtstoplotCorrect = [];
    
    for a = 0:1
        
        accs = fastEasyfreeArray(:,12);
        
        rts = fastEasyfreeArray(:,13);
        nt = size(rts,1);
        
        for i = 1:nt
            if accs(i) == 0
                rtstoplotIncorrect(end+1) = rts(i);
                
            elseif accs(i) == 1
                rtstoplotCorrect(end+1) = rts(i);
                
                
            end
            
           pc = length(rtstoplotCorrect)/(length(rtstoplotCorrect)+length(rtstoplotIncorrect));
           pc =  round(pc * 100);
        end
        
        h(a+1) = histogram(rtstoplotIncorrect, edges, 'Normalization','count'); h(a+1).FaceColor = 'red';
        hold on
        h(a+1) = histogram(rtstoplotCorrect, edges, 'Normalization','count'); h(a+1).FaceColor = 'green';
        hold on
        m = mean(rts);
       line([m m], [min(get(gca, 'YLim')), max(get(gca, 'YLim'))]);
    end
    
    titleText = sprintf('Free Speeded SS1 PC = %d %', pc);
    
    xlim(rng);
    xlabel('RT (ms)'); ylabel('p(RT bin)'); title(titleText);
    
            legend('Error','Correct');

    ax = gca; ax.FontSize = fs;
    ax.LineWidth = 1.5;
    ax.TickLength = [0.02 0.02];
    
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    indices = find(slowfreeArray(:,9)==2);
    slowHardfreeArray = slowfreeArray(indices,:);
    
    
    subplot(2,3,2); hold on;
    rtstoplotIncorrect = [];
    rtstoplotCorrect = [];
    
    for a = 0:1
        
        accs = slowHardfreeArray(:,12);
        
        rts = slowHardfreeArray(:,13);
        nt = size(rts,1);
        
        for i = 1:nt
            if accs(i) == 0
                rtstoplotIncorrect(end+1) = rts(i);
                
            elseif accs(i) == 1
                rtstoplotCorrect(end+1) = rts(i);
                
                
            end
            
           pc = length(rtstoplotCorrect)/(length(rtstoplotCorrect)+length(rtstoplotIncorrect));
           pc =  round(pc * 100);
        end
        
        h(a+1) = histogram(rtstoplotIncorrect, edges, 'Normalization','count'); h(a+1).FaceColor = 'red';
        hold on
        h(a+1) = histogram(rtstoplotCorrect, edges, 'Normalization','count'); h(a+1).FaceColor = 'green';
         hold on
        m = mean(rts);
       line([m m], [min(get(gca, 'YLim')), max(get(gca, 'YLim'))]);
    end
    
        titleText = sprintf('Free Regular SS8 PC = %d %', pc);

    
    xlim(rng);
    xlabel('RT (ms)'); ylabel('p(RT bin)'); title(titleText);
  
            legend('Error','Correct');

    
    ax = gca; ax.FontSize = fs;
    ax.LineWidth = 1.5;
    ax.TickLength = [0.02 0.02];

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    indices = find(fastfreeArray(:,9)==2);
    fastHardfreeArray = fastfreeArray(indices,:);
    
    
    subplot(2,3,5); hold on;
    rtstoplotIncorrect = [];
    rtstoplotCorrect = [];
    
    for a = 0:1
        
        accs = fastHardfreeArray(:,12);
        
        rts = fastHardfreeArray(:,13);
        nt = size(rts,1);
        
        for i = 1:nt
            if accs(i) == 0
                rtstoplotIncorrect(end+1) = rts(i);
                
            elseif accs(i) == 1
                rtstoplotCorrect(end+1) = rts(i);
                
                
            end
            
            pc = length(rtstoplotCorrect)/(length(rtstoplotCorrect)+length(rtstoplotIncorrect));
           pc =  round(pc * 100);
        end
        
        h(a+1) = histogram(rtstoplotIncorrect, edges, 'Normalization','count'); h(a+1).FaceColor = 'red';
        hold on
        h(a+1) = histogram(rtstoplotCorrect, edges, 'Normalization','count'); h(a+1).FaceColor = 'green';
         hold on
        m = mean(rts);
       line([m m], [min(get(gca, 'YLim')), max(get(gca, 'YLim'))]);
    end
    
            titleText = sprintf('Free Speeded SS8 PC = %d %', pc);

    
    xlim(rng);
    xlabel('RT (ms)'); ylabel('p(RT bin)'); title(titleText);
   
        legend('Error','Correct');
   
    
    ax = gca; ax.FontSize = fs;
    ax.LineWidth = 1.5;
    ax.TickLength = [0.02 0.02];
    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%
  

    %%%FORCE CHOICE SORT
    indices = find(forceArray(:,7)==1);
    slowForceArray = forceArray(indices,:);
    indices = find(forceArray(:,7)==2);
    fastForceArray = forceArray(indices,:);
    
    %%%%%
    
    slowHardForceArray = slowForceArray;
    
    subplot(2,3,3); hold on;
    rtstoplotIncorrect = [];
    rtstoplotCorrect = [];
    
    for a = 0:1
        
        accs = slowHardForceArray(:,12);
        
        rts = slowHardForceArray(:,8);
        nt = size(rts,1);
        
        for i = 1:nt
            if accs(i) == 0
                rtstoplotIncorrect(end+1) = rts(i);
                
            elseif accs(i) == 1
                rtstoplotCorrect(end+1) = rts(i);
                
                
            end
            
          pc = length(rtstoplotCorrect)/(length(rtstoplotCorrect)+length(rtstoplotIncorrect));
           pc =  round(pc * 100);
        end
        
        h(a+1) = histogram(rtstoplotIncorrect, edges, 'Normalization','count'); h(a+1).FaceColor = 'red';
        hold on
        h(a+1) = histogram(rtstoplotCorrect, edges, 'Normalization','count'); h(a+1).FaceColor = 'green';
         hold on
        m = mean(rts);
       line([m m], [min(get(gca, 'YLim')), max(get(gca, 'YLim'))]);
    end
    
                   titleText = sprintf('Force Regular SS8 PC = %d %', pc);

    xlim(rng);
    xlabel('RT (ms)'); ylabel('p(RT bin)'); title(titleText);
   
        legend('Error','Correct');
   
    
    ax = gca; ax.FontSize = fs;
    ax.LineWidth = 1.5;
    ax.TickLength = [0.02 0.02];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fastHardForceArray = fastForceArray;
    
    subplot(2,3,6); hold on;
    rtstoplotIncorrect = [];
    rtstoplotCorrect = [];
    
    for a = 0:1
        
        accs = fastHardForceArray(:,12);
        
        rts = fastHardForceArray(:,8);
        nt = size(rts,1);
        
        for i = 1:nt
            if accs(i) == 0
                rtstoplotIncorrect(end+1) = rts(i);
                
            elseif accs(i) == 1
                rtstoplotCorrect(end+1) = rts(i);
                
                
            end
            
           pc = length(rtstoplotCorrect)/(length(rtstoplotCorrect)+length(rtstoplotIncorrect));
           pc =  round(pc * 100);
        end
        
        h(a+1) = histogram(rtstoplotIncorrect, edges, 'Normalization','count'); h(a+1).FaceColor = 'red';
        hold on
        h(a+1) = histogram(rtstoplotCorrect, edges, 'Normalization','count'); h(a+1).FaceColor = 'green';
         hold on
        m = mean(rts);
       line([m m], [min(get(gca, 'YLim')), max(get(gca, 'YLim'))]);
    end
    
                       titleText = sprintf('Force Speeded SS8 PC = %d %', pc);

    
    xlim(rng);
    xlabel('RT (ms)'); ylabel('p(RT bin)'); title(titleText);
   
        legend('Error','Correct');
   
    
    ax = gca; ax.FontSize = fs;
    ax.LineWidth = 1.5;
    ax.TickLength = [0.02 0.02];
    
else
    Warning('freeArray is not the proper dimensions');
end
end

