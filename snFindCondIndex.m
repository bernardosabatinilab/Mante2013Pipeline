function [ foundIndices ] = snFindCondIndex(trialType)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    

    global snvAllConditions
    
    foundIndices=find(ismember(snvAllConditions', trialType, 'rows'));

    