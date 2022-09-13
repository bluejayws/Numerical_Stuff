

% Least Sqaures Regression
% x-vector : [0.24 0.65 0.95 1.24 1.73 2.01 2.23 2.52 2.77 2.99]
% y-vector : [0.23 -0.26 -1.10 -0.45 0.27 0.10 -0.29 0.24 0.56 1.00]
% Calculate the Coefficient matrix for the system
x = [0.24 0.65 0.95 1.24 1.73 2.01 2.23 2.52 2.77 2.99]';
% Part A : Coefficient matrix, and RHS vector of the system
fprintf("RHS Vector (b): ")
b = [0.23 -0.26 -1.10 -0.45 0.27 0.10 -0.29 0.24 0.56 1.00]'
fprintf("Coefficient Matrix (A) :")
A = [log(x( 1 )) cos(x( 1 )) exp(x( 1 ));...
    log(x( 2 )) cos(x( 2 )) exp(x( 2 ));...
    log(x( 3 )) cos(x( 3 )) exp(x( 3 ));...
    log(x( 4 )) cos(x( 4 )) exp(x( 4 ));...
    log(x( 5 )) cos(x( 5 )) exp(x( 5 ));...
    log(x( 6 )) cos(x( 6 )) exp(x( 6 ));...
    log(x( 7 )) cos(x( 7 )) exp(x( 7 ));...
    log(x( 8 )) cos(x( 8 )) exp(x( 8 ));...
    log(x( 9 )) cos(x( 9 )) exp(x( 9 ));...
    log(x( 10 )) cos(x( 10 )) exp(x( 10 ));]
fprintf("\n____________________________________________________________\n")
% Part B : Find a,b,c via the normal equation
ata = A' * A; % (3 x 10) x (10 x 3) = 3 x 3
atb = A' * b; % (3 x 10) x (10 x 1) = 3 x 1
fprintf("Normal Equation (A'Ax) :")
ata
fprintf("Normal Equation (A'b) :")
atb
fprintf("\n____________________________________________________________\n")
% Solve augmented matrix of the normal equations
C  = rref( [ata atb] ); % a = -1.0410, b = -1.2613, c = 0.0307
% Part C : Out a,b,c determined by solving the normal equation
coeff = C(:,4);
fprintf("Coefficients C1,C2,C3 (respectively):\n")
coeff
fprintf("\n____________________________________________________________\n")
% Part D: Print the SE, and RMSE by solving the normal equation
% Find the residual r
r = b - (A * C(:,4));
% Find SE
r_sq = r.^2;
SE = sum(r_sq, 'all')
% Find RMSE
RMSE = sqrt(SE) / sqrt(length(r))
% fprintf("SE = %.7f, RMSE = %.7f \n", SE, RMSE)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
