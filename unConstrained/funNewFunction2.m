%% New Function 2 function
%L. LAURENT -- 21/03/2017 -- luc.laurent@lecnam.net

% optiGTest - set of testing functions    A toolbox to easy manipulate functions.
% Copyright (C) 2017  Luc LAURENT <luc.laurent@lecnam.net>
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

%
%global minimum : f(x)=-0.1971881059905 for x=[-9.94112 -9.99952]
%
%Design space: -10<xi<10
%


function [p,dp]=funNewFunction2(xx)
%constants
a=100;

%evaluation and derivatives
x=xx(:,:,1);
y=xx(:,:,2);
%
xy=x.^2+y;
axy=abs(xy);
sqxy=sqrt(axy);
sa=sin(sqxy);
%
pb=(x+y)./a;
%
p=abs(sa).^(1/2)+pb;
%
if nargout==2
    %
    dp=zeros(size(xx));
    %
    ca=cos(sqxy);
    %
    dp(:,:,1)=1/2*x.*sign(xy)./sqxy.*ca.*sign(sa).*abs(sa).^(-1/2)+1/a;
    dp(:,:,2)=1/4.*sign(xy)./sqxy.*ca.*sign(sa).*abs(sa).^(-1/2)+1/a;
    %
end
