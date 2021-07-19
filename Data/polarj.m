function hpol = polarj(theta,rho,line_style, ticks, spokes)
%POLAR  Polar coordinate plot.
%   POLAR(THETA, RHO) makes a plot using polar coordinates of
%   the angle THETA, in radians, versus the radius RHO.
%   POLAR(THETA,RHO,S) uses the linestyle specified in string S.
%   See PLOT for a description of legal linestyles.
%   "ticks" is a two element cell: ticks{1} is a vector listing the radii at which to plot concentric circles; ticks{2} specifies the min and max of
%    the axes; if ticks is not defined or is empty, the default grid is plotted; 
%   spokes gives a list of angles (in radians) at which to plot spokes; if empty, no spokes are plotted
%   See also PLOT, LOGLOG, SEMILOGX, SEMILOGY.

%   Copyright 1984-2001 The MathWorks, Inc. 
%   $Revision: 5.21 $  $Date: 2001/04/15 12:00:43 $

if nargin < 1
    error('Requires 2 or 3 input arguments.')
elseif nargin == 2 
    if isstr(rho)
        line_style = rho;
        rho = theta;
        [mr,nr] = size(rho);
        if mr == 1
            theta = 1:nr;
        else
            th = (1:mr)';
            theta = th(:,ones(1,nr));
        end
    else
        line_style = 'auto';
    end
elseif nargin == 1
    line_style = 'auto';
    rho = theta;
    [mr,nr] = size(rho);
    if mr == 1
        theta = 1:nr;
    else
        th = (1:mr)';
        theta = th(:,ones(1,nr));
    end
end
if isstr(theta) | isstr(rho)
    error('Input arguments must be numeric.');
end
if ~isequal(size(theta),size(rho))
    error('THETA and RHO must be the same size.');
end

% get hold state
cax = newplot;
next = lower(get(cax,'NextPlot'));
hold_state = ishold;

% get x-axis text color so grid is in same color
tc = get(cax,'xcolor');
ls = get(cax,'gridlinestyle');

% Hold on to current Text defaults, reset them to the
% Axes' font attributes so tick marks use them.
fAngle  = get(cax, 'DefaultTextFontAngle');
fName   = get(cax, 'DefaultTextFontName');
fSize   = get(cax, 'DefaultTextFontSize');
fWeight = get(cax, 'DefaultTextFontWeight');
fUnits  = get(cax, 'DefaultTextUnits');
set(cax, 'DefaultTextFontAngle',  get(cax, 'FontAngle'), ...
    'DefaultTextFontName',   get(cax, 'FontName'), ...
    'DefaultTextFontSize',   get(cax, 'FontSize'), ...
    'DefaultTextFontWeight', get(cax, 'FontWeight'), ...
    'DefaultTextUnits','data')

% only do grids if hold is off
if ~hold_state

  if nargin <= 3 | (nargin > 3 & isempty(ticks))  % if did not specify ticks, make a default radial grid
    hold on;
    maxrho = max(abs(rho(:)));
    hhh=plot([-maxrho -maxrho maxrho maxrho],[-maxrho maxrho maxrho -maxrho]);
    set(gca,'dataaspectratio',[1 1 1],'plotboxaspectratiomode','auto')
    v = [get(cax,'xlim') get(cax,'ylim')];
    ticks = sum(get(cax,'ytick')>=0);
    delete(hhh);
    %check radial limits and ticks
    rmin = 0; rmax = v(4); rticks = max(ticks-1,2);
    if rticks > 5   % see if we can reduce the number
       if rem(rticks,2) == 0
            rticks = rticks/2;
        elseif rem(rticks,3) == 0
            rticks = rticks/3;
        end
    end
    %generate vector of ticks;  
    rinc = (rmax-rmin)/rticks;
    ticks = (rmin+rinc):rinc:rmax; 
    
 elseif nargin > 3 & ~isempty(ticks) %if specified ticks
    set(gca,'dataaspectratio',[1 1 1],'plotboxaspectratiomode','auto')
    rmax = max(ticks{2}); 
    rmin = min(ticks{2});
    ticks = ticks{1};
end;

% define a circle
    th = 0:pi/50:2*pi;
    xunit = cos(th);
    yunit = sin(th);
% now really force points on x/y axes to lie on them exactly
    inds = 1:(length(th)-1)/4:length(th);
    xunit(inds(2:2:4)) = zeros(2,1);
    yunit(inds(1:2:5)) = zeros(3,1);
% plot background if necessary
    if ~isstr(get(cax,'color')),
       patch('xdata',xunit*rmax,'ydata',yunit*rmax, ...
             'edgecolor',tc,'facecolor',get(gca,'color'),...
             'handlevisibility','off'); hold on
    end

% draw radial circles
    c82 = cos(82*pi/180);
    s82 = sin(82*pi/180);
    
    for i=1:length(ticks)
        hhh = plot(xunit*ticks(i),yunit*ticks(i),ls,'color',tc,'linewidth',1,...
                   'handlevisibility','off'); hold on;
        text((ticks(i))*c82,(ticks(i))*s82, ...
            ['  ' num2str(ticks(i))],'verticalalignment','bottom',...
            'handlevisibility','off', 'FontUnits', 'normalized', 'FontSize', 0.05)
    end
    %set(hhh,'linestyle','-') % Make outer circle solid

% plot spokes
if nargin == 5 
    th = spokes;
    if size(th,1) > size(th,2) %need row vector here;
        th = th';
    end;
    cst = cos(th); snt = sin(th);
    cs = [zeros(size(cst)); cst];
    sn = [zeros(size(snt)); snt];
    plot(rmax*cs,rmax*sn,ls,'color',tc,'linewidth',1,...
         'handlevisibility','off')

% annotate spokes in degrees
    rt = 1.1*rmax;
    for i = 1:length(th)
         text(rt*cst(i),rt*snt(i),int2str(180*spokes(i)/pi),...
             'horizontalalignment','center',...
             'handlevisibility','off', 'FontUnits', 'normalized', 'FontSize', 0.05);
        %if i == length(th)
        %    loc = int2str(0);
        %else
        %    loc = int2str(180+i*30);
        %end
        %text(-rt*cst(i),-rt*snt(i),int2str(180*(spokes(i)+pi)/pi),'horizontalalignment','center',...
         %    'handlevisibility','off')
    end
end;

% set view to 2-D
    view(2);
% set axis limits
    axis(rmax*[-1 1 -1.15 1.15]);
end

% Reset defaults.
%set(cax, 'DefaultTextFontAngle', fAngle , ...
  %  'DefaultTextFontName',   fName , ...
  %  'DefaultTextFontSize',   fSize, ...
%    'DefaultTextFontWeight', fWeight, ...
%    'DefaultTextUnits',fUnits );

% transform data to Cartesian coordinates.
xx = rho.*cos(theta);
yy = rho.*sin(theta);
% xx(end+1) = xx(1);
% yy(end+1) = yy(1);

% plot data on top of grid
if strcmp(line_style,'auto')
    q = plot(xx,yy);
else
    q = plot(xx,yy,line_style);
end
if nargout > 0
    hpol = q;
end
if ~hold_state
    set(gca,'dataaspectratio',[1 1 1]), axis off; set(cax,'NextPlot',next);
end
set(get(gca,'xlabel'),'visible','on')
set(get(gca,'ylabel'),'visible','on')