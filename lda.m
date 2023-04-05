%Linear discriminant analysis training error rate is 0%.
%Linear discriminant analysis test error rate is 18%.

%This function takes in a training data matrix Xtrain, training
%label vector ytrain and uses them to compute the cat
%and dog sample mean vectors as well as the sample covariance matrix 
%(which is assumed to be equal for cats and dogs). 
%It also takes in a data matrix Xrun and produces a vector of
%label guesses yguess, corresponding to the ML rule for
%jointly Gaussian vectors with different means and the same 
%covariance matrix.
function yguess = lda(Xtrain,ytrain,Xrun)

%finding sample mean vectors
[r c] = size(Xtrain);
cattrain = zeros(1,c);
dogtrain = zeros(1,c);

ntc = 0;
ntd = 0;

for i = 1:length(ytrain)
    if ytrain(i) == -1
        cattrain(i,:) = Xtrain(i,:);
        ntc = ntc + 1;
    end
    if ytrain(i) == 1
        dogtrain(i,:) = Xtrain(i,:);
        ntd = ntd + 1;
    end
end

avgcattrain = zeros(1,c);
avgdogtrain = zeros(1,c);

for j = 1:c
    avgcattrain(j) = sum(cattrain(:,j)) / ntc;
    avgdogtrain(j) = sum(dogtrain(:,j)) / ntd;
end

%finding sample covariance matrix (equal for cats & dogs)
covcat = cov(cattrain);
covdog = cov(dogtrain);
ntrain = length(ytrain);
covmat = (1/(ntrain-2))*(((ntc-1)*covcat)+((ntd-1)*covdog));

%It also takes in a data matrix Xrun and produces a vector of
%label guesses yguess, corresponding to the ML rule for
%jointly Gaussian vectors with different means and the same 
%covariance matrix.

[a b] = size(Xrun);
yguess = zeros(a,1);
invcovmat = pinv(covmat);
for i = 1:a
    x = Xrun(i,:);
    var1 = 2.*(x)*(invcovmat)*((avgdogtrain-avgcattrain)');
    var2 = (avgdogtrain*invcovmat*(avgdogtrain'))-(avgcattrain*invcovmat*(avgcattrain'));
    if var1 >= var2
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