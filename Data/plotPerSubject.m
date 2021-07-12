function [] = plotPerSubject(DataMatrix, SubjectCodes)
SC = SubjectCodes;
d = DataMatrix;

for i = 1:length(SC)
    figure;
    for j = 1:2
        if j == 1
            subplot(3,3,1); 
            title('Free')
            hold on
            RTincPlot(d, SC(i), j)
            subplot(3,3,4); hold on
            pcPlots(d,SC(i),j);
            subplot(3,3,7); hold on
            abtPlots(d,SC(i),j);
        elseif j ==2
            subplot(3,3,2); 
            title('Force')
            hold on 
            RTincPlot(d, SC(i),j)
            subplot(3,3,5); hold on
            pcPlots(d,SC(i),j);
            subplot(3,3,8); hold on
            abtPlots(d,SC(i),j);
   
        end
            subplot(3,3,3); hold on
            rcPlots(d,SC(i),0);
            subplot(3,3,6); hold on 
            pcFR(d,SC(i),0);
            subplot(3,3,9); hold on
            abortPerBlock(d, SC(i));
    end
    
    titleHead = 'Participant';
    SCstr = num2str(SC(i));
    titleStr = strcat(titleHead, {' '}, SCstr);
    suptitle(titleStr);
end
end