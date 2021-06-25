% catch error: This is executed in case something goes wrong in the
% 'try' part due to programming error etc.:
% if strcmp(elstate,'on')
%     Eyelink('StopRecording');
%     Eyelink('closefile');
%     
%     % download data file
%     %%% This after Psychtoolbox setup
    et_state=1; %0 = no ET
    
    if et_state==1
        disp('Setting up Eyelink');
        %%% 1. Provide Eyelink with details about the graphics environment
        % and perform some initializations. The information is returned
        % in a structure that also contains useful default
        % and control codes (e.g. tracker state bit and Eyelink key values).
        el=EyelinkInitDefaults(window);
        
        % overrride default gray background of eyelink, otherwise runs end
        % up gray! also, probably best to calibrate with same colors of
        % background / stimuli as participant will encounter
        el.backgroundcolour = 0.75; % gray screen background
        % el.foregroundcolour = white;
        % el.msgfontcolour = white;
        % el.imgtitlecolour = white;
        % el.calibrationtargetcolour=[white white white];
        EyelinkUpdateDefaults(el);
        
        %%% 2. Initialization of the connection with the Eyelink
        % exit program if this fails
        dummymode =0;
        if ~EyelinkInit(dummymode)
            fprintf('Eyelink Init aborted.\n');
            % **here execute any cleanup and shutdown functions**
            Screen('closeall');
            return;
        end
        
        [v, vs]=Eyelink('GetTrackerVersion');
        fprintf('Running experiment on a ''%s'' tracker.\n', vs );
        
        %%% 3.Set up eye tracker configuration
        % Setting the proper recording resolution, proper calibration type,
        % as well as the data file content;
        % configuration settings
        Eyelink('command','screen_pixel_coords = %ld %ld %ld %ld', 0, 0, mX-1, mY-1);
        Eyelink('message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, mX-1, mY-1);
        
        % set EDF file contents using the file_sample_data and
        % file-event_filter commands
        % set link data thtough link_sample_data and link_event_filter
        Eyelink('command', 'file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
        Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
        
        Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,GAZERES,AREA,STATUS,INPUT');
        Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,HREF,GAZERES,AREA,STATUS,INPUT');
        
        % Tell the Eyelink to send a fixation update every 50 ms
        Eyelink('command', 'fixation_update_interval = %d', 50);
        Eyelink('command', 'fixation_update_accumulate = %d', 50);
        
        % set sample rate in camera setup screen
        Eyelink('command', 'sample_rate = %d', 1000);
        
        %%% 4. Calibrate the eye tracker
        Eyelink('command','calibration_area_proportion = 0.5 0.5');
        Eyelink('command','validation_area_proportion = 0.48 0.48');
        EyelinkDoTrackerSetup(el);
        WaitSecs(0.1);
        
        eye_used = Eyelink('EyeAvailable'); % get eye that's tracked (only track left eye)
        if eye_used == el.BINOCULAR % if both eyes are tracked
            eye_used = el.LEFT_EYE; % use left eye
        end
        
    end
    
    
    fileName=sprintf('%sF.edf', edfFile); % Data file name
     Eyelink('Openfile',fileName);
    
%     try
%         fprintf('Receiving data file ''%s''\n', fileName);
%         status=Eyelink('ReceiveFile',fileName);
%         if status > 0
%             fprintf('ReceiveFile status %d\n', status);
%         end
%         if 2==exist(fileName, 'file')
%             fprintf('Data file ''%s'' can be found in ''%s''\n', fileName, pwd );
%         end
%     catch rdf
%         fprintf('Problem receiving data file ''%s''\n', fileName );
%         rdf;
%     end
% end