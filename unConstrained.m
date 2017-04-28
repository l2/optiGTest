classdef unConstrained < handle
    
    properties
        funName='';
        xMin=[];
        xMax=[];
        dim=0;
        dimAvailable=0;
        locMinZ
        locMinX
        globMinZ
        globMinX
        Xeval
        nSCheck=5;
        forceDisplayGrad=false;
        paranoidCheck=false;    %strict check of function
        FDtype='CD8';
        FDstep=1e-7;
    end
    
    methods
        function obj=unConstrained(funName,XX,dim)
            addpath('unConstrained/');
            if nargin==0
                obj.checkAllfun();
            else
                obj.funName=funName;
                obj.dim=loadDim(funName);
            end
            if nargin==1
                obj.demo
                obj.checkFun(obj.funName);
            elseif nargin==2
                obj.prepX(XX);
                obj.eval()
            elseif nargin==3
                obj.dim=dim;
                obj.prepX(XX);
                obj.eval()
            end
        end
        %getters
        function Xmax=get.xMax(obj)
            [~,Xmax]=loadSpace(obj.funName,obj.dim);
        end
        function Xmin=get.xMin(obj)
            [Xmin,~]=loadSpace(obj.funName,obj.dim);
        end
        function Z=get.globMinZ(obj)
            [~,Z]=loadGlobMin(obj.funName,obj.dim);
            if size(Z,2)>obj.dim
                Z=Z(:,1:obj.dim);
            end
        end
        function X=get.globMinX(obj)
            [X,~]=loadGlobMin(obj.funName,obj.dim);
        end
        %setters
        function set.funName(obj,txt)
            %if the function is available we store it
            if availableFun(txt)
                obj.funName=txt;
                obj.loadDimAvailable;
            else
                fprintf('Test function %s unavailable \n',txt);
                dispAvailableFun();
            end
        end
        function set.dim(obj,val)
           if isinf(val)
               dimA=obj.getDimAvailable;
               [~,II]=min(abs(dimA-2));               
               obj.dim=dimA(II);
           else
               obj.dim=val;
           end
        end
        function loadDimAvailable(obj)
            obj.dimAvailable=loadDim(obj.funName);
        end
        function dimA=getDimAvailable(obj)
            dimA=obj.dimAvailable;
        end
        function Xeval=prepX(obj,XX)
            sX=[size(XX,1) size(XX,2) size(XX,3)];
            nbvar=sX(3);
            if any(isinf(obj.dimAvailable))
                if nbvar==1
                    obj.Xeval=reshape(XX,[],1,sX(2));
                else
                    obj.Xeval=XX;
                    obj.dim=nbvar;
                end
            else
                if nbvar==obj.dim
                    obj.Xeval=XX;
                elseif nbvar==1
                    if sX(2)==obj.dim
                        obj.Xeval=reshape(XX,[],1,sX(2));
                    else
                        fprintf(['Wrong size of sample points (' mfilename ')\n']);
                    end
                else
                    keyboard
                    fprintf(['Wrong size of sample points (' mfilename ')\n']);
                end
            end
            Xeval=obj.Xeval;
            if size(Xeval,3)<2;keyboard;end
        end
        function [ZZ,GZ,GZreshape]=eval(obj,XX)
            
            if nargin==1
                Xrun=obj.Xeval;
            else
                Xrun=obj.prepX(XX);
            end            
            if nargout>1
                [ZZ,GZ]=feval(['fun' obj.funName],Xrun);
            else
                [ZZ]=feval(['fun' obj.funName],Xrun);
            end
            if nargout>2
                GZreshape=reshape(GZ,[],size(GZ,3));
            end
        end
        %dem mode
        function demo(obj)
            if isinf(obj.dimAvailable);obj.dim=2;end
            if obj.dim==1
            elseif any(ismember(obj.dimAvailable,2))||isinf(obj.dimAvailable)
                obj.dim=2;
                stepM=51;
                [Xmin,Xmax]=loadSpace(obj.funName,2);
                xL=linspace(Xmin(1),Xmax(1),stepM);
                yL=linspace(Xmin(2),Xmax(2),stepM);
                [x,y]=meshgrid(xL,yL);
                xx=zeros(stepM,stepM,2);
                xx(:,:,1)=x;xx(:,:,2)=y;
                %evaluation of the function
                [ZZ,GZ]=obj.eval(xx);
                %display
                obj.show2D(x,y,ZZ,GZ);
            else
                fprintf(['Too large dimension to be plotted (' mfilename ')\n']);
            end
        end
        %check function by checking minimum
        function isOk=checkFun(obj,funName)
            lim=1e-5;
            limO=1e-4;
            %check minimum
            obj.funName=funName;
            %load dimension
            dimCheck=loadDim(funName);
            if isinf(dimCheck);dimCheck=5;end
            if numel(dimCheck)~=1;[~,II]=min(abs(dimCheck-5));dimCheck=dimCheck(II);end
            obj.dim=dimCheck;
            %
            isOk=true;
            X=obj.globMinX;
            if size(X,2)>obj.dim
                X=X(:,1:obj.dim);
            end
            ZZ=obj.eval(X);
            Z=obj.globMinZ;
            if all(abs(ZZ(:)-Z(:))>limO)
                fprintf('Issue with the %s function (wrong minimum obtained)\n',funName);
                fprintf('Obtained: ');fprintf('%d ',ZZ(:)');
                fprintf('\n');
                fprintf('Expected: ');fprintf('%d ',Z(:)');
                fprintf('\n');
                isOk=false;
            end
            %check derivatives           
            [XminSpace,XmaxSpace]=loadSpace(funName,dimCheck);
            %build sampling points
            if exist('lhsdesign','file')
                Xsample=lhsdesign(obj.nSCheck,dimCheck);
            else
                Xsample=rand(obj.nSCheck,dimCheck);
            end
            %rescale the samples
            Xsample=Xsample.*repmat(XmaxSpace-XminSpace,obj.nSCheck,1)+repmat(XminSpace,obj.nSCheck,1);
            %evaluate function at the sample
            obj.prepX(Xsample);
            [~,~,GZactual]=obj.eval();
            %compute approximate gradients using finite differences
            obj.funName=funName;
            FDfun=@(X)obj.eval(X);
            FDclass=diffGrad(obj.FDtype,Xsample,obj.FDstep,FDfun);
            GZapprox=FDclass.GZeval;
            %compare results
            diffG=abs((GZactual-GZapprox)./GZactual);
            if any(diffG(:)>lim)&&obj.paranoidCheck||sum(diffG(:)>lim)>floor(numel(diffG(:))/3)&&~obj.paranoidCheck
                
                fprintf('Issue with the gradients of the %s function\n',funName);
                isOk=false;
            end
            if any(diffG(:)>lim)||obj.forceDisplayGrad
                
                fprintf('Exact\n');
                for it=1:obj.nSCheck
                    fprintf('%+7.3e ',GZactual(it,:));
                    fprintf('\n');
                end
                fprintf('\n');
                fprintf('Finite Difference (%s, %7.3e)\n',obj.FDtype,obj.FDstep);
                for it=1:obj.nSCheck
                    fprintf('%+7.3e ',GZapprox(it,:));
                    fprintf('\n');
                end
                fprintf('\n');
                fprintf('Difference\n');
                for it=1:obj.nSCheck
                    fprintf('%+7.3e ',diffG(it,:));
                    fprintf('\n');
                end
                fprintf('\n');
                fprintf('Checking points\n');
                for it=1:obj.nSCheck
                    fprintf('%+7.3e ',Xsample(it,:));
                    fprintf('\n');
                end
            end
            if ~isOk
                pause
            end
        end
        %check all functions
        function isOk=checkAllfun(obj,flag)
            isOk=true;
            %extract name of functions
            strFun=loadDim();
            listFun=fieldnames(strFun);
            if flag==1 %check all by continuing at the current position
                currPos=find(ismember(listFun,obj.funName));
                currPos=currPos(1);
                listFun=listFun(currPos:end);
            end
            %check every function
            for itF=1:numel(listFun)
                fprintf(' >>> Function %s\n',listFun{itF});
                %keyboard
                tmpStatus=obj.checkFun(listFun{itF});
                isOk=isOk&&tmpStatus;
            end
        end
        %show 2D function
        function show2D(obj,XX,YY,ZZ,GZ)
            nbR=2;
            nbC=3;
            nbLevel=10;
            
            figure
            subplot(nbR,nbC,1)
            surf(XX,YY,ZZ);
            axis('tight','square')
            xlabel('x'), ylabel('y'), title(obj.funName)
            subplot(nbR,nbC,2)
            surf(XX,YY,GZ(:,:,1));
            axis('tight','square')
            xlabel('x'), ylabel('y'), title(['Grad. X ' obj.funName])
            subplot(nbR,nbC,3)
            surf(XX,YY,GZ(:,:,2));
            axis('tight','square')
            xlabel('x'), ylabel('y'), title(['Grad. Y ' obj.funName])
            %
            subplot(nbR,nbC,4)
            contourf(XX,YY,ZZ,nbLevel);
            axis('tight','square')
            xlabel('x'), ylabel('y'), title(obj.funName)
            subplot(nbR,nbC,5)
            contourf(XX,YY,GZ(:,:,1),nbLevel);
            axis('tight','square')
            xlabel('x'), ylabel('y'), title(['Grad. X ' obj.funName])
            subplot(nbR,nbC,6)
            contourf(XX,YY,GZ(:,:,2),nbLevel);
            axis('tight','square')
            xlabel('x'), ylabel('y'), title(['Grad. Y ' obj.funName])
        end
    end
    
end


%function for checking if the function is available
function funOk=availableFun(txt)
%extract name of functions
strFun=loadDim();
listFun=fieldnames(strFun);
%check if function is available
funOk=any(ismember(listFun,txt));
end

%display available testfunctions
function funOk=dispAvailableFun()
%extract name of functions
strFun=loadDim();
listFun=fieldnames(strFun);
%check if function is available
fprintf('=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=\n');
fprintf('Available test functions\n');
cellfun(@(X)fprintf('%s\n',X),listFun);
fprintf('=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=\n');
end

%load dimension
function dim=loadDim(funName)
listDim=struct(...
    'AMGM',Inf,...
    'Brown',Inf,...
    'Bukin01',2,...
    'Bukin02',2,...
    'Bukin03',2,...
    'Bukin04',2,...
    'Bukin05',2,...
    'Bukin06',2,...
    'Bukin07',2,...
    'Bukin08',2,...
    'Bukin09',2,...
    'Bukin10',2,...
    'Bukin11',2,...
    'Bukin12',2,...
    'Bukin13',2,...
    'Bukin14',2,...
    'Bukin15',2,...
    'Bukin16',2,...
    'Bukin17',2,...
    'Bukin18',2,...
    'Bukin19',2,...
    'Bukin20',2,...
    'CamelbackThreeHump',2,...
    'CamelbackSixHump',2,...
    'CarromTable',2,...
    'ChenV',2,...
    'ChenBird',2,...
    'Chichinadze',2,...
    'ChungReynolds',Inf,...
    'Cigar',Inf,...
    'Cola',17,...
    'Colville',4,...
    'Corana',4,...
    'CosineMixture',Inf,...
    'CrossInTray',2,...
    'CrossLegTable',2,...
    'CrownedCross',2,...
    'Csendes',Inf,...
    'Cube',2,...
    'Damavandi',2,...
    'Deb1',Inf,...
    'Deb2',Inf,...
    'Deb3',Inf,...
    'Deb4',Inf,...
    'Decanomial',2,...
    'Deceptive',Inf,...
    'DeckkersAarts',2,...
    'DeflectedCorrugatedSpring',Inf,...
    'DeVilliersGlasser1',4,...
    'DeVilliersGlasser2',5,...
    'DixonPrice',Inf,...
    'Dolan',5,...
    'DropWave',Inf,...
    'Easom',2,...
    'ElAttarVidyasogarDutta',2,...
    'EggCrate',2,...
    'EggHolder',Inf,...
    'Exponential',Inf,...
    'EX1',2,...
    'Exp2',2,...
    'Exp3',3,...
    'Exp4',4,...
    'Exp5',5,...
    'Exp6',6,...
    'FreudensteinRoth',2,...
    'Gear',4,...
    'Giunta',Inf,...
    'GoldsteinPrice',2,...
    'Griewank',Inf,...
    'GulfResearch',3,...
    'Hansen',2,...
    'Hartmann3',3,...
    'Hartmann6',6,...
    'HelicalValley',3,...
    'Himmelblau',2,...
    'Holzman',3,...
    'Hosaki',2,...
    'Infiniti',Inf,...
    'JennrichSampson',2,...
    'Judge',2,...
    'Katsuura',Inf,...
    'Keane',2,...
    'Kowalik',4,...
    'Langermann52',2,...
    'Langermann5',Inf,... %'LennardJones',Inf,...
    'Leon',2,...
    'Levy03',Inf,...
    'Levy05',2,...
    'Levy13',2,...
    'Matyas',2,...
    'McCormick',2,...
    'MieleCantrell',4,...
    'Mishra01',Inf,...
    'Mishra02',Inf,...
    'Mishra03',2,...
    'Mishra04',2,...
    'Mishra05',2,...
    'Mishra06',2,...
    'Mishra07',Inf,...
    'Mishra08',2,...
    'Mishra09',3,...
    'Mishra10',2,...
    'Mishra11',Inf,...
    'NeedleEye',Inf,...
    'NewFunction1',2,...
    'NewFunction2',2,...
    'NewFunction3',2,...
    'OddSquare',1:20,...
    'Parsopoulos',2,...
    'Pathological',Inf,...
    'Paviani',10,...
    'Penalty1',Inf,...
    'Penalty2',Inf,...
    'PenHolder',2,...
    'Periodic',2,...
    'Pinter',Inf,...
    'Plateau',Inf,...
    'Powell',4,...
    'PowerSum',4,...
    'Price1',2,...
    'Price2',2,...
    'Price3',2,...
    'Price4',2,...
    'Qing',Inf,...
    'Quadratic',2,...
    'Quartic',Inf,...
    'Quintic',Inf,... %'Rana',Inf,...
    'Rastrigin',Inf,...
    'Ripple01',2,...
    'Ripple25',2,...
    'Rosenbrock',Inf,...
    'RosenbrockM',2,...
    'RosenbrockMS',Inf,...
    'RotatedEllipse1',2,...
    'RotatedEllipse2',2,...
    'Rump',2,...
    'Salomon',Inf,...
    'Sargan',Inf,...
    'Schaffer1',2,...
    'Schaffer2',2,...
    'Schaffer3',2,...
    'Schaffer4',2,...
    'Schaffer6',Inf,...
    'SchmidtVetters',3,...
    'Schwefel01',Inf,...
    'Schwefel02',Inf,...
    'Schwefel04',Inf,...
    'Schwefel06',2,...
    'Schwefel20',Inf,...
    'Schwefel21',Inf,...
    'Schwefel22',Inf,...
    'Schwefel23',Inf,...
    'Schwefel25',Inf,...
    'Schwefel26',Inf,...
    'Schwefel36',2,...
    'Shekel05',4,...
    'Shekel07',4,...
    'Shekel10',4,...
    'Shubert1',2,...
    'Shubert3',Inf,...
    'Shubert4',Inf,...
    'SineEnveloppe',Inf,...
    'Sodp',Inf,...
    'Sphere',Inf,...
    'Step',Inf,...
    'Stochastic',Inf,...
    'StretchedV',Inf,...
    'StyblinskiTang',Inf,...
    'Treccani',2,...
    'Trefethen',2,...
    'Trid',6,...
    'Trigonometric1',Inf,...
    'Trigonometric2',Inf,...
    'Tripod',2,...
    'TubeHolder',2,...
    'Ursem1',2,...
    'Ursem3',2,...
    'Ursem4',2,...
    'UrsemWaves',2,...
    'VenterSobiezcczanskiSobieski',2,...
    'Vincent',Inf,...
    'Watson',6,...
    'Wavy',Inf,...
    'WayburnSeader1',2,...
    'WayburnSeader2',2,...
    'Weibull',3,...
    'Weierstrass',Inf,...
    'Whitley',Inf,...
    'Wolfe',3,...
    'XinSheYang1',Inf,...
    'XinSheYang2',Inf,...
    'XinSheYang3',Inf,...
    'XinSheYang4',Inf,...
    'Xor',9,...
    'YaoLiu4',Inf,...
    'YaoLiu9',Inf,...
    'Zacharov',Inf,...%'ZeroSum',Inf,...
    'Zettl',2,...
    'Zimmerman',2,...
    'Zirilli',2,...
    'prout',5);
if nargin==1
    dim=listDim.(funName);
else
    dim=listDim;
end
end

%load global minima
function [GlobX,GlobZ]=loadGlobMin(funName,dim)
listGlobXmin=struct(...
    'AMGM',NaN,... % x1=x2=x3..=xn
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
    'Stochastic',1/dim*ones(1,dim),...
    'StretchedV',[9.38723188,9.34026754],...
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
    'Zirilli',[-1.0465 0],...
    'prout',0);

%%%%%%%
listGlobZmin=struct(...
    'AMGM',0,... %%
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
    'CrossInTray',ones(1,4)*(-2.06261218),...
    'CrossLegTable',-1,... x1=0 or x2=0
    'CrownedCross',1e-4,... x1=0 or x2=0
    'Csendes',0,...
    'Cube',0,...
    'Damavandi',0,...
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
    'Shekel07',-10.3999,...
    'Shekel10',-10.5319,...
    'Shubert1',-186.7309,...
    'Shubert3',-24.062499,...
    'Shubert4',-29.016015,...
    'SineEnveloppe',0,...
    'Sodp',0,...
    'Sphere',0,...
    'Step',0.5,...
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
    'Zirilli',-0.3523,...
    'prout',0);

lGX=listGlobXmin.(funName);
lGZ=listGlobZmin.(funName);

if size(lGX,2)==1
    GlobX=repmat(lGX,[1,dim]);
else
    GlobX=lGX;
end
if size(lGZ,2)==1&&size(lGX,1)>1
    GlobZ=repmat(lGZ,[size(lGX,1),1]);
else
    GlobZ=lGZ;
end

end

%load space definition
function [xMin,xMax]=loadSpace(funName,dim)
listSpace=struct(...
    'AMGM',[0;10],...
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
    'Zirilli',10*[-1;1],...
    'prout',[0;14]);


spaceL=listSpace.(funName);
if size(spaceL,2)==1
    xMin=ones(1,dim)*spaceL(1);
    xMax=ones(1,dim)*spaceL(2);
else
    xMin=spaceL(1,:);
    xMax=spaceL(2,:);
end
end

%function display table with two columns of text
function dispTableTwoColumns(tableA,tableB)
%size of every components in tableA
sizeA=cellfun(@numel,tableA);
maxA=max(sizeA);
%space after each component
spaceA=maxA-sizeA+3;
spaceTxt=' ';
%display table
for itT=1:numel(tableA)
    Gfprintf('%s%s%s\n',tableA{itT},spaceTxt(ones(1,spaceA(itT))),tableB{itT});
end
end


