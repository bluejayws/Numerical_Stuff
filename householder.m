

% For problem 1
% Given : A Coefficient Matrix A
% Given : Current column index
% Returns : An H_hat to be used with a reflector for the matrix A, and 
% to be inserted in the corresponding submatrix H
% householder(A,3) would give H3_hat for the 3rd column to perform on matrix H2H1A
function householder = householder(A, col_index)
    % Get counts of columns
    for i = 1: 1
        % Set up data for calculating H
        extract_vector = tril(A); % Since we look to zero below the entries of the 
diagonal of H_col_index*...*H_2*H_1*A
        x = nonzeros(extract_vector(:,col_index)); % Extract the vector below the 
diagonal to zero
        
        % Construct data  for Householder Reflector
        x_magnitude = norm(x);
        w = zeros(1, length(x))'; % Since we zero the n-1 entries under a column
        w(1) = x_magnitude;
        v = w - x;
        
        % Construct i-th Householder Matrix (Thm 4.4)
        constant = v'*v;
        rank_one_mtx = v * v';
        term = (2/constant) * rank_one_mtx;
        H = eye(length(v)) - term;
        
        householder = H;
    end
end
