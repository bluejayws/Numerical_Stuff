% Cubic Splines 
x = [0;1;2;3;4;5];%6;7;8;9;10];           % data points
y = [3;1;4;1;2;0];%2;-1;5;8;6];                            
n = length(x);
dx = x(2 : n) - x(1 : n - 1);             % delta_x
dy = y(2 : n) - y(1 : n - 1);             % delta_y
dy_dx = dy./dx;                           % delta_y/delta_x  
% Natural: Compute coefficients, b,c,d, of cubic polynomials.
c = zeros(n,1);
Mc = 2*diag(dx(1 : n - 2) + dx(2 : n - 1)) + diag(dx(2 : n - 2),-1) + diag(dx(2 : n
- 2),1);
Vc = 3*(dy_dx(2 : n - 1) - dy_dx(1 : n - 2)); 
c(2 : n - 1) = Mc\Vc;
d = (c(2 : n) - c(1 : n - 1))/3;
d = d./dx;                        
b = dy_dx - dx.*(2*c(1 : n - 1) + c(2 : n))/3;
% Plot
Coeffs = [d c(1 : n - 1) b y(1 : n - 1)];
breaks = x;
P1 = mkpp(breaks,Coeffs);
xx = linspace(min(x),max(x));
yy = ppval(xx,P1);
plot(xx,yy,'LineWidth',2)
Mc1 = zeros(n - 2,n);
Mc1(:,2 : n - 1) = Mc;
Mc1(1,1) = dx(1);
Mc1(n - 2,n) = dx(n - 1);
% Curvature-adjusted: Compute coefficients, b,c,d, of cubic polynomials.
v1 = 20; vn = -20;
Mc2 = zeros(n);
Mc2(2 : n - 1,:) = Mc1;
Mc2(1, 1) = 2;
Mc2(n, n) = 2;
Vc2 = [v1; Vc; vn];
c = Mc2\Vc2;
d = (c(2 : n) - c(1 : n - 1))/3;
d = d./dx;                        
b = dy_dx - dx.*(2*c(1 : n - 1) + c(2 : n))/3;
% Plot
Coeffs = [d c(1 : n - 1) b y(1 : n - 1)];
P1 = mkpp(breaks,Coeffs);
yy = ppval(xx,P1);
hold on
plot(xx,yy,'LineWidth',2)
% Clamped: Compute coefficients, b,c,d, of cubic polynomials.
v1 = 0; vn = 0;
Mc2 = zeros(n);
Mc2(2 : n - 1,:) = Mc1;
Mc2(1, 1 : 2) = [2*dx(1) dx(1)];
Mc2(n, n - 1 : n) = [dx(n - 1) 2*dx(n - 1)];
Vc2 = [3*(dy_dx(1) - v1); Vc; 3*(vn - dy_dx(n - 1))];
c = Mc2\Vc2;
d = (c(2 : n) - c(1 : n - 1))/3;
d = d./dx;                        
b = dy_dx - dx.*(2*c(1 : n - 1) + c(2 : n))/3;
% Plot
Coeffs = [d c(1 : n - 1) b y(1 : n - 1)];
P1 = mkpp(breaks,Coeffs);
yy = ppval(xx,P1);
plot(xx,yy,'LineWidth',2)
% Parabolically terminated: Compute coefficients, b,c,d, of cubic polynomials.
Mc2 = zeros(n);
Mc2(2 : n - 1,:) = Mc1;
Mc2(1, 1 : 2) = [1 -1];
Mc2(n, n - 1 : n) = [1 -1];
Vc2 = [0; Vc; 0];
c = Mc2\Vc2;
d = (c(2 : n) - c(1 : n - 1))/3;
d = d./dx;                        
b = dy_dx - dx.*(2*c(1 : n - 1) + c(2 : n))/3;
% Plot
Coeffs = [d c(1 : n - 1) b y(1 : n - 1)];
P1 = mkpp(breaks,Coeffs);
yy = ppval(xx,P1);
plot(xx,yy,'LineWidth',2)
% Not-a-knot: Compute coefficients, b,c,d, of cubic polynomials.
Mc2 = zeros(n);
Mc2(2 : n - 1,:) = Mc1;
Mc2(1, 1 : 3) = [dx(2) -dx(1)-dx(2) dx(1)];
Mc2(n, n - 2 : n) = [dx(n - 1) -dx(n - 2)-dx(n - 1) dx(n - 2)];
Vc2 = [0; Vc; 0];
c = Mc2\Vc2;
d = (c(2 : n) - c(1 : n - 1))/3;
d = d./dx;                        
b = dy_dx - dx.*(2*c(1 : n - 1) + c(2 : n))/3;
% Plot
Coeffs = [d c(1 : n - 1) b y(1 : n - 1)];
P1 = mkpp(breaks,Coeffs);
yy = ppval(xx,P1);
plot(xx,yy,'LineWidth',2)
legend('natural','curvature','clamped','parabolic','not-a-knot')
plot(x,y,'ro','LineWidth',2)
