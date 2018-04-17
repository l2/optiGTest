%% function for loading global minimum(s) of available functions
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

function [GlobX,GlobZ]=loadGlobMin(funName,dim)
listGlobXmin=struct(...
    'Ackley1',zeros(1,dim),...
    'Ackley2',[0,0],...
    'Ackley3',[0,0.5117],...
    'Ackley4',[-1.479252,-0.739807;1.479252,-0.739807],...
    'Adjiman',[2, 0.10578],...
    'Alpine1',zeros(1,dim),...
    'Alpine2',7.917.*ones(1,dim),...
    'AHE',zeros(1,dim),...
    'AMGM',NaN,... % x1=x2=x3..=xn
    'Brad',[0.0824, 1.133, 2.3437],...
    'Brown',0,...
    'Bukin01',[1,-1;-1,1],...
    'Bukin02',[-10,0],...
    'Bukin03',[-1.5*pi,0],...
    'Bukin04',[-10,0],...
    'Bukin05',[-10,0],...
    'Bukin06',[-10,1],...
    'Bukin07',[-5,5;142.574,-0.17535],...
    'Bukin08',[-20,-20],...
    'Bukin09',[-6,-3],...
    'Bukin10',[-7,-9;-9,-3],...
    'Bukin11',[-5,-5],...
    'Bukin12',[-5,-5],...
    'Bukin13',[-3,0.5],...
    'Bukin14',[-10,-1],...
    'Bukin15',[-10,25;10,-175],...
    'Bukin16',[-5,-5],...
    'Bukin17',[-5,-5;20,-30],...
    'Bukin18',[-5,-5;2.28916,-128.91566],...
    'Bukin19',[9,71;-8,54],...
    'Bukin20',[-2,-1],...
    'CamelbackThreeHump',[0,0],...
    'CamelbackSixHump',[-0.0898, 0.7126;0.0898,-0.7126],...
    'CarromTable',[9.646157266348881,9.646157266348881;...
    -9.646157266348881,9.646157266348881;...
    9.646157266348881,-9.646157266348881;...
    -9.646157266348881,-9.646157266348881],...
    'ChenV',[7/18,13/18],...
    'ChenBird',[1/2,1/2;-1/2,-1/2],...
    'Chichinadze',[6.189866586965680,0.5],...
    'ChungReynolds',0,...
    'Cigar',zeros(1,dim),...
    'Cola',[0.651906,1.30194,0.099242,-0.883791,...
    -0.8796,0.204651,-3.28414,0.851188,-3.46245,...
    2.53245,-0.895246,0.204651,-3.28414,0.851188,...
    -3.46245,2.53245,-0.895246,1.40992,-3.07367,...
    1.96257,-2.97872,-0.807849,-1.68978],...
    'Colville',[1,1,1,1],...
    'Corana',[0,0,0,0],...
    'CosineMixture',0,...
    'CrossInTray',[1.349406685353340,1.349406608602084;...
    -1.349406685353340,1.349406608602084;...
    1.349406685353340,-1.349406608602084;...
    -1.349406685353340,-1.349406608602084],...
    'CrossLegTable',NaN,... x1=0 or x2=0
    'CrownedCross',NaN,... x1=0 or x2=0
    'Csendes',0,...
    'Cube',[1,1],...
    'Custom01',[pi;3*pi],...
    'Custom02',2.90844,...
    'Custom03',(1:2:17)'*pi/4,...
    'Custom04',0,...
    'Custom05',-0.636071,...
    'Damavandi',[2,2],...
    'Deb1',NaN,...
    'Deb2',NaN,...
    'Deb3',NaN,...
    'Deb4',NaN,...
    'Decanomial',[2,-3],...
    'Deceptive',(1:dim)./(dim+1),...
    'DeckkersAarts',[0,-15;0,15],...
    'DeflectedCorrugatedSpring',5*ones(1,dim),...
    'DeVilliersGlasser1',NaN,...
    'DeVilliersGlasser2',NaN,...
    'DixonPrice',2.^(-(2.^(1:dim)-2)./2.^(1:dim)),...
    'Dolan', [8.39045925, 4.81424707, 7.34574133, 68.88246895, 3.85470806],...
    'DropWave',zeros(1,dim),...
    'Easom',[pi pi],...
    'ElAttarVidyasogarDutta',[3.40918683, -2.17143304],...
    'EggCrate',[0,0],...
    'EggHolder',[512.0, 404.2319],...
    'Exponential',0,...
    'EX1',[1.764,11.15],...
    'Exp2',[1,10],...
    'Exp3',[1,10,5],...
    'Exp4',[1,10,1,5],...
    'Exp5',[1,10,1,5,4],...
    'Exp6',[1,10,1,5,4,3],...
    'FreudensteinRoth',[5,4],...
    'Gear',[16,19,43,49],...
    'Giunta',[0.4673200277395354, 0.4673200169591304],...
    'GoldsteinPrice',[0,-1],...
    'Griewank',0,...
    'GulfResearch',[50,25,1.5],...
    'Hansen',[-7.589893,-7.708314;...
    -7.589893, -1.425128;...
    -7.589893, 4.858057;...
    -1.306708, -7.708314;...
    -1.306708, 4.858057;...
    4.976478, 4.858057;...
    4.976478, -1.425128;...
    4.976478, -7.708314],...
    'Hartmann3',[0.114614,0.555649,0.852547],...
    'Hartmann6',[0.20168952, 0.15001069, 0.47687398, 0.27533243, 0.31165162, 0.65730054],...
    'HelicalValley',[1,0,0],...
    'Himmelblau',[3,2],...
    'Holzman',[50 25 1.5],...
    'Hosaki',[4,2],...
    'Infiniti',zeros(1,dim),...
    'JennrichSampson',[0.257825,0.257825],...
    'Judge',[0.86479,1.2357],...
    'Katsuura',zeros(1,dim),...
    'Kowalik',[0.192833,0.190836,0.123117,0.135766],...
    'Langermann52',NaN,...
    'Langermann5',NaN,...
    'Keane',[0,1.39325;1.39325,0],...
    'Leon',[1,1],...
    'Levy03',ones(1,dim),...
    'Levy05',[-1.3068,-1.4248],...
    'Levy13',ones(1,dim),...
    'Matyas',[0,0],...
    'McCormick',[-0.547,-1.547],...
    'MieleCantrell',[0,1,1,1],...
    'Mishra01',NaN,...
    'Mishra02',NaN,...
    'Mishra03',[-8.4667,-10],... %[-8.466,-10],...
    'Mishra04',[-9.94112, -9.99952],... %[-9.84112,-10],...
    'Mishra05',[-1.98682,-10],...
    'Mishra06',[2.94777, 1.82174],... %[2.88631, 1.82326],...
    'Mishra07',factorial(dim).*ones(1,dim),...
    'Mishra08',[2,-3],...
    'Mishra09',[1,2,3],...
    'Mishra10',[2,2],...
    'Mishra11',0,...
    'NeedleEye',zeros(1,dim),...
    'NewFunction1',[-8.4666,-9.9988],...
    'NewFunction2',[-9.94112,-9.99952],...
    'NewFunction3',[-1.9862,-10],...
    'OddSquare',[1, 1.3, 0.8, -0.4, -1.3, 1.6, -0.2, -0.6, 0.5, 1.4...
    1, 1.3, 0.8, -0.4, -1.3, 1.6, -0.2, -0.6, 0.5, 1.4],...
    'Parsopoulos',[pi/2,pi],...
    'Pathological',zeros(1,dim),...
    'PenHolder',[9.646167708023526, 9.646167671043401;
    -9.646167708023526, 9.646167671043401;
    9.646167708023526, -9.646167671043401;
    -9.646167708023526, -9.646167671043401],...
    'Paviani',9.351,...
    'Penalty1',-ones(1,dim),...
    'Penalty2',ones(1,dim),...
    'Periodic',[0,0],...
    'Pinter',zeros(1,dim),...
    'Plateau',zeros(1,dim),...
    'Powell',zeros(1,dim),...
    'PowerSum',[1,2,2,3],...
    'Price1',[-5,-5;-5,5;5,-5;5,5],...
    'Price2',[0;0],...
    'Price3',[1,1],...
    'Price4',[0,0;2,4;1.464,-2.506],...
    'Qing',sqrt(1:dim),...
    'Quadratic',[0.19388,0.48513],...
    'Quartic',0,...
    'Quintic',-1,...
    'Rana',-500*ones(1,dim),...
    'Rastrigin',zeros(1,dim),...
    'Ripple01',[0.1,0.1],...
    'Ripple25',[0.1,0.1],...
    'Rosenbrock',ones(1,dim),...
    'RosenbrockM',-[0.9,0.95],...
    'RosenbrockMS',NaN*ones(1,dim),...
    'RotatedEllipse1',zeros(1,dim),...
    'RotatedEllipse2',zeros(1,dim),...
    'Rump',zeros(1,dim),...
    'Salomon',zeros(1,dim),...
    'Sargan',zeros(1,dim),...
    'Schaffer1',zeros(1,dim),...
    'Schaffer2',zeros(1,dim),...
    'Schaffer3',[0,1.253115],...
    'Schaffer4',[0,1.253115],...
    'Schaffer6',zeros(1,dim),...
    'SchmidtVetters',[0.78547,0.78547,0.78547],...
    'Schwefel01',zeros(1,dim),...
    'Schwefel02',zeros(1,dim),...
    'Schwefel04',ones(1,dim),...
    'Schwefel06',[1,3],...
    'Schwefel20',zeros(1,dim),...
    'Schwefel21',zeros(1,dim),...
    'Schwefel22',zeros(1,dim),...
    'Schwefel23',zeros(1,dim),...
    'Schwefel25',ones(1,dim),...
    'Schwefel26',420.968746*ones(1,dim),...
    'Schwefel36',[12,12],...
    'Shekel05',[4,4,4,4],...
    'Shekel07',[4,4,4,4],...
    'Shekel10',[4,4,4,4],...
    'Shubert1',[-7.0835,4.8580],...
    'Shubert3',5.791794*[1,1],...
    'Shubert4',[-0.80032121,-7.08350592],...
    'SineEnveloppe',zeros(1,dim),...
    'Sodp',zeros(1,dim),...
    'Sphere',zeros(1,dim),...
    'Step',0.5*ones(1,dim),...
    'Step1',zeros(1,dim),...
    'Step2',-0.5*ones(1,dim),...
    'Step3',zeros(1,dim),...
    'StepInt',zeros(1,dim),...
    'Stochastic',1./(1:dim),...
    'StretchedV',zeros(1,dim),...
    'StyblinskiTang',-2.903534018185960*ones(1,dim),...
    'Treccani',[-2 0],...
    'Trefethen',[-.02440307923 0.2106124261],...
    'Trid',[6 10 12 12 10 6],...
    'Trigonometric1',zeros(1,dim),...
    'Trigonometric2',0.9*ones(1,dim),...
    'Tripod',[0,-50],...
    'TubeHolder',[pi/2,0],...
    'Ursem1',[1.69714,0],...
    'Ursem3',[0 0],...
    'Ursem4',[0 0],...
    'UrsemWaves',[1.2,1.2],...
    'VenterSobiezcczanskiSobieski',zeros(1,dim),...
    'Vincent',7.70628098*ones(1,dim),...
    'Watson',[-0.0158 1.012 -.2329 1.26 -1.513 0.9928],...
    'Wavy',zeros(1,dim),...
    'WayburnSeader1',[1 2],...
    'WayburnSeader2',[0.2 1],...
    'Weibull',[41.8923,1.32038,23.0365],...
    'Weierstrass',zeros(1,dim),...
    'Whitley',ones(1,dim),...
    'Wolfe',zeros(1,dim),...
    'XinSheYang1',zeros(1,dim),...
    'XinSheYang2',zeros(1,dim),...
    'XinSheYang3',zeros(1,dim),...
    'XinSheYang4',zeros(1,dim),...
    'Xor',[1 -1 1 -1 -1 1 1 -1 0.421134],...
    'YaoLiu4',zeros(1,dim),...
    'YaoLiu9',zeros(1,dim),...
    'Zacharov',zeros(1,dim),...
    'ZeroSum',@(x)sum(x)==0,...
    'Zettl',[-0.02896 0],...
    'Zimmerman',[7 2],...
    'Zirilli',[-1.0465 0]);

%%%%%%%
listGlobZmin=struct(...
    'Ackley1',0,...
    'Ackley2',-200,...
    'Ackley3',-234.8854,...
    'Ackley4',-3.917275,...
    'Adjiman',-2.02181,...
    'Alpine1',0,...
    'Alpine2',2.808^dim,...
    'AHE',0,...
    'AMGM',0,... %%
    'Brad', 0.00821487,...
    'Brown',0,...
    'Bukin01',[0;0],...
    'Bukin02',0,...
    'Bukin03',0,...
    'Bukin04',0,...
    'Bukin05',0,...
    'Bukin06',0,...
    'Bukin07',[0;0],...
    'Bukin08',0,...
    'Bukin09',0,...
    'Bukin10',[0;0],...
    'Bukin11',0,...
    'Bukin12',0,...
    'Bukin13',0,...
    'Bukin14',0,...
    'Bukin15',[0;0],...
    'Bukin16',0,...
    'Bukin17',[0;0],...
    'Bukin18',[0;0],...
    'Bukin19',[0;0],...
    'Bukin20',0,...
    'CamelbackThreeHump',0,...
    'CamelbackSixHump',[-1.0316;-1.0316],...
    'CarromTable',-24.15681551650653,...
    'ChenV',-2000,...
    'ChenBird',-2000.003999984,...
    'Chichinadze',-42.04996,...
    'ChungReynolds',0,...
    'Cigar',0,...
    'Cola',11.7464,...
    'Colville',0,...
    'Corana',0,...
    'CosineMixture',0.1*dim,...
    'CrossInTray',ones(4,1)*(-2.06261218),...
    'CrossLegTable',-1,... x1=0 or x2=0
    'CrownedCross',1e-4,... x1=0 or x2=0
    'Csendes',0,...
    'Cube',0,...
    'Custom01',ones(2,1)*5,...
    'Custom02',-0.436559,...
    'Custom03',-ones(9,1),...
    'Custom04',-1,...
    'Custom05',-1.12848,...
    'Damavandi',-1.12848,...
    'Deb1',NaN,...
    'Deb2',NaN,...
    'Deb3',NaN,...
    'Deb4',NaN,...
    'Decanomial',0,...
    'Deceptive',-1,...
    'DeckkersAarts',-2.477109375e+04,...
    'DeflectedCorrugatedSpring',-1,...
    'DeVilliersGlasser1',0,...
    'DeVilliersGlasser2',0,...
    'DixonPrice',0,...
    'Dolan',10^-5,...
    'DropWave',-1,...
    'Easom',-1,...
    'ElAttarVidyasogarDutta',1.712780354,...
    'EggCrate',0,...
    'EggHolder',-959.640662711,...
    'Exponential',-1,...
    'EX1',-1.28186,...
    'Exp2',0,...
    'Exp3',0,...
    'Exp4',0,...
    'Exp5',0,...
    'Exp6',0,...
    'FreudensteinRoth',0,...
    'Gear',2.7e-12,...
    'Giunta',0.06447042053690566,...
    'GoldsteinPrice',3,...
    'Griewank',0,...
    'GulfResearch',0,...
    'Hansen',-176.5418,...
    'Hartmann3',-3.86278214782076,...
    'Hartmann6',-3.32236801141551,...
    'HelicalValley',0,...
    'Himmelblau',0,...
    'Holzman',0,...
    'Hosaki',-2.3458,...
    'Infiniti',0,...
    'JennrichSampson',124.3622,...
    'Judge',16.0817307,...
    'Katsuura',1,...
    'Keane',0.673668,...
    'Kowalik',0.00030748610,...
    'Langermann52',-1.4,...
    'Langermann5',NaN,...
    'Leon',0,...
    'Levy03',0,...
    'Levy05',-176.1375,...
    'Levy13',0,...
    'Matyas',0,...
    'McCormick',-1.9133,...
    'MieleCantrell',0,...
    'Mishra01',0,...
    'Mishra02',0,...
    'Mishra03',-0.183578,... %-0.18467,...
    'Mishra04',-0.1971881,... %-0.199409,...
    'Mishra05',-0.119829,...
    'Mishra06',-2.675075970,... %-2.28395,...
    'Mishra07',0,...
    'Mishra08',0,...
    'Mishra09',0,...
    'Mishra10',0,...
    'Mishra11',0,...
    'NeedleEye',1,...
    'NewFunction1',-0.17894509347721144,...
    'NewFunction2',-0.1971881058905,...
    'NewFunction3',-1.019829,...
    'OddSquare',-1,... %-1.0084
    'Parsopoulos',0,...
    'Pathological',-(dim-1),...
    'PenHolder',-1.037845,...
    'Paviani',-45.77845,...
    'Penalty1',0,...
    'Penalty2',0,...
    'Periodic',0.9,...
    'Pinter',0,...
    'Plateau',30,...
    'Powell',0,...
    'PowerSum',0,...
    'Price1',0,...
    'Price2',0.9,...
    'Price3',0,...
    'Price4',0,...
    'Qing',0,...
    'Quadratic',-3873.724182183033,...
    'Quartic',NaN,...
    'Quintic',0,...
    'Rana',-928.5478,...
    'Rastrigin',0,...
    'Ripple01',-2.2,...
    'Ripple25',-2,...
    'Rosenbrock',0,...
    'RosenbrockM',34.37124,...
    'RosenbrockMS',NaN,...
    'RotatedEllipse1',0,...
    'RotatedEllipse2',0,...
    'Rump',0,...
    'Salomon',0,...
    'Sargan',0,...
    'Schaffer1',0,...
    'Schaffer2',0,...
    'Schaffer3',0.00123005,...
    'Schaffer4',0.2924385,...
    'Schaffer6',0,...
    'SchmidtVetters',2.99845,...
    'Schwefel01',0,...
    'Schwefel02',0,...
    'Schwefel04',0,...
    'Schwefel06',0,...
    'Schwefel20',0,...
    'Schwefel21',0,...
    'Schwefel22',0,...
    'Schwefel23',0,...
    'Schwefel25',0,...
    'Schwefel26',0,...
    'Schwefel36',-3456,...
    'Shekel05',-10.1527,...
    'Shekel07',-10.40282,...
    'Shekel10',-10.53628,...
    'Shubert1',-186.7309,...
    'Shubert3',-24.062499,...
    'Shubert4',-29.016015,...
    'SineEnveloppe',0,...
    'Sodp',0,...
    'Sphere',0,...
    'Step',dim*0.25,...
    'Step1',0,...
    'Step2',0,...
    'Step3',0,...
    'StepInt',25,...
    'Stochastic',0,...
    'StretchedV',0,...
    'StyblinskiTang',-39.16616570377142*dim,...
    'Treccani',0,...
    'Trefethen',-3.3068686474,...
    'Trid',-50,...
    'Trigonometric1',0,...
    'Trigonometric2',1,...
    'Tripod',0,...
    'TubeHolder',-10.872299901558,...
    'Ursem1',-4.8168,...
    'Ursem3',-3,...
    'Ursem4',-1.5,...
    'UrsemWaves',-8.5536,...
    'VenterSobiezcczanskiSobieski',-400,...
    'Vincent',-dim,...
    'Watson',0.002288,...
    'Wavy',0,...
    'WayburnSeader1',0,...
    'WayburnSeader2',0,...
    'Weibull',0.1692167,...
    'Weierstrass',0,...
    'Whitley',0,...
    'Wolfe',0,...
    'XinSheYang1',0,...
    'XinSheYang2',0,...
    'XinSheYang3',-1,...
    'XinSheYang4',-1,...
    'Xor',0.9597588,...
    'YaoLiu4',0,...
    'YaoLiu9',0,...
    'Zacharov',0,...
    'ZeroSum',0,...
    'Zettl',-0.0037912,...
    'Zimmerman',0,...
    'Zirilli',-0.3523);

lGX=listGlobXmin.(funName);
lGZ=listGlobZmin.(funName);

if size(lGX,2)==1
    GlobX=repmat(lGX,[1,dim]);
else
    GlobX=lGX;
end
if length(lGZ)==1&&size(lGX,1)>1
    GlobZ=repmat(lGZ,[size(lGX,1),1]);
else
    GlobZ=lGZ;
end
end