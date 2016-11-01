%% Bukin 8's function
%L. LAURENT -- 01/11/2016 -- luc.laurent@lecnam.net
%

%     GRENAT - GRadient ENhanced Approximation Toolbox
%     A toolbox for generating and exploiting gradient-enhanced surrogate models
%     Copyright (C) 2016  Luc LAURENT <luc.laurent@lecnam.net>
%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
%
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

function [p,dp]=funBukin8(xx)

%constants
a=1000;
b=800;
c=40;

%evaluation and derivatives
pa=xx(:,:,2).^2+xx(:,:,1).^2-b;
pb=xx(:,:,2)+xx(:,:,1)+c;
p=a*abs(pa)+abs(pb);
if nargout==2
    dp(:,:,1)=2*a*xx(:,:,1).*sign(pa)+sign(pb);
    dp(:,:,2)=2*a*xx(:,:,2).*sign(pa)+sign(pb);   
end
end
