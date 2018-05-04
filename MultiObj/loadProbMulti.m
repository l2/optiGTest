%% function for loading available multi-objective problems
% L. LAURENT --  04/05/2018 -- luc.laurent@lecnam.net

% optiGTest - set of testing functions    A toolbox to easy manipulate functions.
% Copyright (C) 2018  Luc LAURENT <luc.laurent@lecnam.net>
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

function [funOpti,funCons,typeCons]=loadProbMulti(funName)
listPb=struct(...
    'test',{{'test'},{'test','test'},{'<=','<='}});
if nargin==1
    funAll=listPb.(funName);
    %
    funOpti=funAll{1};
    funCons=funAll{2};
    typeCons=funAll{3};
else
    funOpti=listPb;
end
end