clc
clear;
%Define the system of equations with v = (xp,yp) & moved R.H.S to solve ekv(v) = 0
ekv = @(v) [(93-v(1))^2 + (63 - v(2))^2 - 55.1^2 ; (6-v(1))^2 + (16 - v(2))^2 - 46.2^2; (20-v(1))^2+(83-v(2))^2-46.2^2];

%Task a) Write the Gauss-Newton iteration, why do we use Gauss-Newton & not
%Newtons method?
%Methos uses the Jacobian matrix to ekv(v):
J = @(v) -2*[93-v(1), 63-v(2); 6-v(1), 16-v(2);20-v(1), 83-v(2)];

%xn+1 = 
theta = @(v) v + J(v)\-ekv(v); 

% It is Gauss-Newton as the SoE now has three equations and two unknowns,
% which means it will only have an approximate solution (Found through
% Gauss-Newton) in the Least-Squares sense

%b) Run Gauss-Newton with the answer from Labb1 as start guess:
guesses = [40.283656605002214,50.694601730035630;46.968869688612920,27.697545733763840];

%see fixpunkt.m for details
results = unique(fixpunkt(guesses, theta, 1e-14));

%c) Plot the circles and their solutions, are they at the intersections?
%What is expected?
%The circles do not intersect the point but that is because the Gauss
%Jordan function attempts to minimize the mean square error between all the
%different intersections of the circles, leading the best approximate solution
%to be found at a place between them all (42.4134 42.8719) having 
%||ekv(v)||2 = 1.310642e+04

%Split plot into functions of y
x = [-50:0.01:150];
topA = sqrt(55.1^2 - x.^2 +x.*186-93^2) +63 ;
botA = -sqrt(55.1^2 - x.^2 +x.*186-93^2) +63 ;

topB = sqrt(46.2^2 - x.^2+x.*12 -36) +16 ;
botB = -sqrt(46.2^2 - x.^2+x.*12 -36) +16 ;

topC = sqrt(46.2^2 - x.^2 +x.*40-40^2) +83;
botC = -sqrt(46.2^2 - x.^2 +x.*40-40^2) +83;

plot(x, topA);
hold on;
plot(x, botA);
plot(x, topB);
plot(x, botB);
plot(x, topC);
plot(x, botC);
grid on;
for i = 1:size(results, 2)
    plot(results(1,i), results(2,i), 'r .');
    fprintf('\n For root (');
    fprintf('%g ', results(:,i));
    fprintf(') MSE is %d \n', norm(ekv(results(:,i)))^2);
end
hold off;