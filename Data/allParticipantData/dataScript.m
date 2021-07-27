OR = load('OR2data.mat');
YL = load('YL3data.mat');

all.cleaned.data = [OR.cleaned.data; YL.cleaned.data];
all.cleaned.practiceData = [OR.cleaned.practiceData; YL.cleaned.practiceData];

save('allParticipantData', '-struct', 'all');

%%%%%%%

%Script to remove 1st trial data at start of every block

D = all.cleaned.data;
Dblock = D(:,17);

pD = all.cleaned.practiceData;
pDblock = pDblock(:,17);


%%%%data search loop
for i = 2:3
    subjData = find(all.cleaned.data(:,2) == i);
    for j = 3:10
        for p = 1:length(subjData)
            blockVec = find(subjData(:,17) == j);
            blockVec(1,:) = [];
        end
    end
end
indecies = find(subjData(:,3) == 1);
