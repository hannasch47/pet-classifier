%Perceptron training error rate is 0%.
%Perceptron test error rate is 18%.

%This function takes in a training data matrix Xtrain, training
%label vector ytrain and uses them to the decision rule corresponding
%to a very simple one-layer neural network: the perceptron. 
%It also takes in a data matrix Xrun and produces a vector of label
%guesses yguess, corresponding to the sign of the linear prediction.
function yguess = perceptron(Xtrain,ytrain,Xrun)

[a b] = size(Xrun);
yguess = zeros(a,1);
invXtrain2 = pinv((Xtrain')*Xtrain);
for i = 1:a
    x = Xrun(i,:);
    var1 = x*invXtrain2*(Xtrain')*ytrain;
    if var1 >= 0
        yguess(i) = 1;
    else
        yguess(i) = -1;
    end
end



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