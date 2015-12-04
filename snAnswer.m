function [ ans ] = snAnswer(conds)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
        if conds(4)==1 % color trial
            if conds(3)==0 % no info, random
                ans=sign(rand()-0.5); 
            elseif conds(3)<0 % should be left
                ans=-1;
            else % conds(3)>0 % should be right
                ans=1;
            end
        else %conds(4)==-1 % motion trial
            if conds(2)==0 % no info, random
                ans=sign(rand()-0.5); 
            elseif conds(2)<0 % should be left
                ans=-1;
            else % conds(3)>0 % should be right
                ans=1;
            end
        end
end

