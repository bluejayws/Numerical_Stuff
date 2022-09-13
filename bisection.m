function bisection = bisection(a,b,f,TOL)
    if f(a) * f(b) < 0
        c = (b+a) / 2;
        error_interval = (b-a) / 2;
        steps = 0;
        
        N = ceil(( log(1/TOL) / log(2) ) - 1);
        fprintf("Step   a             b             c             f(c)\n")
        for k = 1 : N
            c = (b+a) / 2;
            if f(c) * f(b) < 0
                a = c;
            else
                b = c;
            end
            
            error_interval = (b-a) / 2;
            fprintf('%2d, %12.7f, %12.7f, %12.7f, %12.7f\n',k,a,b,c,f(c))
            steps = steps + 1; 
            
        end
        bisection = (b+a)/2;
    else 
        fprintf('Invalid bounds; Intermediate Value Theorem not applicable, make 
sure bounds differ in sign\n')
    end
end
% 2(a) : bisection(0,1, @(x) 230*(x^4) + 18*(x^3) + 9*(x^2) - 221*(x) - 9, 10^-6)
% 2(b) : bisection(0,1, @(x) 1+log(1+(x^2)), 10^-6)
% 2(c) : bisection(1,2, @(x) ((exp(1))^x) + (2^(-x)) + 2*cos(x)-6, 10^-6) 
