%% Rotated hyper-ellipsoid function
%L. LAURENT -- 21/02/2012 -- luc.laurent@lecnam.net
%
%1 global minimum : x=(0,0,...,0) >> f(x)=0
%
%design space: -65.536<xi<65.536

function [p,dp]=funRHE(xx)

coef=10;
% demo mode
dem=false;
if nargin==0
    pas=50;
    borne=65.536;
    [x,y]=meshgrid(linspace(-borne,borne,pas));
    xx=zeros(pas,pas,2);
    xx(:,:,1)=x;xx(:,:,2)=y;
    dem=true;
end
if ~isempty(xx)
    % number of design variables
    nbvar=size(xx,3);
    
    if nbvar==1
        
        
        if size(xx,2)==2
            xxx=xx(:,1);yyy=xx(:,2);
        elseif size(xx,1)==2
            xxx=xx(:,2);yyy=xx(:,1);
        else
            error(['Wrong input variables ',mfilename]);
        end
        p=2*xxx.^2+yyy.^2;
        if nargout==2||dem
            dp(:,:,1)=2*2*xxx;
            dp(:,:,2)=2*yyy;
        end
        
    else
        vv=reshape(nbvar:-1,1,1,nbvar);
        coef=repmat(vv,[size(xx,1) size(xx,2)]);
        cal=coef.*xx.^2;
        p=sum(cal,3);
        if nargout==2||dem
            dp=2*coef.*xx;
        end
        
    end
    
else
    nbvar=dim;
    p=[];
    dp=[];
end
% output: information about the function
if nargout==3
    pts=zeros(1,nbvar);
    infos.min_glob.X=pts;
    infos.min_glob.Z=0;
    infos.min_loc.Z=NaN;
    infos.min_loc.X=NaN;
end

% demo mode
if nargin==0
    figure
    subplot(1,3,1)
    surf(x,y,p);
    axis('tight','square')
    xlabel('x'), ylabel('y'), title('RHE')
    subplot(1,3,2)
    surf(x,y,dp(:,:,1));
    axis('tight','square')
    xlabel('x'), ylabel('y'), title('Grad. X RHE')
    subplot(1,3,3)
    surf(x,y,dp(:,:,2));
    axis('tight','square')
    xlabel('x'), ylabel('y'), title('Grad. Y RHE')
    p=[];
end

end




