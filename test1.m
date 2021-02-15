clear; close all; clc
format compact

workDir = cd;

ctrl.workDir = workDir;
ctrl.targetDir = 'delmeRuns';

centerlineSaveFile = 'centerline.mat';
freespans =    [0.75
                0.71
                0.9
                0.73
                0.85
                0.88
                0.85
                1.12
                0.96];

folderNames = subdirImport(workDir,'dir');
selIdx = contains(folderNames,'MX');
folderNames = folderNames(selIdx);

options = optimset('Display','none','tolx',10000);
for aLoop = 1:numel(folderNames)
    filesInDir = subdirImport([workDir filesep folderNames{aLoop} filesep],'regex','_10ums-1.txt');
    A = importfile([workDir filesep folderNames{aLoop} filesep filesInDir{1}]);

%     figure;
%     subplot(1,3,1)
%     plot(A(:,1))
%     subplot(1,3,2)
%     plot(A(:,2))
%     subplot(1,3,3)
%     plot(A(:,3))

    % Modulus by analytical inversion under assumption of straightness.
    B = A;
%     B(:,3) = (B(:,3)-B(1,3))*1e-3/(freespans(aLoop)*1e-3);
    B(:,3) = (B(:,3))*1e-3/(freespans(aLoop)*1e-3);
    B(:,2) = B(:,2)/150e-12;
%     figure;
%     plot(B(:,3),B(:,2))
    ap = B(:,3);
    bp = B(:,2);
    polyvals = polyfit(ap,bp,1);
    modulusSave(aLoop,1) = polyvals(1);


    % Modulus by error minimization without assumption of straightness.
    
    % 1. Prepare the data: check if previous saved form exists, otherwise
    % proceed to generate it
    if not(exist([workDir filesep folderNames{aLoop} filesep centerlineSaveFile],'file'))
        fprintf('          -> No saved centerline found in %s . Starting extraction.\n',[workDir filesep folderNames{aLoop} filesep]);
        realCenterline = extractCenterlineFromImage([workDir filesep folderNames{aLoop} filesep],'_5x.png',freespans(aLoop),centerlineSaveFile);
    else
        fprintf('          -> Previously extracted centerline found in %s . Importing.\n',[workDir filesep folderNames{aLoop} filesep]);
        load([workDir filesep folderNames{aLoop} filesep centerlineSaveFile])
    end
    
%     realCenterline = realCenterline([1 end],:);
%     realCenterline(2,1) = realCenterline(1,1);
%     realCenterline(2,2) = -freespans(aLoop);
    % 2. Generate FEM model
    appendGeometryForANSYS(realCenterline(:,1)*1e3,realCenterline(:,2)*1e3,zeros(size(realCenterline,1),1),50,3);
    x0 = modulusSave(aLoop,1);
    costFcn = @(x) simulateBeam(x,ctrl,(A(:,3)-A(1,3))*1e-3,A(:,2));
    
    
%     x = fminsearch(costFcn,x0)
    x = fminbnd(costFcn,2*1e9,150*1e9,options);
    
    modulusSave(aLoop,2) = x;
    title(sprintf('End modulus: %4.2f GPa, %4.2f GPa (inv./err.-min.)',modulusSave(aLoop,1)*1e-9,modulusSave(aLoop,2)*1e-9))
    fprintf('End modulus: %4.2f GPa, %4.2f GPa (inv./err.-min.)\n',modulusSave(aLoop,1)*1e-9,modulusSave(aLoop,2)*1e-9)
    figure
end


figure;

boxplot(modulusSave./1e9)
ylabel('modulus estimate, GPa')



















% Preprocessing
% C = imread('MX01/MX01_5x.png');
% imagesc(C)
% straightLine = drawline %[x y]
% roi = drawpolyline
% 
% freespanInPixels = sqrt(sum(sum(diff(straightLine.Position,1,1))).^2);
% freespan = freespans(1);
% mmPerPixel = freespan/freespanInPixels %% mm per pixel
% 
% realCenterline = roi.Position.*mmPerPixel;
% 
% sqrt(sum(sum(diff(realCenterline,                   1,1))).^2);
% sqrt(sum(sum(diff(straightLine.Position.*mmPerPixel,1,1))).^2);
% rox = drawassisted

% Write the center line.
% 
% 
% realCenterline = realCenterline - realCenterline(1,:);
% appendGeometryForANSYS(realCenterline(:,1)*1e3,realCenterline(:,2)*1e3,zeros(size(realCenterline,1),1),50,2)
% 






