function realCenterline = extractCenterlineFromImage(targetDir,stringToMatch,referenceLength,saveName)


filesInDir = subdirImport(targetDir,'regex',stringToMatch);
assert(numel(filesInDir) == 1)


C = imread([targetDir filesep filesInDir{1}]);


imagesc(C)
title('Draw the free span by CLICK-HOLD-DRAG-RELEASE');
straightLine = drawline; %[x y]

title('Draw true centerline by CLICK-REPOSITION-CLICK until end (DOUBLE-CLICK ESC')
roi = drawpolyline;

freespanInPixels = sum(sqrt(sum(diff(straightLine.Position,1,1))).^2);

mmPerPixel = referenceLength/freespanInPixels; %% mm per pixel

realCenterline = roi.Position.*mmPerPixel;


% assert(sqrt(sum(sum(diff(realCenterline,                   1,1))).^2) >= sqrt(sum(sum(diff(straightLine.Position.*mmPerPixel,1,1))).^2))
% sum(sqrt(sum(diff(realCenterline,                   1,1)).^2));
% sqrt(sum(sum(diff(straightLine.Position.*mmPerPixel,1,1)).^2));

realCenterline = realCenterline - realCenterline(1,:);



save([targetDir filesep saveName],'realCenterline')