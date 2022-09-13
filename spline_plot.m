
%%%%%%%%%%%% PROBLEM 2 PART I %%%%%%%%%%%%%%
    % This function can calculate the coefficients of the splines
    % for a given data set, for both Natural Conditions or
    % Clamped Conditions
    % Uncomment/recomment the relevant TOP,MID, and BOT variables for
    % the desired end conditions
% Takes vector of base points X, and vector of values Y, and amount of data
% points n
function spline_plot = spline_plot(X,Y,v1,vn)
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
    %TOP(1) = 0; % NATURAL END CONDITION; This vector starts with 0
    TOP(1) = delta(1); %CLAMPED END CONDITION
    for i = 2 : n-1
        TOP(i) = delta(i);
    end
    %MID
    % MID(1) = 1; %NATURAL END CONDITION;
    
    MID(1) = 2 * delta(1); %CLAMPED END CONDITION
    for i = 2 : n-1
        MID(i) = (2*(delta(i-1))) + (2*(delta(i))); 
    end
    MID(1) = 2 * delta(n-1); %CLAMPED END CONDITION
    % MID(n) = 1; %NATURAL END CONDITION;
    %BOT
    for i =  1 : n-2 % ((n-2))+1 = n-1 
        BOT(i) = delta(i);
    end
    BOT(n-1) = delta(n-1); % Clamped Condition
    %BOT(n-1) = 0;% Natural End Condition
    
    A = diag(MID) + diag(TOP,1) + diag(BOT, -1);
    
    
    %%%%%%%%%%%%%%NATURAL CONDITION CODE BLOCK%%%%%%%%%%%%%%%%%%%
    % Here, pass anything for the arguments (or remove them) and uncomment
    % to use
    % Natural End Conditions Vector (EC)
%     EC = [1:n];
%     EC(1) = 0;
%     EC(n) = 0;
% 
%     for i = 2 : n-1
%         endcondcoeff = 3 * ( ( DELTA(i) / delta(i) ) - (DELTA(i-1) / delta(i-
1)) );
%         EC(i) = endcondcoeff;
%     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%% CLAMPED CONDITION CODE BLOCK %%%%%%%%%%%%%%%%%%%%%
    EC = [1:n];
    EC(1) = 3 * ( (DELTA(1) / delta(1) ) - v1 ) ;% Clamped condition 1
    EC(n) = 3 * ( vn - ( DELTA(n-1) / delta(n-1) ) ); %Clamped condition 2
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
    % >> t = [0, 30, 60, 80, 105, 125, 140, 175, 240, 278] ./ 60
    % >> y = [0, 29, 61, 74, 89, 99, 122, 149, 253, 262]
    % >> spline_plot(t,y,0,0)
    %       ans = 143.5765  -15.7272  -44.6676   21.9287  -64.8094  210.2313 -
150.6669  105.2756 -105.1263    2.3948
    % Which means we plot the following 
    coeff = [ D(1:n-1) C(1:n-1) B(1:n-1) Y(1:n-1) ];
    breaks = X;
    P = mkpp(breaks, coeff);
    xx = linspace(1.5*min(X),1.5*max(X));
    yy = ppval(xx,P);
    plot(xx,yy,'LineWidth',2)
    
    hold on
    plot(X,Y, 'O', 'markersize', 7)
    xlim([(1.5*X(1)) (1.5*X(n))])
    ylim([(1.5*min(Y)) (1.5*max(Y))]) 
    hold off
    spline_plot = C;
end
