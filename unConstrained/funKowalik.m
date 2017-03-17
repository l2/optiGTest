%% Kowalik function
%L. LAURENT -- 17/03/2017 -- luc.laurent@lecnam.net
%
%global minimum : f(x)=0.00030748610 for x=[0.192833 0.190836 0.123117
%0.135766]
%
%Design space: -5<xi<5
%



function [p,dp]=funKowalik(xx)
%constants
m=11;
a = [0.1957, 0.1947, 0.1735, 0.1600, 0.0844,...
    0.0627, 0.0456, 0.0342, 0.0323, 0.0235,...
    0.0246];
b =[4,   2,   1,    1/2,  1/4,...
    1/6, 1/8, 1/10, 1/12, 1/14,...
    1/16];
a=reshape(a,1,1,m);
b=reshape(b,1,1,m);


%evaluation and derivatives
x=xx(:,:,1);
y=xx(:,:,2);
z=xx(:,:,3);
w=xx(:,:,4);
%
pa=b.^2+b.*y;
pb=b.^2+b.*z+w;
%
pt=a-x.*pa./pb;
%
p=sum(pt.^2,3);
%
if nargout==2
    %
    dp=zeros(size(xx));
    %
    dp(:,:,1)=sum(-2*pa./pb.*pt,3);
    dp(:,:,2)=sum(-2*b.*x./pb.*pt,3);
    dp(:,:,3)=sum(2*b.*x.*pa./pb.^2.*pt,3);
    dp(:,:,4)=sum(2*x.*pa./pb.^2.*pt,3);
end
end
