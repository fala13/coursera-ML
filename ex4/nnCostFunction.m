function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%
% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% char func on y
ny = size(y,1);

%yv = zeros(ny,num_labels);

%for i = 1:ny
%  yv(i,y(i))=1;
%end;
yv = eye(num_labels)(y,:); % trick to convert y to vector of 0 and 1
% FP
X  = [ones(m, 1) X];
z2 = (X  * Theta1'); % 0.055ms
z2b = [ones(size(z2,1), 1) sigmoid(z2)];
z3 = (z2b * Theta2');
h = sigmoid(z3);
%[_, p] = max(h, [], 2);
%y = yv;
%y = bv;

% cost 
J=sum(sum((-yv.*log(h) - (1-yv).*log(1-h)))/m);
% reg
L= lambda/(2*m) * (sum(Theta1(:,2:end)(:).^2) + sum(Theta2(:,2:end)(:).^2));

J=J+L;

% errors
e3 = h - yv;
e2 = (Theta2(:,2:end)'*e3')'.* sigmoidGradient(z2); % 0.006 ms

% gradients 0.055 ms
%d1 = zeros(size(e2,2), size(X,2));
d1 = e2'*X ;
d2 = e3'*z2b;

% reg for grad
l1 = lambda/m*Theta1;
l2 = lambda/m*Theta2;
l1(:,1) = 0;
l2(:,1) = 0;
Theta1_grad = d1/(m) + l1;
Theta2_grad = d2/(m) + l2;
% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];

end
