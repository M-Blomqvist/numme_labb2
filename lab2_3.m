clc;
clear all;

%%%%%%%%%
% a)
%%%%%%%%%

% constants
s = 2;
beta = 1;
theta_v = 40;

%integranden för nämnaren

f = @(t)exp(-beta*t.^2);
% beräkna integralen med trapetsregeln

h = 1e-7;
% diskretisera
x = -s:h:s;
y = zeros(size(x));
for i = 1:size(x,2) 
    y(i) = f(x(i));
end

I = h*(sum(y) - y(1)/2 - y(size(x, 2))/2);

fprintf("a) Denominator: %1.16d with h: %d\n", I, h);

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

I1 = h*(sum(y) - y(1)/2 - y(size(x, 2))/2);
time = toc(start);
fprintf("b) Numerator trapezoid: %1.16d with h: %d time: %ds\n", I1, h, time);

% beräknat i a)
bottom = 1.7641627815248;

m_1 = I1/bottom;

fprintf("m = %d with h = %d\n", m_1, h);

%%%%% Nytt h
start = tic;

% beräkna integralen med trapetsregeln

h = 5e-2;
% diskretisera
x = -s:h:s;
y = zeros(size(x));
for i = 1:size(x,2) 
    y(i) = f(x(i));
end

I5 = h*(sum(y) - y(1)/2 - y(size(x, 2))/2);
time = toc(start);
fprintf("b) Numerator trapezoid: %1.16d with h: %d time: %ds\n", I5, h, time);

% bottom beräknat i a)
m_2 = I5/bottom;

fprintf("m = %d with h = %d\n", m_2, h);

% calculate diff

diff_m = abs(m_2 - m_1);
diff_i = abs(I5 - I1);
fprintf("differance in m = %d\n differance in numerator = %d\n ", diff_m, diff_i);

%%%%%%%%
% c)
%%%%%%%%

start = tic;

% beräkna integralen med simpsons

h1 = 1e-1;
% diskretisera
x = -s:h1:s;
y = zeros(size(x));
for i = 1:size(x,2)
    y(i) = f(x(i));
end

I1 = (h1/3)*(y(1) + 2*sum(y(3:2:(size(x,2)-1))) + 4*sum(y(2:2:(size(x,2)-1))) + y(size(x,2)));
time = toc(start);
fprintf("c) Numerator simpson: %1.16d with h: %d time: %ds\n", I1, h1, time);

% beräkna integralen med simpsons h= 0.5
start = tic;

h5 = 5e-2;
% diskretisera
x = -s:h5:s;
y = zeros(size(x));
for i = 1:size(x,2)
    y(i) = f(x(i));
end

I5 = (h5/3)*(y(1) + 2*sum(y(3:2:(size(x,2)-1))) + 4*sum(y(2:2:(size(x,2)-1))) + y(size(x,2)));
time = toc(start);
fprintf("c) Numerator simpson: %1.16d with h: %d time: %ds\n", I5, h5, time);

% bottom beräknat i a)

m_21 = I1/bottom;
m_25 = I5/bottom;
fprintf("m = %d with h = %d\n", m_21, h1);
fprintf("m = %d with h = %d\n", m_25, h5);
% calculate diff
 
diff_m = abs(m_25 - m_21);
diff_i = abs(I5 - I1);
fprintf("differance in m = %d\n differance in numerator = %d\n", diff_m, diff_i);