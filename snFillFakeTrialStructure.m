function [ output_args ] = snFillFakeTrialStructure(nTrials)
%snFillFakeTrialStructure Generates fake trial conditions
%   Generates a (nBetas, nTrials) matrix with the randomized conditions for
%   each trial [choice motion color context 1].
%   Alter the matrices below.  Currently implemented to only generate
%   "success" trials

    global snvTrialStructure snvFakeBetas snvConditions
    nBetas=size(snvFakeBetas,2);
    snvTrialStructure=zeros(nBetas, nTrials);

    possibleColor=[-1 -0.5 0.5 1];
    possibleMotion=[-1 -0.5 0.5 1];
    possibleChoice=[0]; % there is only a right choice so I'll fix below 
    possibleContext=[-1 1];
    possibleOffset=[1];
    
    snvConditions={...
        possibleChoice...
        possibleMotion...
        possibleColor...
        possibleContext...
        possibleOffset};
    
    % unused for now -- implement if need to generate failure trials
%    rightContext=0.9;
%    rightAnswer=[-.95 -0.4 0 .4 .95]
%    rightContext=1; % only analyze the correct trials so make them all correct
%    rightAnswer=[1 1 1 1 1]; % only analyze the correct trials so make them all correct
    
    for trialCounter=1:nTrials
        conds=zeros(1, nBetas);
        for condCounter=1:nBetas
            randIndex=1+floor(length(snvConditions{condCounter})*rand());
            conds(condCounter)=...
                snvConditions{condCounter}(randIndex);
        
        end
 
        conds(1)=snAnswer(conds);
        snvTrialStructure(:, trialCounter)=conds';
    end
        
    global snvAllConditions snvTrialIndices
    snvAllConditions=snExplode(snvConditions);
    for trialCounter=1:length(snvAllConditions)
        snvAllConditions(1, trialCounter)=snAnswer(snvAllConditions(:,trialCounter));
    end   
    
    snvTrialIndices=zeros(1, length(snvTrialStructure));
    for trialCounter=1:length(snvTrialStructure)
        snvTrialIndices(trialCounter)=find(ismember(snvAllConditions', snvTrialStructure(:,trialCounter)', 'rows'));
    end
