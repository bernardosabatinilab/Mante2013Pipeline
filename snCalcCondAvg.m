function [ output_args ] = snCalcCondAvg(raw)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    if nargin<1
        raw=0;
    end
    
    global snvFakeBetas snvFakeData snvFakeDataRaw snvTrialStructure 
    global snvAllConditions snvTrialIndices
    
    nCells=size(snvFakeBetas,1);
    nBetas=size(snvFakeBetas,2);
    nPoints=size(snvFakeBetas,3);

    nConditions=size(snvAllConditions, 2);
        
    global snvAvgData
    snvAvgData=zeros(nConditions, nCells, nPoints);

    for cellCounter=1:nCells
        trialTypeCount=zeros(1, nConditions);    
        for trialCounter=1:length(snvTrialStructure)
            trialIndex=snvTrialIndices(trialCounter);
            if raw
                oneData=snvFakeDataRaw(trialCounter, cellCounter, :);
            else
                oneData=snvFakeData(trialCounter, cellCounter, :);                
            end
            
            if trialTypeCount(trialIndex)==0
                snvAvgData(trialIndex, cellCounter, :)=oneData;
                trialTypeCount(trialIndex)=1;
            else
                nIn=trialTypeCount(trialIndex);
                trialTypeCount(trialIndex)=nIn+1;
                snvAvgData(trialIndex, cellCounter, :)=(...
                     oneData+nIn*snvAvgData(trialIndex, cellCounter, :)...
                     )/(nIn+1);
            end
        end
    end
    
    

