function [] = sortPlotINC(freeArray)
% Input RTs, Accuracy, and Speed ratings as vertical freeArrays.
% Accuracy coding: 1 = correct, 0 = error (error by choice, not breaking
%   fixation)
% Speed coding: 2 = speeded, 1 = regular
% nbins = number of bins used in histograms

% check that rt and acc data are same size

x = [1 2 3 4 5 6]


indecies = find(freeArray(:,7) == 2);
freeFastMatrix = freeArray(indecies,:);
indecies = find(freeArray(:,7) == 1);
freeSlowMatrix = freeArray(indecies,:);


indecies = find(freeFastMatrix(:,5) == 1)
Flen1 = length(indecies);
indecies = find(freeFastMatrix(:,9) == 2& freeFastMatrix(:,5) == 1);
F1actual = length(indecies);
fast(1) = F1actual/Flen1;

indecies = find(freeFastMatrix(:,5) == 2)
Flen2 = length(indecies);
indecies = find(freeFastMatrix(:,9) == 2&  freeFastMatrix(:,5) == 2);
F2actual = length(indecies);
fast(2) = F2actual/Flen2;


indecies = find(freeFastMatrix(:,5) == 3)
Flen3 = length(indecies);
indecies = find(freeFastMatrix(:,9) == 2&  freeFastMatrix(:,5) == 3);
F3actual = length(indecies);
fast(3) = F3actual/Flen3;


indecies = find(freeFastMatrix(:,5) == 4)
Flen4 = length(indecies);
indecies = find(freeFastMatrix(:,9) == 2&  freeFastMatrix(:,5) == 4);
F4actual = length(indecies);
fast(4) = F4actual/Flen4;


indecies = find(freeFastMatrix(:,5) == 5)
Flen5 = length(indecies);
indecies = find(freeFastMatrix(:,9) == 2& freeFastMatrix(:,5) == 5);
F5actual = length(indecies);
fast(5) = F5actual/Flen5;

indecies = find(freeFastMatrix(:,5) == 6)
Flen6 = length(indecies);
indecies = find(freeFastMatrix(:,9) == 2& freeFastMatrix(:,5) == 6);
F6actual = length(indecies);
fast(6) = F6actual/Flen6;


figure







indecies = find(freeSlowMatrix(:,5) == 1)
Flen1 = length(indecies);
indecies = find(freeSlowMatrix(:,9) == 2& freeSlowMatrix(:,5) == 1);
F1actual = length(indecies);
slow(1) = F1actual/Flen1;

indecies = find(freeSlowMatrix(:,5) == 2)
Flen2 = length(indecies);
indecies = find(freeSlowMatrix(:,9) == 2&  freeSlowMatrix(:,5) == 2);
F2actual = length(indecies);
slow(2) = F2actual/Flen2;


indecies = find(freeSlowMatrix(:,5) == 3)
Flen3 = length(indecies);
indecies = find(freeSlowMatrix(:,9) == 2&  freeSlowMatrix(:,5) == 3);
F3actual = length(indecies);
slow(3) = F3actual/Flen3;


indecies = find(freeSlowMatrix(:,5) == 4)
Flen4 = length(indecies);
indecies = find(freeSlowMatrix(:,9) == 2&  freeSlowMatrix(:,5) == 4);
F4actual = length(indecies);
slow(4) = F4actual/Flen4;


indecies = find(freeSlowMatrix(:,5) == 5)
Flen5 = length(indecies);
indecies = find(freeSlowMatrix(:,9) == 2& freeSlowMatrix(:,5) == 5);
F5actual = length(indecies);
slow(5) = F5actual/Flen5;

indecies = find(freeSlowMatrix(:,5) == 6)
Flen6 = length(indecies);
indecies = find(freeSlowMatrix(:,9) == 2& freeSlowMatrix(:,5) == 6);
F6actual = length(indecies);
slow(6) = F6actual/Flen6;




plot(x, fast, 'r--o');
hold on


plot(x, slow, 'b--o');

hold on












end
