
% For Problem 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Start with sampling the 20 points by:
%   -> Picking 20 base points between [0, 2*pi], sort
%   -> Evaluate those base points using the function definition
% rng(0);
% a = 0;
% b = 2* pi;
% r = (b-a) * rand(20,1) + a;
% r = sort(r);
% r_range = [min(r) max(r)] ;
                % Store the results for consistent data, r = x
xt = [0.6129 0.7979 0.8915 0.9903 1.7499 2.6500 3.0497 3.4362 3.9732 4.9776...
        5.0283 5.1191 5.6913 5.7389 5.7537 6.0141 6.0162 6.0287 6.0626 6.0984]';
                % Finish constructing the sample. 
% Since our random data is between 0 and 2*pi, we can just use the 
% condition of f(xi) = 1 for x < pi, and f(xi) = -1 for x >= pi
% syms x
% y4 = piecewise( x < pi, 1, x >= pi, -1); % 
% sample = subs(y, x,r);
% Store the outputs the correspond to the saved r on line 14
yt = [1, 1, 1, 1, 1, 1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]';
                % Set up data and solve
% Pn
n = 11;
fprintf("\n____________________________________________________________\n")
fprintf("Coefficient Matrix (for n = %d) \n", n)
coeff_xt = construct_coeff(xt, n) % Coefficient Matrix
fprintf("\n____________________________________________________________\n")
fprintf("RHS vector of linear system for ck")
yt
fprintf("\n____________________________________________________________\n")
% Set up Normal Equation
fprintf("Normal Equation | lhs matrix (A' * A) \n")
lhs = coeff_xt'*coeff_xt
fprintf("Normal Equation | rhs matrix (A' * b) \n")
rhs = coeff_xt'*yt
fprintf("Normal Equation | solution vector (x) : [")
for i = 1 : n
    fprintf("c%d ", i)
end
fprintf("]")
fprintf("\n____________________________________________________________\n")
% Find ck via augmented matrix
x_ans  = rref( [lhs rhs] );
fprintf("Ck determined by solving Normal Equation \n")
for i = 1 : length(x_ans(:,n+1)) %n+1 column for augmented matrix
    fprintf("c%d = %f \n", i,x_ans(i,n+1))
end
% Polynomial Equation
fprintf("\ny = (%f * sin(x))", x_ans(1,n+1))
for i = 2 : length(x_ans(:,n+1))
    fprintf(" + (%f * sin(%d*x))",x_ans(i,n+1),i)
end
fprintf("\n____________________________________________________________\n")
                % SE, RMSE
% Find the residual r
r = yt - (coeff_xt * x_ans(:,n+1));
%   SE
r_sq = r.^2;
SE = sum(r_sq, 'all');
%   RMSE
RMSE = sqrt(SE) / sqrt(length(r));
fprintf("SE = %.8f \nRMSE = %.8f\n",SE,RMSE)
                % Plot
% Original Function
f = mkpp( [0 pi 2*pi], [ 0 0 1; 0 0 -1 ]);
% Bounds
x=[0: 0.001:2*pi];
% Pn's
p3 =  (1.269686 * sin(x)) + (-0.035999 * sin(2*x)) + (0.518932 * sin(3*x));
p7 =  (1.294208 * sin(x)) + (-0.051513 * sin(2*x)) + (0.435699 * sin(3*x)) + 
(0.078957 * sin(4*x)) + (0.168643 * sin(5*x)) + (-0.072407 * sin(6*x)) + (0.290679 
* sin(7*x));
p11 = (0.679613 * sin(x)) + (0.564123 * sin(2*x)) + (0.592514 * sin(3*x)) + (-
0.908441 * sin(4*x)) + (0.881646 * sin(5*x)) + (0.355940 * sin(6*x)) + (-0.799849 *
sin(7*x)) + (0.441794 * sin(8*x)) + (0.471813 * sin(9*x)) + (-0.606712 * sin(10*x))
+ (0.352647 * sin(11*x));
plot(x,p3 ,'--')
title('f(x), p3, p7, p11')
hold on
plot(x,p7,'r:')
plot(x,p11,'-.')
plot(x, ppval(x, f), "-")
plot(xt,yt,'kx','LineWidth',1)
legend("P3 (x)", "P7 (x)", "P11(x)", "f(x)", "Sample Points")
hold off
