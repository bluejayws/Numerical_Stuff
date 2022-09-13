
function cosine = cosine(x)
    % Part A : Take the x point and map it to [-1,1] realm
    % For now, assume a = 0, b = pi/2, and x in [a,b]
    a = 0;
    b = pi / 2;
    % PART B:
    % Couldn't come up with a successful expression for n
    % Just assume we have 21 Cheveyshev nodes for interpolating
    % The subsequent 10 points will be used for P(x)
    n = 21; % 
    % Prepare the storage array for our Calculated Cheveyshev nodes
    chev_nodes = [1:n];
    
    % Populate Cheveyshev arrays
    for i = 1 : n
        
        scale_factor = (b-a) / 2;
        node1 = (2*i - 1)*pi;
        node2 = 2*n;
        node = cos( node1 / node2 );
        
        shift = (b+a) / 2;
        chev_nodes(i) = (scale_factor * node) + shift;
    end
    
    % Part C - Use Newtons Div. Diff to get P(x)
    % Get the odd cheveyshev nodes for use on polynomial calculation
    chev_nodes_base = chev_nodes(1:2:n);
    chev_nodes_values = cos(chev_nodes_base(1:length(chev_nodes_base)));
    % Using the provided divided_diff.m 
    baseTranspose = chev_nodes_base';
    valuesTranspose = chev_nodes_values';
    size = length(chev_nodes_base);
    
    % This is our polynomial, stored in a compact form as coefficients
    % Code Sample provided was adapted to this project
    coeff = divided_diff(baseTranspose,valuesTranspose,size);
    
    % Part II, and Part D - Use nested multiplecation to evaluate P(x)
    % Used the provided mynest.m from the project page and adapted it to
    % this calculator program
    % Since Cosine is symmetric along the y-axis, we can just take any
    % negative value and multiply by negative 1 to restrict it to positive
    % real numbers
    if x < 0 
        x = -1 * x;
%         x;
    end
    % Reduce the period of the value
    x_reduced = mod(x, (2*pi));
%     x_reduced;
    % Then we do a chain of if-statements to shift back the values that lie
    % in quadrants 2,3, or 4 of the unit circle, back into quadrant 1 of
    % the unit circle
    quadrant_sign = 1; % For case if 0 <= x <= pi/2
    x_initial = x_reduced * 1.0; % For calculating correct sign
    if x_reduced > pi / 2
        quadrant_sign = -1;
        if x_reduced > pi
            quadrant_sign = -1;
            if x_reduced > (3*pi) / 2
                quadrant_sign = 1;
            end
        end
    end
    % Now, we shift back x, correspondingly
    % Invariant: x_reduced < 2*pi = 6.2831853
    if x_reduced > (3*pi) / 2
        % Problem, in the region 3pi/2 < x < 2pi, we can't shift back as
        % easy. For example, if x = 2*pi, then we have to shift back by
        % 2*pi. If x = 3*pi / 2, we shift back by pi. So, we cannot just
        % shift back with this scalar.
        % Attached in the pdf file shows my reasoning (Figure 1), but, it 
        % boils down to just subtract by ( (3*pi) / 2) /2 = (3*pi) / 1.
        
        x_reduced = x_reduced - ((3*pi) / 1);
        x_reduced = -1 * x_reduced;
    end
    if x_reduced > pi
%         fprintf("Xr > pi\n")
        x_reduced = x_reduced - (pi/2);
%         x_reduced;
    end
    if x_reduced > pi / 2
        x_reduced = x_reduced - (pi/2);
%         x_reduced;
    end
    
    v = [x_reduced]';
    value = quadrant_sign * mynest(size-1, coeff', v, chev_nodes_base );
    cosine = value;
    % Code to print the error
%     error = cos(x_reduced) - value;
%     fprintf("| cos(%.12f) - P(%.12f) | = %.12f - %.12f = %.12f\n",x_reduced, 
x_reduced, cos(x_reduced), value, error)
%     cosine = value;
end
