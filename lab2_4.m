clc;
clear all;
R = 1;

% den vektorvärda funktionen
f = @(x)[R*cos(x(1)) + R*cos(x(2));
         R*sin(x(1)) + R*sin(x(2))];
     
% Jacobimatris där x = [x, y]
J = @(x)[R*-sin(x(1)), R*-sin(x(2));
         R*cos(x(1)), R*cos(x(2))];
     
% omdefinerad för att beräkna nollställe 
F = @(x)f(x) - [1.3; 1.3];

% fixpunkt-funktion
p = @(x) x - J(x)\F(x);

% önskad nogrannhet
d = 1e-10;

% stargissning 
x = [pi/2; pi/4];

diff = 1;
prev_diff = 1000;

fprintf("Finding root with starting guess x = [%s]\n", sprintf('%d ', x));
while abs(diff) > d
    diff = norm(p(x) - x);
    if abs(diff/prev_diff) > 1
         fprintf("The function is not converging. Aborting...\n");
         break;
    end
    x = p(x);
    fprintf("x: [%s]  diff: %d \n", sprintf('%d ',x), diff);
    prev_diff = diff;
end
fprintf("Solution found! angles: [%s] posititons: [%s] nogrannhet: %d \n", sprintf('%d ',x), sprintf('%d,',f(x)), diff);
plot_robotarm(x);

% tidssteg
h = 0.01;
t = 15;

% initialvärden
y = [pi/2;0;pi/6;0];

% givna faktorer
alpha = 2;
beta = 0.5;
gamma = 4;
omega = 3*pi;

% counter
k = 0;

% framåt euler
for t_n = 0:h:t
    k = k + 1;
    y = y + h*f_robotarm(y, t_n, x(1), x(2), alpha, beta, gamma, omega);
    if mod(k, 10) == 0 
        fprintf("y = [%s] t: %d\n", sprintf("%d\t", y), t_n);
        plot_robotarm([y(1);y(3)]);
    end
end
fprintf("y = [%s] t: %d\n", sprintf("%d\t", y), t_n);
pos = f([y(1);y(3)]);
fprintf("Finished at angles: [%s] position: (%d, %d)\n", sprintf("%d\t", [y(1);y(3)]), pos(1), pos(2) );