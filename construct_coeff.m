% For Problem 3
% Given : n = for P_n(x)
% Given : input vector x of size m-by-1
% Returns : Corresponding coefficient matrix of size m-by-n
function construct_coeff = construct_coeff(x,n)
    coeff = eye(length(x),n); % Placeholder matrix for construction
    
%     i = 1;
    for r = 1 : length(x) %  row
        for c = 1 : n     %  column
%             coeff(r,c) = i;
            coeff(r,c) = sin(x(r) * c);
%             i = i + 1;
        end
    end
    construct_coeff = coeff;
end
