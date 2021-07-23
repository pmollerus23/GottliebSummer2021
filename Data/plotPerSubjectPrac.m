function [] = plotPerSubjectPrac(DataMatrix, SubjectCodes)
SC = SubjectCodes;
d = DataMatrix;

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
            pcFRPrac(d,SC(i),0);
            subplot(4,3,6); hold on
            abortPerBlockPrac(d, SC(i));
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
    
    dAbort = find(d(:,8) == 1);
    d(dAbort,:) = [];
    
    block = d(:,17);
    speed = d(:,9);
    accs = d(:,5);
    conf = d(:,12);
    
    slwCrrct = 0;
    spCrrct = 0;
    for i = 1:length(d)
        if speed(i) == 1 && accs(i) == 1
            slwCrrct = slwCrrct + 1;
        elseif speed(i) == 2 && accs(i) == 1
            spCrrct = spCrrct + 1;
        end
    end
    
    slowTotal = length(find(speed == 1));
    fastTotal = length(find(speed == 2));
    
    slwPct = (slwCrrct / slowTotal) * 100;
    spPct = (spCrrct / fastTotal) * 100;
    slwRate = conf(length(find(speed == 1)));
    spRate = conf(length(find(speed == 2)));
    
    STRslwPctEst = num2str(slwRate);
    STRslwPctAct = num2str(slwPct);
    
    STRspPctEst = num2str(spRate);
    STRspPctAct = num2str(spPct); 
    
    titleHead = 'Participant';
    SCstr = num2str(SC(i));
    titleStr = strcat(titleHead, {' '}, SCstr, {' '}, {'(Regular/Speeded = Blue/Red, No Feedback/Feedback = O/X)'}, {' '}, 'slw % est: ', STRslwPctEst,{' '}, 'slw % act: ', STRslwPctAct, 'sp % est: ', {' '}, STRspPctEst, {' '}, 'sp % act: ', STRspPctAct);
    suptitle(titleStr);
    
    
               %  polarPlotsRT(d, SC(i));
                    %          polarPlotsPC(d, SC(i));


end
end