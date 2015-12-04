function [ dataOut ] = snConcatCellAvgs()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
        
    global snvAvgData
    nConditions=size(snvAvgData,1);
    nCells=size(snvAvgData, 2);
    nPoints=size(snvAvgData, 3);
    
    global snvAvgDataConcat
    snvAvgDataConcat=zeros(nConditions*nPoints, nCells);
    for cellCounter=1:nCells
        snvAvgDataConcat(:, cellCounter)=...
            reshape(...
            squeeze(snvAvgData(:, cellCounter, :))',...
            1, nConditions*nPoints)';
    end
    
