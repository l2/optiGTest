%% Biggs EXP 3's function
%L. LAURENT -- 31/10/2016 -- luc.laurent@lecnam.net
%
%one local minimum
%1 global minimum : x=(1, 10, 5) >> f(x)=0
%
%design space 0<xi<20



function [p,dp,infos]=funBiggsExp3(xx,dim)

%constants
a=5;
b=10;
nbt=10;
t=0.1.*(1:10);
y=exp(-t)-a*exp(-b*t);

%space
Xmin=[0 0 0];
Xmax=[20 20 20];

%default dimension
if nargin==1;dim=3;end

% demo mode
dem=false;
if nargin==0
fprintf('3-dimensional function (no demo mode\n')
xx=[];
end
if ~isempty(xx)
    %number of design variables
    nbvar=size(xx,3);
    if nbvar==1
        if size(xx,2)==3
            xxx=xx(:,1);yyy=xx(:,2);zzz=xx(:,3);
        elseif size(xx,1)==3
            xxx=xx(1,:);yyy=xx(2,:);zzz=xx(3,:);
        else
            error(['Wrong input variables ',mfilename]);
        end
    elseif nbvar==2||nbvar>3
        error('The Biggs EXP 3 function is a 3 dimensional function');
    else
        xxx=xx(:,:,1);
        yyy=xx(:,:,2);
        zzz=xx(:,:,3);
    end
        
    p=zeros(size(xxx));
    for it=1:nbt
        p=p+(exp(-t(it).*xxx)-zzz.*exp(-t(it).*yyy)-y(it)).^2;
    end
    if nargout==2||dem
        dp=zeros(size(xxx,1),size(xxx,2),3);
        for it=1:nbt
            dp(:,:,1)=dp(:,:,1)-2*t(it)*exp(-t(it)*xxx)*(exp(-t(it).*xxx)-zzz.*exp(-t(it).*yyy)-y(it));
            dp(:,:,2)=dp(:,:,2)+2*zzz.*t(it)*exp(-t(it)*yyy)*(exp(-t(it).*xxx)-zzz.*exp(-t(it).*yyy)-y(it));
            dp(:,:,3)=dp(:,:,3)-2.*exp(-t(it)*yyy)*(exp(-t(it).*xxx)-zzz.*exp(-t(it).*yyy)-y(it));
        end
    end
else
    if nargin==2
        nbvar=dim;
    end
    p=[];
    dp=[];
end
%output of information about the function
if nargout==3
    infos.Xmin=Xmin;
    infos.Xmax=Xmax;
    infos.min_glob.Z=0;
    infos.min_glob.X=[1, 10, 5];
    infos.min_loc.Z=NaN;
    infos.min_loc.X=NaN;
end

end
