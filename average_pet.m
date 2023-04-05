%This function takes in a data matrix X and a label
%vector y and outputs the average cat image and average dog image.
function [avgcat avgdog] = average_pet(X,y)

allcat = zeros(1000,4096);
alldog = zeros(1000,4096);

for i = 1:length(y)
    if y(i) == -1
        allcat(i,:) = X(i,:);
    end
    if y(i) == 1
        alldog(i,:) = X(i,:);
    end
end

avgdcat = zeros(1,4096);
avgdog = zeros(1,4096);

for j = 1:4096
    avgcat(j) = sum(allcat(:,j)) / 1000;
    avgdog(j) = sum(alldog(:,j)) / 1000;
end


%Your code should go above this line.
if (size(avgcat,1)~=1) 
    error("The variable avgcat is not a row vector.")
end
if (size(avgcat,2)~=size(X,2))
    error("The variable avgcat does not have the same number of columns as the data matrix input.")
end
if (size(avgdog,1)~=1) 
    error("The variable avgdog is not a row vector.")
end
if (size(avgdog,2)~=size(X,2)) 
    error("The variable avgdog does not have the same number of columns as the data matrix input.")
end