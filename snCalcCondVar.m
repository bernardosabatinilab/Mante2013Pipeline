function [ output_args ] = snCalcCondVar(raw)
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
        
    global snvAvgData snvVarData
    snvVarData=zeros(nConditions, nCells, nPoints);
          
    for cellCounter=1:nCells
        trialTypeCount=zeros(1, nConditions);    
        for trialCounter=1:length(snvTrialStructure)
            trialIndex=snvTrialIndices(trialCounter);
            if raw
                oneData=snvFakeDataRaw(trialCounter, cellCounter, :);
            else
                oneData=snvFakeData(trialCounter, cellCounter, :);                
            end
            
           vv=(snvAvgData(trialIndex, cellCounter, :)-oneData).^2;
           if trialTypeCount(trialIndex)==0
                snvVarData(trialIndex, cellCounter, :)=oneData;
                trialTypeCount(trialIndex)=1;
            else
                nIn=trialTypeCount(trialIndex);
                trialTypeCount(trialIndex)=nIn+1;
                snvVarData(trialIndex, cellCounter, :)=(...
                     vv+nIn*snvVarData(trialIndex, cellCounter, :)...
                     )/(nIn+1);
            end
        end
    end
    
    

