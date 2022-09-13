
x = [0.24 0.65 0.95 1.24 1.73 2.01 2.23 2.52 2.77 2.99]';
b = [0.23 -0.26 -1.10 -0.45 0.27 0.10 -0.29 0.24 0.56 1.00]';
A = [log(x( 1 )) cos(x( 1 )) exp(x( 1 ));...
    log(x( 2 )) cos(x( 2 )) exp(x( 2 ));...
    log(x( 3 )) cos(x( 3 )) exp(x( 3 ));...
    log(x( 4 )) cos(x( 4 )) exp(x( 4 ));...
    log(x( 5 )) cos(x( 5 )) exp(x( 5 ));...
    log(x( 6 )) cos(x( 6 )) exp(x( 6 ));...
    log(x( 7 )) cos(x( 7 )) exp(x( 7 ));...
    log(x( 8 )) cos(x( 8 )) exp(x( 8 ));...
    log(x( 9 )) cos(x( 9 )) exp(x( 9 ));...
    log(x( 10 )) cos(x( 10 )) exp(x( 10 ));];
% b = [3 1 1 -3]';
% A = [1 4; -1 1; 1 1; 1 0]
[rows, cols] = size(A);
% This variable represents the intermediate steps of the QR process with
% householde reflectors. For k<=n, we have form Hk*Hk-1*...*H2*H1*A for the
% kth step.
R = eye(rows) * A; % Initialize as identity for first iteration loop
% This will store the series of reflectors
Q = eye(rows);
for i = 1: cols
    
    % Calculate the household reflect
    h_hat = householder(R,i);
    % Append H_hat to the bottom right corner if identity matrix
    % Note, we already calculated the
    sub_size = [i:rows]; % Get bottom right corner dimensions
    H = eye(rows); % Initialize Identity matrix
    H(sub_size,sub_size) = h_hat; % Using submatrix dimenstion, insert h_hat
    % Update Q
    % On last iteration, we get R
    R = H*R;
    Q = Q * H;
end
%%%%%%%%%%%%%%%%%%%%%%%%%% Results %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output Q and R
Q
R
% Output a,b,c
fprintf("Coefficients C1,C2,C3 (respectively):\n")
coeff = R\(Q'*b)
% Output SE and RMSE
r = b - (A * coeff);
% Find SE
r_sq = r.^2;
SE = sum(r_sq, 'all')
% Find RMSE
RMSE = sqrt(SE) / sqrt(length(r))
