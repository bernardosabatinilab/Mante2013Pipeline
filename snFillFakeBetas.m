function [ output_args ] = snFillFakeBetas(nCells, nPoints)
%snFillFakeBetas Make a matrix that of that contains the regression coef
%   Generates (nCells, nBetas, nPoints) matrix of beta coefficients that
%   will be used to generate the fake data.  The points are drawn from
%   random functions generates by snRandomFunc.  The betas are modelled on
%   the Newsome Shenoy paper.  There are 5, which is hard coded here.
%   They are [choice motion color context 1]
%   Global variable snvFakeBetas is the output

    nBetas=5; 
    
    disp('test')
    global snvFakeBetas    
    snvFakeBetas=zeros(nCells, nBetas, nPoints);

    for cellCounter=1:nCells
        for betaCounter=1:nBetas
            if betaCounter==1
                snvFakeBetas(cellCounter, betaCounter, :)=snRandomFunc(nPoints).*[1:15]/8;                
            else
                snvFakeBetas(cellCounter, betaCounter, :)=snRandomFunc(nPoints);
            end
        end
    end

end

