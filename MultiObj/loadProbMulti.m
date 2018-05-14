%% Function for loading available multi-objective problems
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
    'BinhKorn',{{'ObjKornBinh1','ObjKornBinh2'},{'ConsKornBinh1','ConsKornBinh2'},{'<=','>='}},...
    'ChakongHaimes',{{'ObjChakongHaimes1','ObjChakongHaimes2'},{'ConsChakongHaimes1','ConsChakongHaimes2'},{'<=','<='}},...
    'FonsecaFleming',{{'ObjFonsecaFleming1','ObjFonsecaFleming2'},{},{}},...
    'TestFun4',{{'ObjTestFun41','ObjTestFun42'},{'ConsTestFun41','ConsTestFun42','ConsTestFun43'},{'>=','>=','>='}},...
    'Kursawe',{{'ObjKursawe1','ObjKursawe2'},{},{}},...
    'MultiSchaffer1',{{'ObjMultiSchaffer11','ObjMultiSchaffer12'},{},{}},... 
    'MultiSchaffer2',{{'ObjMultiSchaffer21','ObjMultiSchaffer22'},{},{}},...
    'Poloni',{{'ObjPoloni1','ObjPoloni2'},{},{}},...
    'ZitzlerDebThiele1',{{'ObjZitzlerDebThiele11','ObjZitzlerDebThiele12'},{},{}},...
    'ZitzlerDebThiele2',{{'ObjZitzlerDebThiele21','ObjZitzlerDebThiele22'},{},{}},...
    'ZitzlerDebThiele3',{{'ObjZitzlerDebThiele31','ObjZitzlerDebThiele32'},{},{}},...
    'ZitzlerDebThiele4',{{'ObjZitzlerDebThiele41','ObjZitzlerDebThiele42'},{},{}},...
    'ZitzlerDebThiele6',{{'ObjZitzlerDebThiele61','ObjZitzlerDebThiele62'},{},{}},...
    'OsyczkaKundu',{{'ObjOsyczkaKundu1','ObjOsyczkaKundu2'},{'ConsOsyczkaKundu1','ConsOsyczkaKundu2','ConsOsyczkaKundu3','ConsOsyczkaKundu4','ConsOsyczkaKundu5','ConsOsyczkaKundu6'},{'>=','>=','>=','>=','>=','>='}},...
    'CTP1',{{'ObjCTP11','ObjCTP12'},{'ConsCTP11','ConsCTP12'},{'>=','>='}},...
    'ConstrEx',{{'ObjConstrEx1','ObjConstrEx2'},{'ConsConstrEx1','ConsConstrEx2'},{'>=','>='}},...
    'Viennet',{{'ObjViennet1','ObjViennet2','ObjViennet3'},{},{}});
if nargin==1
    funAll={listPb.(funName)};
    %
    funOpti=funAll{1};
    funCons=funAll{2};
    typeCons=funAll{3};
else
    funOpti=listPb;
end
end