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
                
                
                
% ctrl.plotFlag = 1;
% ctrl.workDir = 'C:\Users\augus\Downloads\DMA Compliance\';                             % Working directory.
% ctrl.targetDir = 'delmeRuns';                   % Directory in which to build and solve FEM runs.
% ctrl.centerlineSaveFile = 'centerline.mat';     % File name where previously extracted fiber centerline is stored.
% ctrl.folderToImportSelector = '-'; 
% ctrl.fileWithForceDisplacement = '.txt';
% ctrl.machineCompliance = 0;%0.0001266;             % [m/N]
% ctrl.startIdx = 1;
% ctrl.endIdx = 800;%700;                
% ctrl.manualSeg = 1;
% 
%                    %  NAME           FREESPAN           AREA   REAL LENGTH
% sampleStaticData = {'Flax_3mm-1'      , 1e-3*[2.08], 1e-12*[165.72], nan ; 
%                     'Flax_3mm-2'      , 1e-3*[nan],  1e-12*[nan],    nan  ;     % bad measurement
%                     'Flax_3mm-3'      , 1e-3*[2.70], 1e-12*[nan],    nan  ;
%                     'Flax_5mm-2'      , 1e-3*[4.90], 1e-12*[212.65], nan  ;
%                     'Flax_5mm-3'      , 1e-3*[4.96], 1e-12*[182.88], nan  ;
%                     'Alexander_0.3-1' ,  1e-3*[0.47], 1e-12*[206],    nan  ; 
%                     'Alexander_0.3-2' ,  1e-3*[0.56], 1e-12*[206],    nan  ; 
%                     'Alexander_0.3-3' ,  1e-3*[0.77], 1e-12*[206],    nan  ; 
%                     'Alexander_0.3-4' ,  1e-3*[0.49], 1e-12*[206],    nan  ; 
%                     'Alexander_0.3-5' ,  1e-3*[0.80], 1e-12*[206],    nan  ; 
%                     'Alexander_1-1' ,  1e-3*[1], 1e-12*[206],    nan  ; 
%                     'Alexander_1-2' ,  1e-3*[1.4], 1e-12*[206],    nan  ; 
%                     'Alexander_1-3' ,  1e-3*[1.08], 1e-12*[206],    nan  ; 
%                     'Alexander_1-4' ,  1e-3*[1.07], 1e-12*[206],    nan  ; 
%                     'Alexander_1-5' ,  1e-3*[1.06], 1e-12*[206],    nan  ; 
%                     'Alexander_3-1' ,  1e-3*[2.81], 1e-12*[206],    nan  ; 
%                     'Alexander_3-2' ,  1e-3*[2.26], 1e-12*[206],    nan  ; 
%                     'Alexander_3-3' ,  1e-3*[2.87], 1e-12*[206],    nan  ; 
%                     'Alexander_3-4' ,  1e-3*[1.81], 1e-12*[206],    nan  ; 
%                     'Alexander_3-5' ,  1e-3*[3.04], 1e-12*[206],    nan  ; 
%                     'Alexander_5-1' ,  1e-3*[4.84], 1e-12*[206],    nan  ; 
%                     'Alexander_5-2' ,  1e-3*[3.6], 1e-12*[206],    nan  ; 
%                     'Alexander_5-3' ,  1e-3*[3.99], 1e-12*[206],    nan  ; 
%                     'Alexander_5-4' ,  1e-3*[4.17], 1e-12*[206],    nan  ; 
%                     'Alexander_5-5' ,  1e-3*[4.57], 1e-12*[206],    nan  ; };
                    
                    
                    
                    
                    
                    
                    
%                     'Flax_SH-1'       , 1e-3*[0.91], 1e-12*[159.37]   , nan  ;
%                     'Flax_SH-2'       , 1e-3*[0.84], 1e-12*[203.59]   , nan  ;
%                     'Flax_SH-3'       , 1e-3*[0.98], 1e-12*[136.30]   , nan  }
%                               
                
                
                
                
                
                
                
                
                

tableStaticData = cell2table(sampleStaticData,'VariableNames',{'Name' 'Free span' 'Area','Fiber length'});

% Begin 
folderNames = subdirImport(ctrl.workDir,'dir');
selIdx = contains(folderNames,ctrl.folderToImportSelector);
folderNames = folderNames(selIdx);

% Initialization
options = optimset('Display','none','tolx',10000);




% Setup plotting windows
if ctrl.plotFlag
    FigA = figure();
    tiledlayout(3,3);
    FigB = figure();
end

% Main execution loop
for aLoop = 1:numel(folderNames)%-3
    fprintf('       -> Folder: %s .\n',[ctrl.workDir filesep folderNames{aLoop} filesep]);
    fileToImport = subdirImport([ctrl.workDir filesep folderNames{aLoop} filesep],'regex',ctrl.fileWithForceDisplacement);

    assert(numel(fileToImport) == 1,'Multiple files match. Refine selection string ctrl.fileWithForceDisplacement')
    timeForceDisplacementData = importfile([ctrl.workDir filesep folderNames{aLoop} filesep fileToImport{1}]);
    
    
    if ctrl.plotFlag | ctrl.manualSeg
        figure(FigA)
        nexttile(1);
        plot(timeForceDisplacementData(:,1))
        hold on
%         plot(timeForceDisplacementData(ctrl.startIdx:ctrl.endIdx,1))
        xlabel('Index'); ylabel('Time [s]');
        hold off
        
        nexttile(2);
        plot(timeForceDisplacementData(:,2))
        hold on
        xlabel('Index'); ylabel('Force [N]');
        hold off
        
        
        
        if ctrl.manualSeg
            
            if not(exist([ctrl.workDir filesep folderNames{aLoop} filesep 'xInterval.mat'],'file'))
                [xStart,~] = ginput(1);
                [xEnd,~] = ginput(1);
                ctrl.startIdx = round(xStart); ctrl.endIdx = round(xEnd);
                save([ctrl.workDir filesep folderNames{aLoop} filesep 'xInterval.mat'],'xStart','xEnd')
            else
                load([ctrl.workDir filesep folderNames{aLoop} filesep 'xInterval.mat'])
            end
            hold on
            plot(timeForceDisplacementData(ctrl.startIdx:ctrl.endIdx,2))           
        end
        
        nexttile(3);
        plot(timeForceDisplacementData(:,3))
        hold on
        plot(timeForceDisplacementData(ctrl.startIdx:ctrl.endIdx,3))
        xlabel('Index'); ylabel('Displacement [mm]');
        hold off
    end
    
    % Truncate data
    timeForceDisplacementData = timeForceDisplacementData(ctrl.startIdx:ctrl.endIdx,:);
    
    % Find and assert that static data is present for this sample
    rowToExamine = find(strcmp(sampleStaticData(:,1),stringComparisonFunction(fileToImport{1},0)    )    );
%     rowToExamine = find(startsWith(sampleStaticData(:,1) ,strtok(fileToImport{1},'.')   )    );
%     assert(sum(rowToExamine) == numel(rowToExamine),'Multiple or 0 rows hit. Possible data entry error.')
    assert(numel(rowToExamine) > 0,'0 rows hit. Possible data entry error.')
    
    systemFit = polyfit(timeForceDisplacementData(:,3).*1e-3,timeForceDisplacementData(:,2),1); 
    systemStiffness(aLoop) = systemFit(1);
    
    isNumericalAreaLength = not(isnan( cell2mat(sampleStaticData(rowToExamine,[2 3]))));
    useCondition = sum(isNumericalAreaLength) == numel(isNumericalAreaLength);
    
    if useCondition
        if not(exist([ctrl.workDir filesep folderNames{aLoop} filesep ctrl.centerlineSaveFile],'file'))
            fprintf('          -> No saved centerline found in %s . Starting extraction.\n',[ctrl.workDir filesep folderNames{aLoop} filesep]);
            realCenterline = extractCenterlineFromImage([ctrl.workDir filesep folderNames{aLoop} filesep],'_5x.png',sampleStaticData{rowToExamine,2},ctrl.centerlineSaveFile);
            sampleStaticData{rowToExamine,4} = sum(sqrt(sum(diff(realCenterline,                   1,1)).^2));
        else
            fprintf('          -> Previously extracted centerline found in %s . Importing.\n',[ctrl.workDir filesep folderNames{aLoop} filesep]);
            load([ctrl.workDir filesep folderNames{aLoop} filesep ctrl.centerlineSaveFile])
            sampleStaticData{rowToExamine,4} = sum(sqrt(sum(diff(realCenterline,                   1,1)).^2));
        end
    
        % Calculation under assumption of straightness
        stressVector = timeForceDisplacementData(:,2) ./ sampleStaticData{rowToExamine,3};        % [N/m^2] Convert to nominal normal stress
        strainVectorNom = 1e-3.*timeForceDisplacementData(:,3) ./ sampleStaticData{rowToExamine,4};  % [m/m] Convert to strain
        
        % Machine compliance correction
        strainVector = (1e-3.*timeForceDisplacementData(:,3)- ctrl.machineCompliance.*timeForceDisplacementData(:,2))./ sampleStaticData{rowToExamine,4};  % [m/m] Convert to strain
        % ) 
        slopeFit = polyfit(strainVector,stressVector,1);                                        % First degree polynomial fit
    
        
        determinedModulus(aLoop,1) = slopeFit(1);
%         determinedModulus(aLoop,1) = sampleStaticData{rowToExamine,4}./sampleStaticData{rowToExamine,3}.*inv(sampleStaticData{rowToExamine,4}/(slopeFit(1).*sampleStaticData{rowToExamine,3}) - ctrl.machineCompliance);

        if ctrl.plotFlag
           figure(FigB) 
           plot(strainVectorNom,stressVector,'-b')
           hold on
           plot(strainVector,stressVector,'-k')
           plot(strainVector,polyval(slopeFit,strainVector),'-r')
           xlabel('Strain'); ylabel('Stress');
           legend('Nominal strain','corr. strain','fit')
           hold off
        end
    else
        fprintf('          -> NAN data present. Skipping. \n');
        determinedModulus(aLoop,1) = nan;
    end

end


figure;
boxchart(determinedModulus)


figure;
boxplot(determinedModulus);


figure;
tiledlayout(1,3);
nexttile;
plot([sampleStaticData{:,3}],determinedModulus,'o')
xlabel('Area'); ylabel('Modulus')
nexttile;
plot([sampleStaticData{:,4}],determinedModulus,'o')
xlabel('Free span'); ylabel('Modulus')

nexttile;
plot([sampleStaticData{:,2}],[sampleStaticData{:,4}],'o')
xlabel('Free span'); ylabel('Fiber length')




figure;
tiledlayout(1,2)
nexttile;
plot([sampleStaticData{:,2}],1./systemStiffness,'ko')
xlabel('Free span');

nexttile;
plot([sampleStaticData{:,4}],1./systemStiffness,'ko')
xlabel('Fiber length')

ap = [sampleStaticData{:,4}]./[sampleStaticData{:,3}];                               % fiber length
bp = 1./(systemStiffness);         % ./[sampleStaticData{:,3}]

















% for aLoop = 1:numel(folderNames)
%     filesInDir = subdirImport([workDir filesep folderNames{aLoop} filesep],'regex',ctrl.fileWithForceDisplacementSelector);
%     A = importfile([workDir filesep folderNames{aLoop} filesep filesInDir{1}]);
% 
% %     figure;
% %     subplot(1,3,1)
% %     plot(A(:,1))
% %     subplot(1,3,2)
% %     plot(A(:,2))
% %     subplot(1,3,3)
% %     plot(A(:,3))
% 
%     % Modulus by analytical inversion under assumption of straightness.
%     B = A;
% %     B(:,3) = (B(:,3)-B(1,3))*1e-3/(freespans(aLoop)*1e-3);
%     B(:,3) = (B(:,3))*1e-3/(freespans(aLoop)*1e-3);
%     B(:,2) = B(:,2)/150e-12;
% %     figure;
% %     plot(B(:,3),B(:,2))
%     ap = B(:,3);
%     bp = B(:,2);
%     polyvals = polyfit(ap,bp,1);
%     modulusSave(aLoop,1) = polyvals(1);
% 
% 
%     % Modulus by error minimization without assumption of straightness.
%     
%     % 1. Prepare the data: check if previous saved form exists, otherwise
%     % proceed to generate it
%     if not(exist([workDir filesep folderNames{aLoop} filesep centerlineSaveFile],'file'))
%         fprintf('          -> No saved centerline found in %s . Starting extraction.\n',[workDir filesep folderNames{aLoop} filesep]);
%         realCenterline = extractCenterlineFromImage([workDir filesep folderNames{aLoop} filesep],'_5x.png',freespans(aLoop),centerlineSaveFile);
%     else
%         fprintf('          -> Previously extracted centerline found in %s . Importing.\n',[workDir filesep folderNames{aLoop} filesep]);
%         load([workDir filesep folderNames{aLoop} filesep centerlineSaveFile])
%     end
%     
% %     realCenterline = realCenterline([1 end],:);
% %     realCenterline(2,1) = realCenterline(1,1);
% %     realCenterline(2,2) = -freespans(aLoop);
%     % 2. Generate FEM model
%     appendGeometryForANSYS(realCenterline(:,1)*1e3,realCenterline(:,2)*1e3,zeros(size(realCenterline,1),1),50,3);
%     x0 = modulusSave(aLoop,1);
%     costFcn = @(x) simulateBeam(x,ctrl,(A(:,3)-A(1,3))*1e-3,A(:,2));
%     
%     
% %     x = fminsearch(costFcn,x0)
%     x = fminbnd(costFcn,2*1e9,150*1e9,options);
%     
%     modulusSave(aLoop,2) = x;
%     title(sprintf('End modulus: %4.2f GPa, %4.2f GPa (inv./err.-min.)',modulusSave(aLoop,1)*1e-9,modulusSave(aLoop,2)*1e-9))
%     fprintf('End modulus: %4.2f GPa, %4.2f GPa (inv./err.-min.)\n',modulusSave(aLoop,1)*1e-9,modulusSave(aLoop,2)*1e-9)
%     figure
% end
% 
% 
% figure;
% 
% boxplot(modulusSave./1e9)
% ylabel('modulus estimate, GPa')



















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






