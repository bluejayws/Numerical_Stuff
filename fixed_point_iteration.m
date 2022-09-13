
% See complete numerical results in the 'Numerical Results Iteration
% Processe.txt' file
%r1 = -1.641783527452926
%   g1 = @(x) ( 1 / ( (2 * x) * (x - sqrt(3) ))) - (sqrt(3))
%   Arbitrarily choose 1 as x0
%   fixed_point_iteration(g1, 1, r1) in 9 iterations for desired accuracy
%r2 =  -0.168254401764093
%   g2 = @(x) ( 1 / ( 2 * ( (x^2) - 3)))
%   Arbitrarily choose 1 as x0
%   fixed_point_iteration(g2, 1, r2) in 6 iterations for desired accuracy
%r3 = 1.810037929236685
%   g3 = @(x) ( 1 / ( (2*x) * (x + sqrt(3)))) + (sqrt(3))
%   Arbitrarily choose 1 as x0
%   fixed_point_iteration(g3, 1, r3) in 7 iterations for desired accuracy
function fixed_point_iteration = fixed_point_iteration(g, x0, r)
    error = 0.00000001; % Hardcoded 10^-8 = 0.00000001
    
    x1 = x0; %x_i
    xp1 = g(x0); %x_i+1
    ei = 0; % e_i
    eim1 = 0; %e_i-1
    i=0;
    
fprintf('__________________________________________________________________________
__________\n')
    fprintf('i \t | xi \t \t \t \t | g(xi) \t \t \t| ei = abs(xi - r)\t| e_i/e_i-
1 \n')
    
fprintf('__________________________________________________________________________
__________\n')
    while(abs(xp1 - r) > error)
        x1 = xp1;
        xp1 = g(xp1);
        if i == 0 % If first iteration, there's no e_i-1. Just for table 
formatting.
            ei = abs(xp1-r);
            fprintf('%d \t | %13.9f \t | %13.9f \t| %13.9f \t| \t \n', i, x1, xp1, 
ei)
        else
            eim1 = ei;
            ei = abs(xp1-r);
            error_ratio = ei/eim1;
            fprintf('%d \t | %13.9f \t | %13.9f \t| %13.9f \t| %13.9f \t \n', i, 
x1, xp1, ei, error_ratio)
        end
        i = i+1;
    end
    % formatting for last line of table as in page 39 of book
    x1 = xp1;
    xp1 = g(xp1);
    ei = abs(xp1-r);
    fprintf('%d \t | %13.9f \t | %13.9f \t| %13.9f \t|  \t \n', i, x1, xp1, ei)
    fixed_point_iteration = g(x1);
end
