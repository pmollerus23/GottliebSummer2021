if easy == false
        Screen('DrawTexture', window, dispImageCross, [], centerRect);
        
        
        
        %determine orientation of t presented 1 means the t is upright 0
        %means the t is upsidedown
        if trialData(j, 3) == 1
            orientationT = dispImageT;
        elseif trialData(j, 3) == 0
            orientationT = dispImageUSDT;
            
        end
        
        %record data on how the t is oriented
        orientationOfT = trialData(j, 3);
        up = 1;
        down = 0;
        
        %drawing T to screen given value in random T location matrix
        % a value of one indicates the right most value position of the
        % circle, a value of two indicates a up rihgt diagonal orientation
        % and then continues to increase counter clock wise
        if trialData(j, 2) == 1
            Screen('DrawTexture', window, orientationT, [], rightMostRect);
            
        elseif trialData(j, 2) == 2
            Screen('DrawTexture', window, orientationT, [], diagonalUpRight);
            
        elseif trialData(j, 2) == 3
            Screen('DrawTexture', window, orientationT, [], vertMostRect);
            
        elseif trialData(j, 2) == 4
            Screen('DrawTexture', window, orientationT, [], diagonalUpLeft);
            
        elseif trialData(j, 2) == 5
            Screen('DrawTexture', window, orientationT, [], leftMostRect);
            
        elseif trialData(j, 2) == 6
            Screen('DrawTexture', window, orientationT, [], diagonalDownLeft);
            
        elseif trialData(j, 2) == 7
            Screen('DrawTexture', window, orientationT, [], downMostRect);
            
        elseif trialData(j, 2) == 8
            Screen('DrawTexture', window, orientationT, [], diagonalDownRight);
            
        end
        %decide where the t is located
        occupiedByT = trialData(j, 2);
        %store data on t location in circle
        positionOfT(j,1) = occupiedByT;
        
        %loop is used to find orientation of L and assign it to trial image
        %and draw to screen
        for k = 1:8
            %find the orientation of the L then assign it to the trial image
            %variable
            if randLOrientationArray(k) == 1
                imageForTrial = upsideDownL;
            elseif randLOrientationArray(k) == 2
                imageForTrial = normalL;
            elseif randLOrientationArray(k) == 3
                imageForTrial = sideL;
            elseif randLOrientationArray(k) == 4
                imageForTrial = sideWL;
            end
            
            %Draw L with proper orientation to all locations except for
            %location where T is located
            if randLPositionArray(k) == occupiedByT
                %do nothing if the positon is occupied by the t for trial
            elseif  randLPositionArray(k) == 1
                Screen('DrawTexture', window, imageForTrial, [], rightMostRect);
            elseif  randLPositionArray(k) == 2
                Screen('DrawTexture', window, imageForTrial, [], diagonalUpRight);
            elseif  randLPositionArray(k) == 3
                Screen('DrawTexture', window, imageForTrial, [], vertMostRect);
            elseif  randLPositionArray(k) == 4
                Screen('DrawTexture', window, imageForTrial, [], diagonalUpLeft);
            elseif  randLPositionArray(k) == 5
                Screen('DrawTexture', window, imageForTrial, [], leftMostRect);
            elseif  randLPositionArray(k) == 6
                Screen('DrawTexture', window, imageForTrial, [], diagonalDownLeft);
            elseif  randLPositionArray(k) == 7
                Screen('DrawTexture', window, imageForTrial, [], downMostRect);
            elseif  randLPositionArray(k) == 8
                Screen('DrawTexture', window, imageForTrial, [], diagonalDownRight);
                
            end
            
        end
        
elseif easy == true
    
    
            %determine orientation of t presented 1 means the t is upright 0
            %means the t is upsidedown
            if trialData(j, 3) == 1
                orientationT = dispImageT;
                
            elseif trialData(j, 3) == 0
                orientationT = dispImageUSDT;
                
            end
            
            %record data on how the t is oriented
            orientationOfT = trialData(j, 3);
            up = 1;
            down = 0;
            
            %drawing T to screen given value in random T location matrix
            % a value of 1 indicates the right most value position of the
            % circle, a value of 2 indicates a up rihgt diagonal orientation
            % and then continues to increase counter clock wise
            if trialData(j, 2) == 1
                Screen('DrawTexture', window, orientationT, [], rightMostRect);
            elseif trialData(j, 2) == 2
                Screen('DrawTexture', window, orientationT, [], diagonalUpRight);
                
            elseif trialData(j, 2) == 3
                Screen('DrawTexture', window, orientationT, [], vertMostRect);
                
            elseif trialData(j, 2) == 4
                Screen('DrawTexture', window, orientationT, [], diagonalUpLeft);
                
            elseif trialData(j, 2) == 5
                Screen('DrawTexture', window, orientationT, [], leftMostRect);
                
            elseif trialData(j, 2) == 6
                Screen('DrawTexture', window, orientationT, [], diagonalDownLeft);
                
            elseif trialData(j, 2) == 7
                Screen('DrawTexture', window, orientationT, [], downMostRect);
                
            elseif trialData(j, 2) == 8
                Screen('DrawTexture', window, orientationT, [], diagonalDownRight);
                
            end
            %record location of drawn t
            occupiedByT = trialData(j, 2);
            
            %store data on t location in circle
            positionOfT(j,1) = occupiedByT;
            
    
end
        