function costOutput = simulateBeam(x,ctrl,ap,bp)
%simulateBeam(singleSim,ctrl) constructs a small beam model representation
%of a single fiber and executes the simulation locally. It usesthe length 
%and cross section of the deformed fiber, and an estimate of the
%elastic modulus which needs to be calculated beforehand.
%
% INPUT:    - singleSim : A single structure containing the information
%                         extracted from the volumetric simulation.
%           - ctrl      : A control structure containing misc. information
%                         used for program flow control.
%
% OUTPUT:   none.
%
% REMARKS:
%
% TO DO:
%           - Euler vs Timoshenko beam.
%
% created by: August Brandberg
% DATE: 05-01-2018
%

% Import the simulation file "skeleton"
part1 = importAnsysSnippet(horzcat(ctrl.workDir,filesep,'beamModelPart_1'));
part2 = importAnsysSnippet(horzcat(ctrl.workDir,filesep,'beamModelPart_2'));



% Import parameters
%   - LFib              : Length of fiber
%   - EZ                : Young's modulus
%   - crossSectionFile  : Cross section exported from the volumetric
%                         simulation (see further, ANSYS Help, keyword
%                         SECREAD/SECWRITE).
%   - GYZST             : User supplied shear stiffness (see further ANSYS
%                         Help keyword "SECCONTROL".
EZ = x/10^6;

% Generate parameter strings
EZ_Code    =  ['EZ = ',num2str(EZ)];  
ANSYSInputFile = 'beamSim.dat';
nameString = 'beamSim';


% Print to file (this is the part that creates ANSYS input files
fileID = fopen(ANSYSInputFile,'w');
fprintf(fileID,'%s\n',part1,EZ_Code,part2);
fclose(fileID);


% Move the resulting file into its own directory
destinationString = strcat(ctrl.targetDir,filesep,nameString);

if not(exist(destinationString,'dir'))
    mkdir(destinationString)
    pause(1)
end
movefile(ANSYSInputFile,strcat(destinationString,filesep,ANSYSInputFile ))
copyfile('test44.txt',strcat(destinationString,filesep,'test44.txt' ))

% Import and return value

% File and folder names and paths
simLoc = destinationString;
simName = 'beamSim';


% Specify ANSYS call according to your installation
ansysExecPath = '"C:\Program Files\ANSYS Inc\v202\ansys\bin\winx64\MAPDL.exe"';
ansysLic      = '-p aa_t_a';
ansysNP       = '-np 1';
ansysMisc     = '-s read -l en-us -b';
ansysJobname  = ['-j ' simName];
ansysRunDir   = ['-dir ' simLoc];
ansysInput    = ['-i ' simLoc filesep simName '.dat'];
ansysOutput   = ['-o ' simLoc filesep simName '.out'];

submitLine = strjoin({ansysExecPath , ansysLic , ansysNP , ansysMisc , ansysJobname , ansysRunDir , ansysInput , ansysOutput},' ');

% cd(simLoc)
system(submitLine);
% cd(ctrl.workDir)

A = importFEMTensileTest([simLoc filesep 'tensileTest.csv']);
delete([simLoc filesep 'tensileTest.csv'])
% Start by fitting the experimental data to something

% coeffs = polyfit(ap,bp-bp(1),1);
coeffs = polyfit(ap,bp-bp(1),1);
% evaluatedFit = polyval(coeffs,-1*1e-6*A(1:round(length(A(:,5))),8));
evaluatedFit = polyval(coeffs,-1*1e-6*A(:,8));


% Then resample


% newExperimentalCurveY = interp1(ap,bp-bp(1),-1*1e-6*A(:,8));


% figure;
% subplot(1,2,1)
plot(ap,bp-bp(1),'b')
hold on
plot(-1*1e-6*A(:,8),evaluatedFit,'k','linewidth',2)
% subplot(1,2,2)
plot(-1*1e-6*A(:,8),A(:,5)*1e-6,'r')
pause(0.25)


yexp = evaluatedFit;%(1:round(length(evaluatedFit)));
ymod = A(1:round(length(evaluatedFit)),5)*1e-6;

% costOutput = sqrt(1 /(length(evaluatedFit)+1) * sum( ( (-1*1e-6*A(:,8)) - evaluatedFit).^2./evaluatedFit.^2 ) );
% costOutput = sqrt(1 /(length(evaluatedFit)+1) * sum( ( A(:,5)*1e-6 - evaluatedFit).^2) );

costOutput = sqrt(1 /(length(evaluatedFit)+1) * sum( ( ymod - yexp).^2./yexp.^2 ) );


% disp('x')




