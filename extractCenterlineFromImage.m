function realCenterline = extractCenterlineFromImage(targetDir,stringToMatch,referenceLength,saveName)


filesInDir = subdirImport(targetDir,'regex',stringToMatch);
assert(numel(filesInDir) == 1)


C = imread([targetDir filesep filesInDir{1}]);


imagesc(C)
title('Draw the free span by CLICK-HOLD-DRAG-RELEASE');
straightLine = drawline; %[x y]

title('Draw true centerline by CLICK-REPOSITION-CLICK until end (DOUBLE-CLICK ESC')
roi = drawpolyline;

freespanInPixels = sqrt(sum(sum(diff(straightLine.Position,1,1))).^2);

mmPerPixel = referenceLength/freespanInPixels; %% mm per pixel

realCenterline = roi.Position.*mmPerPixel;

realCenterline = realCenterline - realCenterline(1,:);



save([targetDir filesep saveName],'realCenterline')