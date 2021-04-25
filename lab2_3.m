clc;
clear all;

%m = @(theta) max(generator(theta, 0));
% integranden för täljaren
%f = @(t) exp(-beta*t^2)*m(theta_v + t);

% cosntants
s = 2;
beta = 1;
theta_v = 40;

%integranden för nämnaren

f = @(t)exp(-beta*t^2);
% beräkna integralen med trapetsregeln

h = 1e-1;
% diskretisera
x = -s:h:s;
y = zeros(size(x));
for i = 1:size(x,2) 
    y(i) = f(x(i));
end

I = h*(sum(y) - y(1)/2 - y(size(x, 2))/2);

fprintf("Integral: %1.16d with h: %d\n", I, h);

