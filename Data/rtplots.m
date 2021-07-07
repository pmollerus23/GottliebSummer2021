function [] = rtplots(rts, accs, speed, nbins)
% Input RTs, Accuracy, and Speed ratings as vertical arrays.
% Accuracy coding: 1 = correct, 0 = error (error by choice, not breaking
%   fixation)
% Speed coding: 2 = speeded, 1 = regular
% nbins = number of bins used in histograms

% check that rt and acc data are same size
if size(rts,1) ~= size(accs,1) || size(rts,1) ~= size(speed,1)
    warning('Input arrays are not same length');
end

nt = size(rts,1);

% organize binning parameters for histograms
rng = [0.3 1.1];
step = range(rng)/nbins;
edges = rng(1):step:rng(2);
binmids = edges(1:end-1)+step/2;

figure;
fs = 14;
for s = 1:2
    switch s
        case 1; titletext = 'Regular RT Distributions';
        case 2; titletext = 'Speeded RT Distributions';
    end
    subplot(3,1,s); hold on;
    
    for a = 0:1
        
        rtstoplot = [];
        for i = 1:nt
            if accs(i) == a && speed(i) == s
                rtstoplot(end+1) = rts(i);
            end
        end
            switch a
                case 0; h(a+1) = histogram(rtstoplot, edges, 'Normalization','probability'); h(a+1).FaceColor = 'red';
                case 1;h(a+1) = histogram(rtstoplot, edges, 'Normalization','probability'); h(a+1).FaceColor = 'green';
            end
    end
    
    xlim(rng);
    xlabel('RT (ms)'); ylabel('p(RT bin)'); title(titletext);
    if s == 1
        legend('Error','Correct');
    end
    
    ax = gca; ax.FontSize = fs;
    ax.LineWidth = 1.5;
    ax.TickLength = [0.02 0.02];
end

subplot(3,1,3)
binaccs = zeros(nbins,2);
for b = 1:nbins-1
    for s = 1:2
        tempaccs = [];
        for i = 1:nt
            if speed(i) == s
                if rts(i) >= edges(b) && rts(i) < edges(b+1)
                    tempaccs(end+1) = accs(i);
                end
            end
        end
        binaccs(b,s) = mean(tempaccs);
    end
end

plot(binmids,binaccs(:,1),'-o','LineWidth',2);
hold on;
plot(binmids,binaccs(:,2),'-o','LineWidth',2);

xlabel('RT bin');
ylabel('% Correct');
legend('Regular','Speeded');

ax = gca; ax.FontSize = fs;
ax.LineWidth = 1.5;
ax.TickLength = [0.02 0.02];
box off;

set(gcf, 'Position',  [100, 200, 600, 800])
end

