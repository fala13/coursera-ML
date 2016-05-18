function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%

X = [ones(m, 1) X];
size(X);
z2= sigmoid(X * Theta1');
size(z2);
z2 = [ones(size(z2,1), 1) z2];
size(z2);
z3 = sigmoid(z2 * Theta2');
%ok
[_, p] = max(z3, [], 2);

%X = [ones(m, 1) X];
%size(X);
%z2= (Theta1 * X');
%size(z2)
%z2 = [ones(size(z2,1), 1) z2]
%size(z2)
%z3 = Theta2 * z2'
%%ok
%[_, p] = max(z3, [], 1);

p=p(:);



% =========================================================================


end
