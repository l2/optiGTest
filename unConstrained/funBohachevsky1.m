%% Bohachevsky1 function
%L. LAURENT -- 16/09/2011 -- luc.laurent@lecnam.net
%
%global minimum: f(x1,x2)=0 pour (x1,x2)=(0,0)
%
%Domaine d'etude de la fonction: -100<x1<100, -100<x2<100 (-2<xi<2)



function [p,dp,infos]=funBohachevsky1(xx,dim)

% demo mode
dem=false;
if nargin==0
    pas=50;
    borne=2;
    [x,y]=meshgrid(linspace(-borne,borne,pas));
    xx=zeros(pas,pas,2);
    xx(:,:,1)=x;xx(:,:,2)=y;
    dem=true;
end
if ~isempty(xx)
    if size(xx,3)>2
        error('The Bohachevsky1 function is a 2 dimensional function');
    elseif size(xx,3)==1
        if size(xx,2)==2
            xxx=xx(:,1);yyy=xx(:,2);
        elseif size(xx,1)==2
            xxx=xx(:,2);yyy=xx(:,1);
        else
            error(['Wrong input variables ',mfilename]);
        end
        
    else
        xxx=xx(:,:,1);yyy=xx(:,:,2);
    end
    
    p = xxx.^2+2*yyy.^2-0.3*cos(3*pi*xxx)-0.4*cos(4*pi*yyy)+0.7;
    
    
    if nargout==2||dem
        dp(:,:,1)=2*xxx+0.9*pi*sin(3*pi*xxx);
        dp(:,:,2)=4*yyy+1.6*pi*sin(4*pi*yyy);
    end
else
    if nargin==2
        nbvar=dim;
    end
    p=[];
    dp=[];
end
% output: information about the function
if nargout==3
    infos.min_glob.Z=0;
    infos.min_glob.X=zeros(1,nbvar);
    infos.min_loc.Z=NaN;
    infos.min_loc.X=NaN;
end

% demo mode
if nargin==0
    figure
    subplot(1,3,1)
    surf(x,y,p);
    axis('tight','square')
    xlabel('x'), ylabel('y'), title('Bohachevsky 1')
    subplot(1,3,2)
    surf(x,y,dp(:,:,1));
    axis('tight','square')
    xlabel('x'), ylabel('y'), title('Grad. X Bohachevsky 1')
    subplot(1,3,3)
    surf(x,y,dp(:,:,2));
    axis('tight','square')
    xlabel('x'), ylabel('y'), title('Grad. Y Bohachevsky 1')
end
end
