function [ dataOut ] = snPullTrials(cellNumber, trialType, raw)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    if nargin<3 
        raw=0;
    end
    
    global snvFakeData snvFakeDataRaw snvTrialStructure snvAllConditions
    
    foundIndices=find(ismember(snvTrialStructure', trialType, 'rows'));

    if raw
        dataOut=squeeze(snvFakeDataRaw(foundIndices, cellNumber, :));
    else
        dataOut=squeeze(snvFakeData(foundIndices, cellNumber, :));
    end
    