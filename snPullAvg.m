function [ dataOut ] = snPullAvg(cellNumber, trialType)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    if nargin<3 
        raw=0;
    end
    
    global snvAllConditions snvAvgData
    
    foundIndex=find(ismember(snvAllConditions', trialType, 'rows'));

    dataOut=squeeze(snvAvgData(foundIndex, cellNumber, :));
