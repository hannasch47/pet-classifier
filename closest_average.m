%Closest average training error rate is 20%.
%Closest average test error rate is 18%.

%This function takes in a training data matrix Xtrain, training
%label vector ytrain and uses them to compute the average cat
%and dog vectors. It also takes in a data matrix Xrun and 
%produces a vector of label guesses yguess, corresponding to whether
%each row of Xtest is closer to the average cat or average dog.
function yguess = closest_average(Xtrain,ytrain,Xrun)

cattrain = zeros(800,4096);
dogtrain = zeros(800,4096);

for i = 1:length(ytrain)
    if ytrain(i) == -1
        cattrain(i,:) = Xtrain(i,:);
    end
    if ytrain(i) == 1
        dogtrain(i,:) = Xtrain(i,:);
    end
end

avgcattrain = zeros(1,4096);
avgdogtrain = zeros(1,4096);

for j = 1:4096
    avgcattrain(j) = sum(cattrain(:,j)) / 800;
    avgdogtrain(j) = sum(dogtrain(:,j)) / 800;
end

[a b] = size(Xrun);
yguess = zeros (1,a);
for i = 1:a
    x = Xrun(i,:);
    catdist = norm(x-avgcattrain);
    dogdist = norm(x-avgdogtrain);
    if catdist > dogdist
        yguess(i) = 1;
    else
        yguess(i) = -1;
    end
end

yguess = yguess' ; 

%Your code should go above this line.
if (~iscolumn(yguess))
    error("yguess is not a column vector.")
elseif (length(yguess)~=size(Xrun,1))
    error("Length of yguess is not equal to the number of rows in Xrun.")
elseif (sum(unique(abs(ytrain))~=1))
    warning("Some elements in ytrain are not +1 or -1.")
elseif (sum(unique(abs(yguess))~=1))
    warning("Some elements in yguess are not +1 or -1.")
end