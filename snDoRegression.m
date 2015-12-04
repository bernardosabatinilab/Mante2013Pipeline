function [ output_args ] = snDoRegression()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    global snvFakeBetas snvFakeData snvFakeDataRaw snvTrialStructure snvCalcBetas snvCalcBetasRaw
    
    nCells=size(snvFakeBetas,1);
    nBetas=size(snvFakeBetas,2);
    nPoints=size(snvFakeBetas,3);
    nTrials=size(snvTrialStructure, 2);

    snvCalcBetas=0*snvFakeBetas;
    snvCalcBetasRaw=0*snvFakeBetas;

    
    parfor cellCounter=1:nCells
        disp(['Cell number = ' num2str(cellCounter)]);
        for pointCounter=1:nPoints
            response=snvFakeData(:, cellCounter, pointCounter);  % the data across trials for 1 time point
            mdl=fitlm(snvTrialStructure(1:end-1,:)', response);
            est=mdl.Coefficients.Estimate;
            snvCalcBetas(cellCounter, :, pointCounter)=[est(2:end); est(1)];
            
            response=snvFakeDataRaw(:, cellCounter, pointCounter);  % the data across trials for 1 time point
            mdl=fitlm(snvTrialStructure(1:end-1,:)', response);
            est=mdl.Coefficients.Estimate;
            snvCalcBetasRaw(cellCounter, :, pointCounter)=[est(2:end); est(1)];
        end
    end

end

