

% x0 is initial point, f is function, fp is function's derivative
% r is the root used for error calculations.
% Use r = 1.530133508166616 for Problem 2, Programming part.
function newton = newton(x0, f, fp,r)
    err1= 0.00000001; % error tolerance = 10^-8 = 0.00000001
    i = 0; % Iteration counter
   
    xc = x0; % Current x
    fx = f(xc); % f(Current x)
    fpx = fp(xc); % f'(Current Step)
    xnp = xc - (fx / fpx); % Next Step; Newton Step
    ei = abs(xc - r); % Interpret r as the next Newton step
    %formatting for table
    
fprintf('__________________________________________________________________________
__________\n')
    fprintf(' i \t  | xi \t \t \t \t | ei = abs(xi - r)  | e_i/ (e_i-1)^2 \n')
    
fprintf('__________________________________________________________________________
__________\n')
    fprintf('%d \t  | %13.9f \t | %13.9f  \t | \t \n', i,xc,ei) 
    
    % Run Newton's Method to wanted tolerance
    while ( abs( f(xc) ) >  error)
        i = i + 1;
        % Update the xc, xn+1
        xc = xnp;
        xnp = xc - (f(xc)/ fp(xc));
        % Calculate current iteration error
        error_ratio = (abs(xc - r)) / (ei*ei);
        ei = abs(xc-r);
        %Print for table
        fprintf('%d  \t  | %13.9f  \t | %13.9f \t | %13.9f \n', 
i,xc,ei,error_ratio)
    end
    % An extra iteration for formatting the table
    xc = xnp;
    xnp = xc - (f(xc)/ fp(xc));
    ei = abs(xc - r);
    i = i + 1;
    fprintf('%d \t  | %13.9f \t | %13.9f  \t | \t \n', i,xc,ei) %formatting
    
    % Result
    newton = xnp;
end
