            %check for fixation during search task
            while ((GetSecs-startrt)<=T_delay  && Novalid==0) %| Press(downKey)==0 | Press(upKey)==0
                if Eyelink('NewFloatSampleAvailable') > 0
                    % get the sample in the form of an event structure
                    evt = Eyelink('NewestFloatSample');
                    if eye_used ~= -1 % do we know which eye to use yet?
                        % if we do, get current gaze position from sample
                        
                        x = evt.gx(eye_used+1); % +1 as we're accessing MATLAB array
                        y = evt.gy(eye_used+1);
                        
                        % do we have valid data and is the pupil visible?
                        if x~=el.MISSING_DATA && y~=el.MISSING_DATA && evt.pa(eye_used+1)>0
                            eyemx=x;
                            eyemy=y;
                            % if no fixation
                            if  (eyemx>fixation_pos(1)-150 && eyemx < fixation_pos(3)+150 && eyemy>fixation_pos(2)-150 && eyemy<fixation_pos(4)+150)
                                totalFixTime = totalFixTime + 50;
                                totalFixTimeout=0;
                                if totalFixTime >= fixTime-250
                                    nofixtimeflag=0;
                                end
                            elseif (eyemx<fixation_pos(1)-150 || eyemx > fixation_pos(3)+150 || eyemy<fixation_pos(2)-150 || eyemy>fixation_pos(4)+150)% broke fixation reset time
                                totalFixTimeout = totalFixTimeout + 0.5;% change 50ms
                                totalFixTime = 0;
                                if totalFixTimeout >= 250
                                    nofixtimeflag =1;
                                    Novalid=1;
                                end
                                
                                % Mark events, messages, etc. in dataviwer trial
                                WaitSecs(0.001);
                            end
                        end
                    end
                end
               % [pressed, Press] = KbQueueCheck(deviceIndices);
                 
                [bp,~,Press] = KbCheck(deviceIndices);
                if bp == 1
                    %saves reaction time for all trials
                    respTime(j,1) = GetSecs-start1;
                    break
                end 
                
            end
            
            if Press(downKey)>0 || Press(upKey)>0
                nofixtimeflag=0;
            end