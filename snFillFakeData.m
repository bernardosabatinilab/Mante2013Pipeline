function [ output_args ] = snFillFakeData(noiseAmp)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    if nargin<1
        noiseAmp=0;
    end
    
    global snvFakeBetas snvFakeData snvFakeDataRaw snvTrialStructure
    
    nCells=size(snvFakeBetas,1);
    nBetas=size(snvFakeBetas,2);
    nPoints=size(snvFakeBetas,3);
    nTrials=size(snvTrialStructure, 2);

    snvFakeData=zeros(nTrials, nCells, nPoints);
    snvFakeDataRaw=zeros(nTrials, nCells, nPoints);

    parfor cellCounter=1:nCells
        cellBetas=squeeze(snvFakeBetas(cellCounter, :, :))';
        for trialCounter=1:nTrials        
            dataOne=cellBetas*snvTrialStructure(:,trialCounter)+noiseAmp*(rand(nPoints,1)-1);
            dataOneAvg=mean(dataOne);
            dataOneStd=std(dataOne);
            snvFakeDataRaw(trialCounter, cellCounter, :)=dataOne;
            dataOne=(dataOne-dataOneAvg)/dataOneStd;   
            snvFakeData(trialCounter, cellCounter, :)=dataOne;
        end
    end

end

