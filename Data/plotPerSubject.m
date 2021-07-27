function [] = plotPerSubject(DataMatrix, practiceData, SubjectCodes)
SC = SubjectCodes;
d = DataMatrix;
dp = practiceData;

for i = 1:length(SC)
    figure;
    for j = 1:2
        if j == 1
            subplot(4,3,1); 
            title('No Feedback')
            hold on
            RTincPlot(d, SC(i), j)
            subplot(4,3,4); hold on
            pcPlots(d,SC(i),j);
            subplot(4,3,7); hold on
            abtPlots(d,SC(i),j);
        elseif j ==2
            subplot(4,3,2); 
            title('Feedback')
            hold on 
            RTincPlot(d, SC(i),j)
            subplot(4,3,5); hold on
            pcPlots(d,SC(i),j);
            subplot(4,3,8); hold on
            abtPlots(d,SC(i),j);
   
        end
            subplot(4,3,10); hold on
            rcPlots(d,SC(i),0);
            subplot(4,3,11); hold on
            rcfbPlots(d,SC(i),0);
            subplot(4,3,3); hold on 
            pcFR(d,SC(i),0);
            subplot(4,3,6); hold on
            abortPerBlock(d, SC(i));
             subplot(4,3,9); hold on
             y = 0;
                line([-1,1],[y,y], 'color','black')
                line([y,y],[-1,1], 'color','black')
                line([-1,1],[1,-1],'color','black')
                line([1,-1],[1,-1],'color','black')



             %plot(x,y,'k-'); hold on
             polarPlotsRT(d, SC(i));
            subplot(4,3,12); hold on
             y = 0;
                line([-1,1],[y,y], 'color','black')
                line([y,y],[-1,1], 'color','black')
                line([-1,1],[1,-1],'color','black')
                line([1,-1],[1,-1],'color','black')

           
             polarPlotsPC(d, SC(i));

    end
    block = d(:,17);
    speed = d(:,9);
    accs = d(:,5);
    conf = d(:,12);
    

     


end
dAbort = find(dp(:,8) == 1);
    dp(dAbort,:) = [];
    part = dp(:,2);
    block = dp(:,17);
    speed = dp(:,9);
    accs = dp(:,14);
    conf = dp(:,12);
    
    slwCrrct = 0;
    spCrrct = 0;
    for i = 1:length(conf)

    slwCrrct = 0;
    spCrrct = 0;
    for i = 1:length(dp) 

        if speed(i) == 1 && accs(i) == 1
            slwCrrct = slwCrrct + 1;
        elseif speed(i) == 2 && accs(i) == 1
            spCrrct = spCrrct + 1;
        end
    end

   correctReg = find(part == SC & accs == 1 & speed == 1);
   correctTotalReg = find(part == SC & speed == 1);
   pcReg = ((length(correctReg)/length(correctTotalReg)) * 100);
   
   correctSP = find(part == SC & accs == 1 & speed == 2);
   correctTotalSP = find(part == SC & speed == 2);
   pcSP = (length(correctSP)/length(correctTotalSP)) * 100;
   

    slwRate = conf(find(part == SC & speed == 1 & conf > 0)) * 10;
    spRate = conf(find(part == SC & speed == 2 & conf > 0)) * 10;
    
    STRslwPctEst = num2str(slwRate);
    STRslwPctAct = num2str(pcReg);
    
    STRspPctEst = num2str(spRate);
    STRspPctAct = num2str(pcSP); 
    
    titleHead = 'Participant';
    SCstr = num2str(SC);
    titleStr = strcat(titleHead, {' '}, SCstr, {' '}, {'(Regular/Speeded = Blue/Red, No Feedback/Feedback = O/X)'}, {' '}, 'slw % est: ', STRslwPctEst,{' '}, 'slw % act: ', STRslwPctAct, 'sp % est: ', {' '}, STRspPctEst, {' '}, 'sp % act: ', STRspPctAct);
    suptitle(titleStr);
    
    

    
    slowTotal = length(find(speed == 1));
    fastTotal = length(find(speed == 2));
    
    slwPct = (slwCrrct / slowTotal) * 100;
    spPct = (spCrrct / fastTotal) * 100;
    slwRate = conf(length(find(speed == 1)));
    spRate = conf(length(find(speed == 2)));
    
    STRslwPctEst = num2str(slwRate*10);
    STRslwPctAct = num2str(slwPct);
    
    STRspPctEst = num2str(spRate*10);
    STRspPctAct = num2str(spPct); 
    
    titleHead = 'Participant';
    SCstr = num2str(SC);
    titleStr = strcat(titleHead, {' '}, SCstr, {' '}, {'(Regular/Speeded = Blue/Red, No Feedback/Feedback = O/X)'}, {' '}, 'slw % est: ', STRslwPctEst,{' '}, 'slw % act: ', STRslwPctAct, 'sp % est: ', {' '}, STRspPctEst, {' '}, 'sp % act: ', STRspPctAct);
    suptitle(titleStr);
    

               %  polarPlotsRT(d, SC(i));
                    %          polarPlotsPC(d, SC(i));

end