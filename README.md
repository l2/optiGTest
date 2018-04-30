optiGTest 
=======
optiGTest is a MATLAB's toolbox which regroups many existing test functions used for studying the performance of approximation techniques and optimization strategy. In particular, gradient of the test functions are provided.

Features
------
optiGTest is able to 

* Provide derivatives of the test functions
* Dealing with any dimension chosen by the user
* Provide global minimum (value and associated set of parameters)

First start
------
* unConstrained problems: `Example_unConstrained.m`

List of functions [(see the 3D plot of the 2-dimensional functions)](https://bitbucket.org/luclaurent/optigtest/wiki/unConstrained)
------
|-|-|-|
|-----|-----|-----|
| Ackley1| DixonPrice| Quintic|
| Ackley2| Dolan| Rastrigin|
| Ackley3| DropWave| RHE|
| Ackley4| Easom| Ripple01|
| Adjiman| ElAttarVidyasogarDutta| Ripple25|
| Alpine1| EggCrate| Rosenbrock|
| Alpine2| EggHolder| RosenbrockM|
| AHE| Exponential| RosenbrockMS|
| AMGM| EX1| RotatedEllipse1|
| BartelsConn| Exp2| RotatedEllipse2|
| Beale| Exp3| Rump|
| BiggsExp2| Exp4| Salomon|
| BiggsExp3| Exp5| Sargan|
| BiggsExp4| Exp6| Schaffer1|
| BiggsExp5| FreudensteinRoth| Schaffer2|
| BiggsExp6| Gear| Schaffer3|
| Bird| Giunta| Schaffer4|
| Bohachevsky1| GoldsteinPrice| Schaffer6|
| Bohachevsky2| Griewank| SchmidtVetters|
| Bohachevsky3| GulfResearch| Schwefel01|
| Booth| Hansen| Schwefel02|
| BoxBetts| Hartmann3| Schwefel04|
| Brad| Hartmann6| Schwefel06|
| Branin1| HelicalValley| Schwefel20|
| Branin2| Himmelblau| Schwefel21|
| Brent| Holzman| Schwefel22|
| Brown| Hosaki| Schwefel23|
| Bukin01| Infiniti| Schwefel25|
| Bukin02| JennrichSampson| Schwefel26|
| Bukin03| Judge| Schwefel36|
| Bukin04| Katsuura| Shekel05|
| Bukin05| Keane| Shekel07|
| Bukin06| Kowalik| Shekel10|
| Bukin07| Langermann52| Shubert1|
| Bukin08| Langermann5| Shubert3|
| Bukin09| Leon| Shubert4|
| Bukin10| Levy03| SineEnveloppe|
| Bukin11| Levy05| Sodp|
| Bukin12| Levy13| Slope|
| Bukin13| Matyas| Sphere|
| Bukin14| McCormick| Step|
| Bukin15| Michalewicz| Step1|
| Bukin16| MieleCantrell| Step2|
| Bukin17| Mishra01| Step3|
| Bukin18| Mishra02| StepInt|
| Bukin19| Mishra03| Stochastic|
| Bukin20| Mishra04| StretchedV|
| CamelbackThreeHump| Mishra05| StyblinskiTang|
| CamelbackSixHump| Mishra06| SumSquare|
| CarromTable| Mishra07| Treccani|
| ChenV| Mishra08| Trefethen|
| ChenBird| Mishra09| Trid|
| Chichinadze| Mishra10| Trigonometric1|
| ChungReynolds| Mishra11| Trigonometric2|
| Cigar| Mystery| Tripod|
| Cola| NeedleEye| TubeHolder|
| Colville| NewFunction1| Ursem1|
| Corana| NewFunction2| Ursem3|
| CosineMixture| NewFunction3| Ursem4|
| CrossInTray| Null| UrsemWaves|
| CrossLegTable| OddSquare| VenterSobiezcczanskiSobieski|
| CrownedCross| Parsopoulos| Vincent|
| Csendes| Pathological| Watson|
| Cst| Paviani| Wavy|
| Cube| Peaks| WayburnSeader1|
| Custom01| PeaksN| WayburnSeader2|
| Custom02| Penalty1| Weibull|
| Custom03| Penalty2| Weierstrass|
| Custom04| PenHolder| Whitley|
| Custom05| Periodic| Wolfe|
| Damavandi| Pinter| XinSheYang1|
| Deb1| Plateau| XinSheYang2|
| Deb2| Powell| XinSheYang3|
| Deb3| PowerSum| XinSheYang4|
| Deb4| Price1| Xor|
| Decanomial| Price2| YaoLiu4|
| Deceptive| Price3| YaoLiu9|
| DeckkersAarts| Price4| Zacharov|
| DeflectedCorrugatedSpring| Qing| Zettl|
| DeVilliersGlasser1| Quadratic| Zimmerman|
| DeVilliersGlasser2| Quartic| Zirilli|

Download
------

The toolbox can be downloaded [here](https://bitbucket.org/luclaurent/optitest/downloads).

If you use `git`, you can clone the repository using the following command

    git clone git@bitbucket.org:luclaurent/optiGtest.git optiGTest







References
----
This toolbox is inspired by many existing codes and papers

* [AMPGO](http://infinity77.net/global_optimization/index.html) (and [github repository](https://github.com/andyfaff/ampgo/))
* E. P. Adorio and U. P. Diliman. [MVF - Multivariate Test Functions Library in C for Unconstrained Global Optimization.](https://www.google.fr/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwi2j_iz8sbTAhWG0hoKHfYLAncQFggnMAA&url=http%3A%2F%2Fwww.geocities.ws%2Feadorio%2Fmvf.pdf&usg=AFQjCNE7AMN9NpxLz2UGDInWKcwMeC120g&sig2=trbG1un24A4RfYCPdifjuA)
* P. N. Suganthan, N. Hansen, J. J. Liang, K. Deb, Y. P. Chen, A. Auger and S. Tiwari. Problem definitions and evaluation criteria for the CEC 2005 special session on real-parameter optimization. KanGAL report, 2005.[Link](https://www.lri.fr/~hansen/Tech-Report-May-30-05.pdf)
* V. Bicik, Continuous optimization algorithms, Master thesis, Czech Technical University in Prague, 2010 [Link](https://dip.felk.cvut.cz/browse/pdfcache/bicikvla_2010dipl.pdf)
* M. Jamil and Xin-She Yang, A literature survey of benchmark functions for global optimization problems, *Int. Journal of Mathematical Modelling and Numerical Optimisation*, Vol. 4, No. 2, pp. 150--194 (2013) doi: [10.1504/IJMMNO.2013.055204](http://dx.doi.org/10.1504/IJMMNO.2013.055204) arXiv: [1308.4008](https://arxiv.org/abs/1308.4008) [PDF](https://arxiv.org/pdf/1308.4008.pdf)
* M. Molga, C. Smutnick. Test functions for optimization needs, *Comput. Inform. Sci.*, 1-43, 2005. [Link](http://new.zsd.iiar.pwr.wroc.pl/files/docs/functions.pdf)
* M. M. Ali, C. Khompatraporn and Z. B. Zabinsky, *Journal of Global Optimisation* (2005) 31:635. doi: [10.1007/s10898-004-9972-2](http://dx.doi.org/10.1007/s10898-004-9972-2) [PDF](http://folk.uib.no/ssu029/Pdf_file/Ali05.pdf)
* [Virtual Library of Simulation Experiments](https://www.sfu.ca/~ssurjano/other.html)

License ![GNU GPLv3](http://www.gnu.org/graphics/gplv3-88x31.png)
----

    optiGTest - set of testing functions    A toolbox to easy manipulate functions.
    Copyright (C) 2017  Luc LAURENT <luc.laurent@lecnam.net>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.