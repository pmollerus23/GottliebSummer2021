function fig = Untitled2(rts, accs, setSize, speed, nbins)

if size(rts,1) ~= size(accs,1) || size(rts,1) ~= size(setSize,1)
    warning('Input arrays are not same length');
end

nt = size(rts,1);

rng = [min(rts) max(rts)];
step = range(rng)/nbins;
edges = rng(1):step:rng(2);
binmids = edges(1:end-1)+step/2;

figure;
fs = 14;
       



if speed(1) == 1 && setSize(1) ==1
    titletext = 'Regular SS of 1 RT Distributions';
   % subplot(2,3,l);
%     hold on;
   
elseif speed(1) == 1 && setSize(1) ==2
    titletext = 'Regular SS of 8 RT Distributions';
  %  subplot(2,3,l);
%     hold on;
   
elseif speed(1) == 2 && setSize(1) ==1
    titletext = 'speeded SS of 1 RT Distributions';
   % subplot(2,3,l);
%     hold on;
elseif speed(1) == 2 && setSize(1) ==2
    titletext = 'speeded SS of 8 RT Distributions';
  %  subplot(2,3,l);
%     hold on;
end
         


       
       
       rtstoplotIncorrect = [];
       rtstoplotCorrect = [];
       
        for a = 0:1
           
           
           
            for i = 1:nt
                if accs(i) == 0
                    rtstoplotIncorrect(end+1) = rts(i);
                   
                elseif accs(i) == 1
                    rtstoplotCorrect(end+1) = rts(i);
                   
                   
                end
            end
           
            h(a+1) = histogram(rtstoplotIncorrect, edges, 'Normalization','probability'); h(a+1).FaceColor = 'red';
            hold on
            h(a+1) = histogram(rtstoplotCorrect, edges, 'Normalization','probability'); h(a+1).FaceColor = 'green';
           
        end
        fig = h;
       
        xlim(rng);
        xlabel('RT (ms)'); ylabel('p(RT bin)'); title(titletext);
       

            pcS = length(rtstoplotCorrect)/nt;
            a = num2str(pcS);

            legend('Error','Correct');
     
       
        ax = gca; ax.FontSize = fs;
        ax.LineWidth = 1.5;
        ax.TickLength = [0.02 0.02];

