if Press(upKey) > 0 || Press(downKey)>0
                    %code to tell user how many points they gained
                    if trialData(j, 5) == 1
                       rewardAmtText = '10'; 
                    end
                    if trialData(j, 5) == 2
                        rewardAmtText = '14';
                    end
                     if trialData(j, 5) == 3
                        rewardAmtText = '18';
                     end
                     if trialData(j, 5) == 4
                        rewardAmtText = '22';
                     end
                     if trialData(j, 5) == 5
                        rewardAmtText = '26';
                     end
                     if trialData(j, 5) == 6
                        rewardAmtText = '30';
                    end
                    
                    if easy== true
                        rewardAmtText = '10';
                    end
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
                    
                     
                    
                    WaitSecs(2-respTime(j,1));
                    
                    %record response data
                    correctOrIncorrect(j,1) = response;
                    %print feedback from decesion in trial to screen
                    if feedback == true
                        DrawFormattedText(window, text,'center' , yCenter, black);
                        DrawFormattedText(window, responseText, 'center',screenYpixels * 0.25, black);
                    end
                    
                    Screen('Flip', window);
                    if feedback == true
                        if strcmp(elstate, 'on')
                            % Mark events, messages, etc. in dataviwer trial
                            Eyelink('Message', 'Feedback shown');
                            WaitSecs(0.001);
                        end
                    end
                    
                    WaitSecs(0.5)
                    % DrawFormattedText(window, responseText, 'center',screenYpixels * 0.25, black);
                end