%% 1. Participant information dialog box
prompt = {'EDF file name (1 to 8 letters or numbers):','Participant code:','Date of birth:', 'Sex:','Right/Left handed:','Free or Forced Choice: 0-1'}; %description of fields
defaults = {' ','','','','','',''};%you can put in default responses
answer = inputdlg(prompt, 'Particpant information',1,defaults); %opens dialog
edfFile = answer{1};
fprintf('EDFFile: %s\n', edfFile );
P_code = answer{2,:};
P_bdate = answer{3,:};
P_sex = answer{4,:};
P_hand = answer{5,:};
P_info = {'Code' P_code ;'Birth date' P_bdate ;'Sex' P_sex ;'Hand' P_hand};
Start_time = clock;
trialChoice=str2double(answer{6,:});

finalTrialData.participant.code = P_code;
finalTrialData.participant.P_bdate = P_bdate;
finalTrialData.participant.P_sex = P_sex;
finalTrialData.participant.P_hand = P_hand;
finalTrialData.participant.startTime = Start_time;






