%% function for loading constrained problems
% L. LAURENT --  01/05/2018 -- luc.laurent@lecnam.net

% sources available here:
% https://bitbucket.org/luclaurent/optigtest/
% https://github.com/luclaurent/optigtest/

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

function [funOpti,funCons,typeCons]=loadProbCons(pbName)
listPb=struct(...
    'RosenbrockCubicLine',{{'Rosenbrock'},{'Cons1','Cons2'},{'<=','<='}},...
    'RosenbrockDisk',{{'Rosenbrock'},{'Disk2'},{'<='}},...
    'BirdDisk',{{'Bird'},{'Disk25'},{'<'}},...
    'Townsend',{{'Townsend'},{'ConsTownsend'},{'<'}},...
    'Simionescu',{{'Simionescu'},{'ConsSimionescu'},{'<='}});
if nargin==1
    %
    funOpti=listPb(1).(pbName);
    funCons=listPb(2).(pbName);
    typeCons=listPb(3).(pbName);
else
    funOpti=listPb;
end
end