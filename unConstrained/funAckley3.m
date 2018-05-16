%% Ackley's function 3
%L. LAURENT -- 31/10/2016 -- luc.laurent@lecnam.net

% sources available here:
% https://bitbucket.org/luclaurent/optigtest/
% https://github.com/luclaurent/optigtest/

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
%one local minimum
%1 global minimum : x=(0,-0.4) >> f(x)=-219.1418
%
%design space -32<xi<32



function [p,dp]=funAckley3(xx)

%constants
a=200;
b=0.02;
c=5;
d=3;

%responses and derivatives
normP=sqrt(sum(xx.^2,3));
ex1=exp(-b*normP);
ex2=exp(cos(d*xx(:,:,1))+sin(d*xx(:,:,2)));
p=-a*ex1-c*ex2;

if nargout==2
    dp=a*b*xx./normP.*ex1;
    %
    dp(:,:,1)=dp(:,:,1)+c*d*sin(d*xx(:,:,1)).*ex2;
    dp(:,:,2)=dp(:,:,2)-c*d*cos(d*xx(:,:,2)).*ex2;
end
end
