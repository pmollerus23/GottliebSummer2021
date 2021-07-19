function [] = polarPlotsPC(data, pCode)

d = data;
pCode;
ff = d(:,1);
sn = d(:,2);
tr = d(:,3);
tLoc = d(:,4);
loc = d(:,5);
abtT = d(:,8);
incV = d(:,7);
TrSp = d(:, 9);
CI = d(:, 14);
FR = d(:, 12)
%blkNum = d(:, 17);
RT = d(:, 15);
    theta = [2*pi, pi/4, pi/2, (3*pi)/4, pi, (5*pi)/4, (3*pi)/2, (7*pi)/4, 0];
    
    for i = 1:8
        indecies1 = find(tLoc == i& CI == 1& sn == pCode& ff == 1 & TrSp == 1)
        tot1 = find(tLoc == i& (CI == 1| CI ==0) & sn == pCode& ff == 1 & TrSp == 1)
        pc1(i) = length(indecies1)/ length(tot1)
        pft1 = 'bo-';
        
        
        indecies2 = find(tLoc == i& CI == 1& sn == pCode& ff == 2 & TrSp == 1)
        tot2 = find(tLoc == i& (CI == 1| CI ==0) & sn == pCode& ff == 2 & TrSp == 1)
        pc2(i) = length(indecies2)/ length(tot2)
        pft2 = 'bx-';
        
        indecies3 = find(tLoc == i& CI == 1& sn == pCode& ff == 1 & TrSp == 2)
        tot3 = find(tLoc == i& (CI == 1| CI ==0) & sn == pCode& ff == 1 & TrSp == 2)
        pc3(i) = length(indecies3)/ length(tot3)
        pft3 = 'ro-';
        
        indecies4 = find(tLoc == i& CI == 1& sn == pCode& ff == 2 & TrSp == 2)
        tot4 = find(tLoc == i& (CI == 1| CI ==0) & sn == pCode& ff == 2 & TrSp == 2)
        pc4(i) = length(indecies4)/ length(tot4)
        pft4 = 'rx-';
        
        
        
    end
    
    rho1 = [pc1(1) pc1(2) pc1(3) pc1(4) pc1(4) pc1(6) pc1(7) pc1(8) pc1(1)]
    rho2 = [pc2(1) pc2(2) pc2(3) pc2(4) pc2(4) pc2(6) pc2(7) pc2(8) pc2(1)]
    rho3 = [pc3(1) pc3(2) pc3(3) pc3(4) pc3(4) pc3(6) pc3(7) pc3(8) pc3(1)]
    rho4 = [pc4(1) pc4(2) pc4(3) pc4(4) pc4(4) pc4(6) pc4(7) pc4(8) pc4(1)]

    polarj(theta, rho1, pft1); hold on
    polarj(theta, rho2, pft2); hold on 
    polarj(theta, rho3, pft3); hold on 
    polarj(theta, rho4, pft4); hold on 
    pbaspect([1 1 1])

    
    title('PC and Location of Target')

    
    
    
    
    
end