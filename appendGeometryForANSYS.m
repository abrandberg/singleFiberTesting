function appendGeometryForANSYS(xMean,yMean,zMean,meanWidth,meanHeight)
% function appendGeometryForANSYS(xMean,yMean,zMean,meanWidth,meanHeight) generates
% the necessary Ansys APDL commands to reconstruct the fiber geometry, assuming
% for simplicity that the fiber can be seen as a beam with a rectangular 
% cross-section.
%
% INPUTS:
%   xMean       - Vector of x-coordinates for each point along the centerline
%   yMean       -           y-coordinates
%   zMean       -           z-coordinates
%   meanWidth   - Scalar value denoting the width of the fiber cross-section
%   meanHeight  - Scalar value denoting the height of the fiber cross-section
%
% OUTPUTS:
%   File with the ANSYS APDL commands
%
%
% created by : August Brandberg augustbr at kth dot se
% date: 2021-02-15
%%% 
xMean = round(xMean,2);
yMean = round(yMean,2);
zMean = round(zMean,2);

% Hard coded parameters
dirControl = 0;
keyCounter = 0; 
downSampleRate = 1;
fileID = fopen('test44.txt','w');

% Loop
fprintf(fileID,'%s\n',horzcat('sectype,,beam,rect,','1'));
fprintf(fileID,'%s\n',horzcat('secnum,','1'));
fprintf(fileID,'%s\n',horzcat('secdata,',num2str(meanWidth),',',num2str(meanHeight)));
for vLoop = 1:downSampleRate:size(xMean,1) % For each fiber
        fprintf(fileID,'%s\n',horzcat('k,,',num2str(xMean(vLoop)),',',num2str(yMean(vLoop)),',',num2str(zMean(vLoop))));
        if vLoop > 1
            if dirControl == 1 % Does not quite work right now, but should be easy to find the edge case and fix it.
                if vLoop == size(xMean,1)
                    tailVec = diff([xMean(vLoop-1:vLoop) yMean(vLoop-1:vLoop) [0 ; 0]],1,1)./norm(diff([xMean(vLoop-1:vLoop) yMean(vLoop-1:vLoop) [0 ; 0]],1,1));
                    headVec = [0 1 0];
                else
                    tailVec = diff([xMean(vLoop-1:vLoop) yMean(vLoop-1:vLoop) [0 ; 0]],1,1)./norm(diff([xMean(vLoop-1:vLoop) yMean(vLoop-1:vLoop) [0 ; 0]],1,1));
                    headVec = diff([xMean(vLoop:vLoop+1) yMean(vLoop:vLoop+1) [0 ; 0]],1,1)./norm(diff([xMean(vLoop:vLoop+1) yMean(vLoop:vLoop+1) [0 ; 0]],1,1));
                end
                fprintf(fileID,'L,%d,%d,,,%4.3f,%4.3f,%4.3f,%4.3f,%4.3f,%4.3f\n',(vLoop-1)/downSampleRate,(vLoop-1)/downSampleRate+1,tailVec,headVec);
            else
                fprintf(fileID,'L,%d,%d\n',(vLoop-1)/downSampleRate,(vLoop-1)/downSampleRate+1);
            end
        end
end
fclose(fileID);