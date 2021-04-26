clc;
clear all;

%%%%%%%%%
% a)
%%%%%%%%%

% cosntants
s = 2;
beta = 1;
theta_v = 40;

%integranden för nämnaren

f = @(t)exp(-beta*t.^2);
% beräkna integralen med trapetsregeln

h = 1e-1;
% diskretisera
x = -s:h:s;
y = zeros(size(x));
for i = 1:size(x,2) 
    y(i) = f(x(i));
end

I = h*(sum(y) - y(1)/2 - y(size(x, 2))/2);

fprintf("a) Integral: %1.16d with h: %d\n", I, h);

%%%%%%%%%
% b)
%%%%%%%%%

start = tic;

m = @(theta) max(generator(theta, 0));
% integranden för täljaren
f = @(t) exp(-beta*t^2)*m(theta_v + t);

% beräkna integralen med trapetsregeln

h = 1e-1;
% diskretisera
x = -s:h:s;
y = zeros(size(x));
for i = 1:size(x,2) 
    y(i) = f(x(i));
end

I = h*(sum(y) - y(1)/2 - y(size(x, 2))/2);
time = toc(start);
fprintf("b) Integral: %1.16d with h: %d time: %ds\n", I, h, time);

% beräknat i a)
bottom = 1.7641627815248;

m_1 = I/bottom;

fprintf("m = %d with h = %d\n", m_1, h);

%%%%% Nytt h
start = tic;

m = @(theta) max(generator(theta, 0));
% integranden för täljaren
f = @(t) exp(-beta*t^2)*m(theta_v + t);

% beräkna integralen med trapetsregeln

h = 0.5e-1;
% diskretisera
x = -s:h:s;
y = zeros(size(x));
for i = 1:size(x,2) 
    y(i) = f(x(i));
end

I = h*(sum(y) - y(1)/2 - y(size(x, 2))/2);
time = toc(start);
fprintf("b) Integral: %1.16d with h: %d time: %ds\n", I, h, time);

% beräknat i a)
bottom = 1.7641627815248;

m_2 = I/bottom;

fprintf("m = %d with h = %d\n", m_2, h);

% calculate diff

diff = abs(m_2 - m_1);
fprintf("differance = %d\n", diff);

%%%%%%%%
% c)
%%%%%%%%

start = tic;

m = @(theta) max(generator(theta, 0));
% integranden för täljaren
f = @(t) exp(-beta*t^2)*m(theta_v + t);

% beräkna integralen med simpsons

h = 1e-1;
% diskretisera
x = -s:h:s;
y = zeros(size(x));
for i = 1:size(x,2) 
    y(i) = f(x(i));
end

I = (h/3)*(y(1) + 4*sum(y(3:2:(size(x,2)-1))) + 2*sum(y(2:2:(size(x,2)-1)) + y(size(x,2))));
time = toc(start);
fprintf("b) Integral: %1.16d with h: %d time: %ds\n", I, h, time);

% beräknat i a)
bottom = 1.7641627815248;
 
m_2 = I/bottom;

fprintf("m = %d with h = %d\n", m_2, h);
% 
% % calculate diff
% 
% diff = abs(m_2 - m_1);
% fprintf("differance = %d\n", diff);





