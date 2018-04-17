%% function for loading design space of available functions
% L. LAURENT --  15/12/2017 -- luc.laurent@lecnam.net

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

function [xMin,xMax]=loadSpace(funName,dim)
listSpace=struct(...
    'Ackley1',[-35;35],...
    'Ackley2',[-32;32],...
    'Ackley3',[-32;32],...
    'Ackley4',[-35;35],...
    'Adjiman',[-1 -1;2 1],...
    'Alpine1',[-10;10],...
    'Alpine2',[0;10],...
    'AHE',[-5.12;5.12],...
    'AMGM',[0;10],...
    'BartelsConn',[-500;500],...
    'Beale',[-4.5;4.5],...
    'BiggsExp2',[0;20],...
    'BiggsExp3',[0;20],...
    'BiggsExp4',[0;20],...
    'BiggsExp5',[0;20],...
    'BiggsExp6',[0;20],...
    'Bird',2*pi*[-1;1],...
        'Bohachevsky1',100*[-1;1],...
    'Bohachevsky2',100*[-1;1],...
    'Bohachevsky3',100*[-1;1],...
    'Booth',10*[-1;1],...
    'Brad',[-0.25 0.01 0.01;0.25 2.5 2.5],...
    'Brown',[-1;4],...
    'Bukin01',[-5 -5;5 5],...
    'Bukin02',[-15 -3;-5 3],...
    'Bukin03',[-5 -5;5 5],...
    'Bukin04',[-15 -5;5 5],...
    'Bukin05',[-15 -5;5 5],...
    'Bukin06',[-5 -5;5 5],...
    'Bukin07',[-5 -5;150 5],...
    'Bukin08',[-25 -25;0 0],...
    'Bukin09',[-10 -5;5 5],...
    'Bukin10',[-10 -10;0 0],...
    'Bukin11',[-10 -10;0 0],...
    'Bukin12',[-10 -10;0 0],...
    'Bukin13',[-5 -5;5 5],...
    'Bukin14',[-15 -5;5 5],...
    'Bukin15',[-30 -200;15 100],...
    'Bukin16',[-40 -40;40 40],...
    'Bukin17',[-40 -40;40 40],...
    'Bukin18',[-10 -150;10 10],...
    'Bukin19',[-30 -30;30 150],...
    'Bukin20',[-5 -5;5 5],...
    'CamelbackThreeHump',[-5 -5;5 5],...%[-2.5 -3;2.5 3]
    'CamelbackSixHump',[-3 -2;3 2],...%[-2 -1;2 1]
    'CarromTable',10*[-1;1],...
    'ChenV',[-500;500],...
    'ChenBird',[-500;500],...
    'Chichinadze',[-30;30],...
    'ChungReynolds',[-100;100],...
    'Cigar',100*[-1;1],...
    'Cola',[0,-4*ones(1,16);4*ones(1,17)],...
    'Colville',[-10;10],...
    'Corana',[-500;500],...
    'CosineMixture',[-1;1],...
    'CrossInTray',[-10;10],...
    'CrossLegTable',10*[-1;1],...
    'CrownedCross',10*[-1;1],...
    'Csendes',[-1;1],...
    'Cube',[-10;10],...
    'Custom01',[-1;15],...
    'Custom02',[-1;15],...
    'Custom03',[-1;15],...
    'Custom04',[-1;15],...
    'Custom05',[-1;15],...
    'Damavandi',[0;14],...
    'Deb1',[-1;1],...
    'Deb2',[-1;1],...
    'Deb3',[0;1],...
    'Deb4',[0;1],...
    'Decanomial',10*[-1;1],...
    'Deceptive',[0;1],...
    'DeckkersAarts',[-20;20],...
    'DeflectedCorrugatedSpring',[0;10],...
    'DeVilliersGlasser1',[1;100],... %[-500;500],...
    'DeVilliersGlasser2',[1;60],... %[-500;500],...
    'DixonPrice',[-10;10],...
    'Dolan',[-10;10],...
    'DropWave',5.12*[-1;1],...
    'Easom',[-100;100],...
    'ElAttarVidyasogarDutta',[-500;500],...
    'EggCrate',[-5;5],...
    'EggHolder',[-512;512],...
    'Exponential',[-1;1],...
    'EX1',[0;12],...
    'Exp2',[0;20],...
    'Exp3',[0;20],...
    'Exp4',[0;20],...
    'Exp5',[0;20],...
    'Exp6',[0;20],...
    'FreudensteinRoth',[-10;10],...
    'Gear',[12;60],...
    'Giunta',[-1;1],...
    'GoldsteinPrice',[-2;2],...
    'Griewank',[-100;100],...
    'GulfResearch',[0;60],...
    'Hansen',[-10;10],...
    'Hartmann3',[0;1],...
    'Hartmann6',[0;1],...
    'HelicalValley',[-10;10],...
    'Himmelblau',[-5;5],...
    'Holzman',[0 0 0;100 25.6 5],...
    'Hosaki',[0;5],...
    'Infiniti',[-1;1],...
    'JennrichSampson',[-1;1],...[-1;0.4]
    'Judge',2*[-1;1],...
    'Katsuura',[0;100],...
    'Kowalik',5*[-1;1],...
    'Langermann52',[-5;10],...
    'Langermann5',[-5;10],...
    'Keane',[0;10],...
    'Leon',[-1.2;1.2],...
    'Levy03',10*[-1;1],... %5
    'Levy05',10*[-1;1],... %2
    'Levy13',10*[-1;1],... %5
    'Matyas',[-10;10],...
    'McCormick',[-1.5,-3;4,3],...
    'MieleCantrell',[-1;1],...
    'Mishra01',[0;1],...
    'Mishra02',[0;1],...
    'Mishra03',[-10;10],...
    'Mishra04',[-10;10],...
    'Mishra05',[-10;10],...
    'Mishra06',[-10;10],...
    'Mishra07',[-10;10],...
    'Mishra08',[-10;10],...
    'Mishra09',[-10;10],...
    'Mishra10',[-10;10],...
    'Mishra11',[-10;10],...
    'NeedleEye',10*[-1;1],...
    'NewFunction1',10*[-1;1],...
    'NewFunction2',10*[-1;1],...
    'NewFunction3',10*[-1;1],...
    'OddSquare',5*pi*[-1;1],... %5pi
    'Parsopoulos',[-5;5],...
    'Pathological',100*[-1;1],...
    'PenHolder',[-11;11],...
    'Paviani',[2.0001;10],...
    'Penalty1',4*[-1;1],...%4
    'Penalty2',4*[-1;1],...%4
    'Periodic',10*[-1;1],...
    'Pinter',10*[-1;1],...
    'Plateau',5.12*[-1;1],...
    'Price1',500*[-1;1],...
    'Price2',[-10;10],...
    'Price3',500*[-1;1],...
    'Price4',500*[-1;1],...
    'Powell',[-4;5],...
    'PowerSum',[0;4],...
    'Qing',500*[-1;1],...
    'Quadratic',[-10;10],...
    'Quartic',[-1.28;1.28],...
    'Quintic',[-10;10],...
    'Rana',[-500;500],...
    'Rastrigin',[-5.12;5.12],...
    'Ripple01',[0;1],...
    'Ripple25',[0;1],...
    'Rosenbrock',[-30;30],...
    'RosenbrockM',[-2;2],...
    'RosenbrockMS',[-2.048;2.048],...
    'RotatedEllipse1',[-500;500],...
    'RotatedEllipse2',[-500;500],...
    'Rump',[-500;500],...
    'Salomon',100*[-1;1],...
    'Sargan',100*[-1;1],...
    'Schaffer1',10*[-1;1],...
    'Schaffer2',10*[-1;1],...
    'Schaffer3',10*[-1;1],...
    'Schaffer4',10*[-1;1],...
    'Schaffer6',10*[-1;1],...
    'SchmidtVetters',[0;10],...
    'Schwefel01',100*[-1;1],...
    'Schwefel02',100*[-1;1],...
    'Schwefel04',[0;10],...
    'Schwefel06',100*[-1;1],...
    'Schwefel20',100*[-1;1],...
    'Schwefel21',100*[-1;1],...
    'Schwefel22',100*[-1;1],...
    'Schwefel23',10*[-1;1],...
    'Schwefel25',[-10;10],...
    'Schwefel26',500*[-1;1],...
    'Schwefel36',[0;500],...
    'Shekel05',[0;10],...
    'Shekel07',[0;10],...
    'Shekel10',[0;10],...
    'Shubert1',10*[-1;1],...
    'Shubert3',10*[-1;1],...
    'Shubert4',10*[-1;1],...
    'SineEnveloppe',20*[-1;1],...
    'Sodp',[-1;1],...
    'Sphere',[-1;1],...
    'Step',5*[-1;1],...
    'Step1',5*[-1;1],...
    'Step2',5*[-1;1],...
    'Step3',5*[-1;1],...
    'StepInt',5*[-1;1],...
    'Stochastic',5*[-1;1],...
    'StretchedV',100*[-1;1],...
    'StyblinskiTang',5*[-1;1],...
    'Treccani',10*[-1;1],...
    'Trefethen',10*[-1;1],...
    'Trid',20*[-1;1],...
    'Trigonometric1',[0;pi],...
    'Trigonometric2',500*[-1;1],... %[0;2],...
    'Tripod',100*[-1;1],...
    'TubeHolder',5*[-1;1],...
    'Ursem1',[-2.5 -2;2 2],...
    'Ursem3',[-2 -1.5;2 1.5],...
    'Ursem4',[-2;2],...
    'UrsemWaves',[-0.9 -1.2;1.2 1.2],...
    'VenterSobiezcczanskiSobieski',50*[-1;1],...
    'Vincent',[0.25;10],...
    'Watson',5*[-1;1],...
    'Wavy',pi*[-1;1],...
    'WayburnSeader1',5*[-1;1],...
    'WayburnSeader2',500*[-1;1],...
    'Weierstrass',1/2*[-1;1],...
    'Weibull',100*[-1;1],...
    'Whitley',2*[-1;1],...
    'Wolfe',[0;2],...
    'XinSheYang1',5*[-1;1],...
    'XinSheYang2',2*pi*[-1;1],...
    'XinSheYang3',20*[-1;1],...
    'XinSheYang4',10*[-1;1],...
    'Xor',9*[-1;1],...
    'YaoLiu4',10*[-1;1],...
    'YaoLiu9',5.12*[-1;1],...
    'Zacharov',[-5;10],...
    'ZeroSum',10*[-1;1],...
    'Zettl',[-1;5],...
    'Zimmerman',[0;100],...
    'Zirilli',10*[-1;1]);


spaceL=listSpace.(funName);
if size(spaceL,2)==1
    xMin=ones(1,dim)*spaceL(1);
    xMax=ones(1,dim)*spaceL(2);
else
    xMin=spaceL(1,:);
    xMax=spaceL(2,:);
end
end