%% Zettl function
% L. LAURENT -- 28/02/2017 -- luc.laurent@lecnam.net

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

%1 minimum global: f(-0.02896,0)=-0.0037912
%
%Design space -1<xi<5

function [p,dp] = funZettl(xx)

%constants
a=1/4;
b=2;

%evaluation and derivatives
x=xx(:,:,1);
y=xx(:,:,2);
%
pa=a*x;
pb=x.^2-b*x+y.^2;
%
p=pa+pb.^2;

if nargout==2   
    dp=zeros(size(xx));
    %
    dp(:,:,1)=a+2*(2*x-b).*pb;
    dp(:,:,2)=4*y.*pb;
end
end

