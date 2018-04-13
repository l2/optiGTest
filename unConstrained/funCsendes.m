%% Csendes's function
%L. LAURENT -- 16/09/2011 -- luc.laurent@lecnam.net

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
%global minimum : f(x)=0 for (x)=(0,...,0)
%
%Design space: -1<xi<1


function [p,dp]=funCsendes(xx)

%constants
a=2;

%evaluation and derivatives
sx=sin(1./xx);
pa=a+sx;
pSum=xx.^6.*pa;
p=sum(pSum,3);
%
if nargout==2
    dp=6*xx.^5.*pa-xx.^4.*cos(1./xx);
end
end