%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Single Fiber Testing: Postprocessing functions
%
%
% created by: August Brandberg augustbr at kth dot se
% date: 2021-03-22

% Setup
clear; close all; clc
format compact

% Control structure
ctrl.plotFlag = 1;
ctrl.workDir = 'C:\Users\augus\Downloads\DMA_MX_fiber (1)\';                             % Working directory.
ctrl.targetDir = 'delmeRuns';                   % Directory in which to build and solve FEM runs.
ctrl.centerlineSaveFile = 'centerline.mat';     % File name where previously extracted fiber centerline is stored.
ctrl.folderToImportSelector = 'MX'; 
ctrl.fileWithForceDisplacement = '_10ums-1.txt';
ctrl.machineCompliance = 0.0001266;             % [m/N]
ctrl.startIdx = 300;
ctrl.endIdx = 460;%400;%700;
ctrl.manualSeg = 0;
% Input data

                   %  NAME           FREESPAN           AREA   REAL LENGTH
sampleStaticData = {'MX01'      , 1e-3*[0.75], 1e-12*[377.34], nan ; 
                    'MX02'      , 1e-3*[0.71], 1e-12*[182.91], nan  ;
                    'MX03'      , 1e-3*[0.90], 1e-12*[541.67], nan  ;
                    'MX04'      , 1e-3*[0.73], 1e-12*[202.54], nan  ;
                    'MX05'      , 1e-3*[0.85], 1e-12*[179.17], nan  ;
                    'MX06'      , 1e-3*[0.77], 1e-12*[nan]   , nan  ;
                    'MX07'      , 1e-3*[0.85], 1e-12*[nan]   , nan  ;
                    'MX08'      , 1e-3*[0.89], 1e-12*[237.86], nan  ;
                    'MX09'      , 1e-3*[0.81], 1e-12*[275.45], nan  ;
                    'MX10'      , 1e-3*[1.03], 1e-12*[nan]   , nan  ;
                    'MX12'      , 1e-3*[0.93], 1e-12*[nan]   , nan  ;
                    'MX_2-02'   , 1e-3*[0.91], 1e-12*[160.59], nan  ;
                    'MX_2-03'   , 1e-3*[0.94], 1e-12*[308.63], nan  ;
                    'MX_2-04'   , 1e-3*[0.77], 1e-12*[158.10], nan  ;
                    'MX_2-05'   , 1e-3*[0.92], 1e-12*[190.95], nan  ;
                    'MX_2-06'   , 1e-3*[0.80], 1e-12*[222.96], nan  ;
                    'MX_2-07'   , 1e-3*[0.96], 1e-12*[167.87], nan  ;
                    'MX_2-08'   , 1e-3*[0.73], 1e-12*[nan]   , nan  }
                
                
  

tableStaticData = cell2table(sampleStaticData,'VariableNames',{'Name' 'Free span' 'Area','Fiber length'});

% Begin 
folderNames = subdirImport(ctrl.workDir,'dir');
selIdx = contains(folderNames,ctrl.folderToImportSelector);
folderNames = folderNames(selIdx);

% Initialization
options = optimset('Display','none','tolx',10000);




% Setup plotting windows
if ctrl.plotFlag
    FigA = figure('units','centimeters','OuterPosition',[10 10 24 10]);
    tiledlayout(1,3,'padding','none','tilespacing','none');
%     FigB = figure();
end

% Main execution loop
for aLoop = 1:3%numel(folderNames)%-3
    fprintf('       -> Folder: %s .\n',[ctrl.workDir filesep folderNames{aLoop} filesep]);
    fileToImport = subdirImport([ctrl.workDir filesep folderNames{aLoop} filesep],'regex',ctrl.fileWithForceDisplacement);

    assert(numel(fileToImport) == 1,'Multiple files match. Refine selection string ctrl.fileWithForceDisplacement')
    filesInDir = subdirImport([ctrl.workDir filesep folderNames{aLoop} filesep],'regex','_5x.png');
    
    assert(numel(filesInDir) == 1)

    nexttile();
    C = imread([ctrl.workDir filesep folderNames{aLoop} filesep filesep filesInDir{1}]);
    imagesc(C)
    axis equal
    set(gca,'visible','off')

end


print('test1','-dpng')

