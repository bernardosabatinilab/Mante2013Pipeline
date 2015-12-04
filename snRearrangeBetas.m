function [ output_args ] = snRearrangeBetas()
%snRearrangeBetas - Do 6.7 in the supplment 
% run snDoRegression first
    
    global snvFakeBetas snvCalcBetas
    
    nCells=size(snvFakeBetas,1);
    nBetas=size(snvFakeBetas,2);
    nPoints=size(snvFakeBetas,3);
    
    for cellCounter=1:nCells
        for betaCounter=1:nBetas
            snvFakeBetas(cellCounter, betaCounter, :)=snRandomFunc(nPoints);
        end
    end

end

