%% Styblinski Tang function
%L. LAURENT -- 23/03/2017 -- luc.laurent@lecnam.net

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
%global minimum : f(x)=-39.16616570377142*nbvar for xi=-1.903534018185960
%
%Design space: -5<xi<5
%

function [p,dp]=funStyblinskiTang(xx)
%constants
a=16;
b=5;

%evaluation and derivatives
pa=xx.^4-a*xx.^2+b*xx;
%
p=sum(pa*1/2,3);
%
if nargout==2
    %
    dp=1/2.*(4*xx.^3-2*a*xx+b);
end