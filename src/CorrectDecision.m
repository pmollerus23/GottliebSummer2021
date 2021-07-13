if Press(upKey) > 0 || Press(downKey)>0
                    %code to tell user how many points they gained
                    rewardAmtText = num2str(trialData(j, 5));
                    plus = '+';
                    responseText = [plus ' ' rewardAmtText];
                    flag = 1;
                    % code to find if user input was correct
                    
                    %user presses up arrow and t is up so correct
                    if Press(upKey) > 0 && trialData(j, 3) == up
                        text = 'correct';
                        response = 1;
                        keyPress(j,1) = 1;
                        
                        
                        %user presses down arrow and t is down so correct
                    elseif Press(downKey) > 0 && trialData(j, 3) == down
                        text = 'correct';
                        response = 1;
                        keyPress(j,1) = 0;
                        
                        
                        %user presses up arrow and t is down so incorrect
                    elseif Press(upKey) > 0 && trialData(j, 3) == down
                        text = 'incorrect';
                        responseText = '+ 0';
                        response = 0;
                        keyPress(j,1) = 1;
                        
                        %user presses down arrow and t is up so incorrect
                    elseif Press(downKey) > 0 && trialData(j, 3) == up
                        text = 'incorrect';
                        responseText = '+ 0';
                        response = 0;
                        keyPress(j,1) = 0;
                    end
                    
                    Screen('DrawTexture', window, dispImageCross, [], centerRect);
                    Screen('Flip', window);
                    
                     
                    
                    WaitSecs(3-respTime(j,1));
                    
                    %record response data
                    correctOrIncorrect(j,1) = response;
                    %print feedback from decesion in trial to screen
                    if feedback == true
                    DrawFormattedText(window, text,'center' , yCenter, black);
                    DrawFormattedText(window, responseText, 'center',screenYpixels * 0.25, black);
                    end
                    
                    Screen('Flip', window);
                    
                    if strcmp(elstate, 'on')
        % Mark events, messages, etc. in dataviwer trial
        Eyelink('Message', 'Accuracy confirmation shown');
        WaitSecs(0.001);
    end
                    
                    WaitSecs(2)
                    % DrawFormattedText(window, responseText, 'center',screenYpixels * 0.25, black);
                end