%% Xin-She-Yang 2 function
% L. LAURENT -- 28/02/2017 -- luc.laurent@lecnam.net

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

%1 minimum global: f(0,...,0)=0
%
%Design space -2pi<xi<2pi

function [p,dp] = funXinSheYang2(xx)

%evaluation and derivatives
pa=abs(xx);
pb=sin(xx.^2);
%
pA=sum(pa,3);
pB=sum(pb,3);
pC=exp(pB);
%
p=pA./pC;

if nargout==2
    dp=(sign(xx).*pC-2*xx.*cos(xx.^2).*pC.*pA)./pC.^2;    
end
end

