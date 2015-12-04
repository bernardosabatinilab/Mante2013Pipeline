global snvFakeBetas snvFakeData snvFakeDataRaw 
global snvTrialStructure snvAllConditions
global snvCalcBetas snvCalcBetasRaw
global snvAvgData
global snvAvgDataConcat


nCells=93;
nPoints=15;
nTrials=1071;
noiseAmp=10;
nBetas=5;

disp('make fake data')
snFillFakeBetas(nCells, nPoints); % create a table of beta coefficients
snFillFakeTrialStructure(nTrials); % make up the trials 
snFillFakeData(noiseAmp); % make up data

% Section 6.3

disp('regress')
snDoRegression; % calculate the betas from the data

disp('averages')
% Section 6.4
snCalcCondAvg(); % calculate average for each cell across trial types
snCalcCondVar(); % and the variance -- not used
snConcatCellAvgs(); % concatenate the averages into a cell x (trialTypesxTime) matrix

disp('pca')
% Section 6.6
% calc PCA
[coeff,score,latent,tsquared,explained] = pca(snvAvgDataConcat); % do pca
rd=score*coeff'; % the reconstructed data to compare to snvAvgDataConcat as a sanity check

% denoise
nPCA=20;
Dmatrix=zeros(nCells,nCells);
for counter=1:nPCA
    Dmatrix=Dmatrix+coeff(:, counter)*coeff(:, counter)';
end
snvAvgDataConcatDenoise=snvAvgDataConcat*Dmatrix; % calc denoised

% Section 6.7 - The betas in regression subspace
%   snvFakeBetas(nCells, nBetas, nPoints) 
%   squeeze(snvFakeBetas(:, betaIndex, timeIndex)) corresponds to beta-subv,t
%   squeeze(snvFakeBetas(:, betaIndex, :))' give it for all times and cells
%   beta-subv,t-suppca = squeeze(snvFakeBetas(:, betaIndex, :))'*Dmatrix;
snvFakeBetasDenoise=0*snvFakeBetas;
snvCalcBetasDenoise=0*snvFakeBetas;
snvCalcBetasRawDenoise=0*snvFakeBetas;

for counter=1:nBetas
    snvFakeBetasDenoise(:,counter,:)=reshape(...
        (squeeze(snvFakeBetas(:, counter, :))'*Dmatrix)', ...
        [nCells 1 nPoints]);
    snvCalcBetasDenoise(:,counter,:)=reshape(...
        (squeeze(snvCalcBetas(:, counter, :))'*Dmatrix)', ...
        [nCells 1 nPoints]);
    snvCalcBetasRawDenoise(:,counter,:)=reshape(...
        (squeeze(snvCalcBetasRaw(:, counter, :))'*Dmatrix)', ...
        [nCells 1 nPoints]);
end

snvFakeBetasDenoiseMax=zeros(nBetas-1, nCells);
snvCalcBetasDenoiseMax=zeros(nBetas-1, nCells);
snvCalcBetasRawDenoiseMax=zeros(nBetas-1, nCells);

for counter=1:nBetas-1 % drop the last beta which is an offset
    b=(squeeze(snvFakeBetasDenoise(:,counter,:))');
    [~,I]=max(diag(sqrt(b*b')));
    snvFakeBetasDenoiseMax(counter,:)=squeeze(snvFakeBetasDenoise(:,counter,I));
    
    b=(squeeze(snvCalcBetasDenoise(:,counter,:))');
    [~,I]=max(diag(sqrt(b*b')));
    snvCalcBetasDenoiseMax(counter,:)=squeeze(snvCalcBetasDenoise(:,counter,I));
    
    b=(squeeze(snvCalcBetasRawDenoise(:,counter,:))');
    [~,I]=max(diag(sqrt(b*b')));
    snvCalcBetasRawDenoiseMax(counter,:)=squeeze(snvCalcBetasRawDenoise(:,counter,I));
end

[Q,R]=qr(snvCalcBetasDenoiseMax');
BP=Q(:,1:4);
pvc=snvAvgDataConcat*BP;
pvc=pvc';

[31 25 7 1]
[32 26 8 2]
t1=31;
t2=25;
t3=7;
t4=1;

figure;plot(pvc(1,(t1-1)*15+[1:15])', 'color', 'b', 'lineWidth', 1)
set(gca, 'nextPlot', 'add')
plot(pvc(1,(t2-1)*15+[1:15])', 'color', 'b', 'lineWidth', 2)
plot(pvc(1,(t3-1)*15+[1:15])', 'color', 'r', 'lineWidth', 1)
plot(pvc(1,(t4-1)*15+[1:15])', 'color', 'r', 'lineWidth', 2)

figure;plot(pvc(2,(t1-1)*15+[1:15])', 'color', 'b', 'lineWidth', 1)
set(gca, 'nextPlot', 'add')
plot(pvc(2,(t2-1)*15+[1:15])', 'color', 'b', 'lineWidth', 2)
plot(pvc(2,(t3-1)*15+[1:15])', 'color', 'r', 'lineWidth', 1)
plot(pvc(2,(t4-1)*15+[1:15])', 'color', 'r', 'lineWidth', 2)

figure;plot(pvc(3,(t1-1)*15+[1:15])', 'color', 'b', 'lineWidth', 1)
set(gca, 'nextPlot', 'add')
plot(pvc(3,(t2-1)*15+[1:15])', 'color', 'b', 'lineWidth', 2)
plot(pvc(3,(t3-1)*15+[1:15])', 'color', 'r', 'lineWidth', 1)
plot(pvc(3,(t4-1)*15+[1:15])', 'color', 'r', 'lineWidth', 2)

figure;plot(pvc(4,(t1-1)*15+[1:15])', 'color', 'b', 'lineWidth', 1)
set(gca, 'nextPlot', 'add')
plot(pvc(4,(t2-1)*15+[1:15])', 'color', 'b', 'lineWidth', 2)
plot(pvc(4,(t3-1)*15+[1:15])', 'color', 'r', 'lineWidth', 1)
plot(pvc(4,(t4-1)*15+[1:15])', 'color', 'r', 'lineWidth', 2)

snvAllConditions(:,[t1 t2 t3 t3])



%% NOTES
% Keep in mind that in MATLAB that the inner produce is row * column 
%       ([1 2 3]*[1 2 3]'=14)
% The data is the format of time points x cells 
%   size(snvAvgDataConcat)=(nPoints*nConditions, nCells)
%
%   Coeff has the definitions of the principal components in the columns
%       coeff(:, 1) is the PC1 -- 
%           the contribution of the time point 1 data for each cell 
%           to the time point 1 coordinate 1 in PC space  
%       snvAvgDataConcat(1,:)*coeff(:,1) gives score(1,1)
%       snvAvgDataConcat(2,:)*coeff(:,1) gives score(2,1)
%       snvAvgDataConcat(n,:)*coeff(:,p) gives score(n,p)
%
%       score = snvAvgDataConcat*coeff;
%           and
%       snvAvgDataConcat = score*coeff';
%
%   score describes the trajectorys in the PC space - same dimensions as
%   the data - snvAvgDataConcat
%       score(:,1) shows the trajectory across time in PC dimension 1
%       plot3(score(:,1), score(:,2), score(:,3)) plots the trajectories in
%       the first 3 dimensions
%       score(1,:) are the coordinates in PC space of the first time point
%       score(t,:) are the coordinates in PC space of the time point t
%           (PC1(t), PC2(t)..., PCnCells(t))
%
%   score and coeff can be used to reconstruct the orginal data
%       score(1,:)*coeff(1,:)' = coeff(1,:)*score(1,:)' = snvAvgDataConcat(1,1)
%       score(t,:)*coeff(p,:)' = coeff(p,:)*score(t,:)' = snvAvgDataConcat(t,p)
%           i.e. the 9th time point for the 5th cell is reconstructed
%       










