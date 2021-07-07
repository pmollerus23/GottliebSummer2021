function polarPlots(matrix)


[height,col] = size(matrix);

if col == 14
    indecies = find(matrix(:,2) == 1);
    average1 = mean(matrix(indecies,13));
   
    indecies = find(matrix(:,2) == 2);
    average2 = mean(matrix(indecies,13));
   
    indecies = find(matrix(:,2) == 3);
    average3 = mean(matrix(indecies,13));
   
    indecies = find(matrix(:,2) == 4);
    average4 = mean(matrix(indecies,13));
   
    indecies = find(matrix(:,2) == 5);
    average5 = mean(matrix(indecies,13));
   
    indecies = find(matrix(:,2) == 6);
    average6 = mean(matrix(indecies,13));
   
    indecies = find(matrix(:,2) == 7);
    average7 = mean(matrix(indecies,13));
   
    indecies = find(matrix(:,2) == 8);
    average8 = mean(matrix(indecies,13));
   
    theta = [2*pi, pi/3, pi/2, (3*pi)/4, pi, (5*pi)/4, (3*pi)/2, (7*pi)/4, 0];
    rho = [average1 average2 average3 average4 average5 average6 average7 average8 average1];
    subplot(2,1,1);
    title('Free choice reaction times')

   fiRT = polarplot(theta, rho);
   
   
   
    indecies = find(matrix(:,2) == 1);
    average11 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 2);
    average22 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 3);
    average33 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 4);
    average44 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 5);
    average55 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 6);
    average66 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 7);
    average77 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 8);
    average88 = mean(matrix(indecies,12));
   
   
   
   
   
   
    theta = [2*pi, pi/3, pi/2, (3*pi)/4, pi, (5*pi)/4, (3*pi)/2, (7*pi)/4, 0];
    rho = [average11 average22 average33 average44 average55 average66 average77 average88 average11];
    subplot(2,1,2);
    title('Free choice percent correct')

    figPC = polarplot(theta, rho);
   
   
   
       
   
elseif col == 12
   
   
   
    indecies = find(matrix(:,2) == 1);
    average1 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 2);
    average2 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 3);
    average3 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 4);
    average4 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 5);
    average5 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 6);
    average6 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 7);
    average7 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 8);
    average8 = mean(matrix(indecies,8));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    indecies = find(matrix(:,2) == 1 & matrix(:,7) == 1);
    sar1 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 2 & matrix(:,7) == 1);
    sar2 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 3 & matrix(:,7) == 1);
    sar3 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 4 & matrix(:,7) == 1);
    sar4 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 5& matrix(:,7) == 1);
    sar5 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 6& matrix(:,7) == 1);
    sar6 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 7& matrix(:,7) == 1);
    sar7 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 8& matrix(:,7) == 1);
    sar8 = mean(matrix(indecies,8));
   
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    indecies = find(matrix(:,2) == 1& matrix(:,7) == 2);
    average111 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 2& matrix(:,7) == 2);
    average222 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 3& matrix(:,7) == 2);
    average333 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 4& matrix(:,7) == 2);
    average444 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 5& matrix(:,7) == 2);
    average555 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 6& matrix(:,7) == 2);
    average666 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 7& matrix(:,7) == 2);
    average777 = mean(matrix(indecies,8));
   
    indecies = find(matrix(:,2) == 8& matrix(:,7) == 2);
    average888 = mean(matrix(indecies,8));
   
    theta1 = [2*pi, pi/3, pi/2, (3*pi)/4, pi, (5*pi)/4, (3*pi)/2, (7*pi)/4, 0];
    rho1 = [average111 average222 average333 average444 average555 average666 average777 average888 average111];
    subplot(2,1,1);
        title('force choice reaction times')

  % polarplot(theta, rho);
   %hold on;
   
   theta2 = [2*pi, pi/3, pi/2, (3*pi)/4, pi, (5*pi)/4, (3*pi)/2, (7*pi)/4, 0];
    rho2 = [sar1 sar2 sar3 sar4 sar5 sar6 sar7 sar8 sar1];
   %polarplot(theta, rho)
   %hold on
   
    theta3 = [2*pi, pi/3, pi/2, (3*pi)/4, pi, (5*pi)/4, (3*pi)/2, (7*pi)/4, 0];
    rho3 = [average1 average2 average3 average4 average5 average6 average7 average8 average1];
      polarplot(theta1,rho1,'--r');
      hold on
      polarplot(theta1, rho2,'-.b');
      hold on
      polarplot(theta1, rho3, 'g');
      hold off
     

   
   
   
    indecies = find(matrix(:,2) == 1);
    average11 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 2);
    average22 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 3);
    average33 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 4);
    average44 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 5);
    average55 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 6);
    average66 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 7);
    average77 = mean(matrix(indecies,12));
   
    indecies = find(matrix(:,2) == 8);
    average88 = mean(matrix(indecies,12));
   
   
   
   
   
   
    theta = [2*pi, pi/3, pi/2, (3*pi)/4, pi, (5*pi)/4, (3*pi)/2, (7*pi)/4, 0];
    rho = [average11 average22 average33 average44 average55 average66 average77 average88 average11];
    subplot(2,1,2);
        title('force choice percent correct')

 polarplot(theta, rho);
   
   
 
   
   
end
 

end