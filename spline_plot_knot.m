

%%%%%%%%%%%% PROBLEM 2 PART II %%%%%%%%%%%%%%
% Takes a fourth vector (2x1 matrix) to plot a spline through the three points and 
the
% user defined point, e
function spline_plot_knot = spline_plot_knot(e)
    X = [0 1/2 1 e(1)];
    Y = [1 0 1 e(2)];
    n = length(X);
    % Make auxiliary arrays for the coefficient matrix calculation step
    a = [1:(n-1)];
    delta = [1:(n-1)]; % Lowercase delta; x_(i+1) + x_i
    DELTA = [1:(n-1)]; % Uppercase delta; y_(i+1) + y_i
    
    % Fill the aforementioned arrays with relevant info
    for i = 1 : (n-1)
        a(i) = Y(i);
        delta(i) = ((X(i+1)) - (X(i)));
        DELTA(i) = (Y(i+1) - Y(i));
    end
    % Make the arrays needed for a Tridiagonal Matrix
    % Here, we really just fill it with placeholder data, but set it to the
    % correct size for our Tridiagonal matrix A
    TOP = [2:(n-1)]; % Top vector along the diagonal; 
    MID = [1:((n-1)+1)]; % Middle vector along the diagonal;
    BOT = [1:((n-2))]; % Bottom vector along the diagonal;
    
    % Now we fill the TOP, MID and BOT vectors for our Tridiagonal Matrix
    
    % TOP
    TOP(1) = -1 * (delta(1) +delta(2)); %Not a Knot Condition
    for i = 2 : n-1
        TOP(i) = delta(i);
    end
    %MID
    MID(1) = delta(2); % Not a Knot Condition
    for i = 2 : n-1
        MID(i) = (2*(delta(i-1))) + (2*(delta(i))); 
    end
    MID(n) = delta(n-2); % Not a Knot Condition
    %BOT
    for i =  1 : n-2 
        BOT(i) = delta(i);
    end
    BOT(n-1) = -1 * (delta(n-2) + delta(n-1)); % Not a Knot Condition
    
    A = diag(MID) + diag(TOP,1) + diag(BOT, -1);
    
    % After constructing our Tridiagonal Matrix, we can manually add the
    % rest of the Not-A-knot conditions.
    A(1,3) = delta(1);
    A(n,n-2) = delta(n-1);
    
    %%%%%%%%%%% NOT-A-KNOT CODE BLOCK %%%%%%%%%%%%%%%%%%%%%
    EC = [1:n];
    EC(1) = 0;
    EC(n) = 0;
    for i = 2 : n-1
        endcondcoeff = 3 * ( ( DELTA(i) / delta(i) ) - (DELTA(i-1) / delta(i-1)) );
        EC(i) = endcondcoeff;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Get the solution
    % Using Tamas Kis (2022). Tridiagonal Matrix Algorithm (Thomas Alg.)
    % (tridiagonal) 
(https://github.com/tamaskis/tridiagonal-MATLAB/releases/tag/v5.1.0),
    % GitHub. Retrieved May 4, 2022. (Attached in the zip as 'tridiagonal.m')
    C = tridiagonal(A, EC)';
    
    % Calculate the rest of the coefficients
    % Auxiliary Arrays for d_i, and b_i
    D = [1:n];
    B = [1:n];
    
    % Fill the aforementioned arrays
    for i = 1 : n-1
        D(i) = (C(i+1) - C(i)) / (3*delta(i));
        b1 = (DELTA(i) / delta(i));
        b2 = -1 * (delta(i) / 3);
        b3 = (2 * C(i)) + C(i+1);
        B(i) = b1 + b2*b3;
    end
    % Plot
    coeff = [ D(1:n-1) C(1:n-1) B(1:n-1) Y(1:n-1) ];
    breaks = X;
    P = mkpp(breaks, coeff);
    xx = linspace(1.5*min(X),1.5*max(X));
    yy = ppval(xx,P);
    plot(xx,yy,'LineWidth',2)
    
    hold on
    plot(X,Y, 'O', 'markersize', 7)
    yline(0)
    hold off
    spline_plot_knot = C;
end
