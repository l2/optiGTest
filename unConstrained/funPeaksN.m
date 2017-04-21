%% Normalised Peaks function
%L. LAURENT -- 12/05/2010 -- luc.laurent@lecnam.net

function [p,dp1,dp2]=funPeaksN(xx,yy)
xx=xx*4;
yy=yy*4;
p =  3*(1-xx).^2.*exp(-(xx.^2) - (yy+1).^2) ...
    - 10*(xx/5 - xx.^3 - yy.^5).*exp(-xx.^2-yy.^2) ...
    - 1/3*exp(-(xx+1).^2 - yy.^2);

p=p/7.5;