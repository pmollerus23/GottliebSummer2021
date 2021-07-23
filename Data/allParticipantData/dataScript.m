OR = load('OR2data.mat');
YL = load('YL3data.mat');

all.cleaned.data = [OR.cleaned.data; YL.cleaned.data];
all.cleaned.practiceData = [OR.cleaned.practiceData; YL.cleaned.practiceData];

save('allParticipantData', '-struct', 'all');