function [ allConditions ] = snExplode( conditions )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    if length(conditions)>1
       part1=conditions{1};
       part2=snExplode(conditions(2:end));
       allConditions=zeros(...
           size(part2, 1)+1, ...
           size(part1, 2)*size(part2, 2)...
           );
       
       indexCounter=0;
       for counter1=1:length(part1)
            for counter2=1:size(part2, 2)
                indexCounter=indexCounter+1;
                allConditions(:, indexCounter)=...
                    [part1(counter1); part2(:, counter2)];
            end
       end
    else
        allConditions=conditions{1}';
    end

end

