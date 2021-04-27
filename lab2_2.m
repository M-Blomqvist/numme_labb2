clc
clear;
ekv = @(v) sqrt(v+2);

%a) Plot the integrand & calculate it algebraically
% EKV(v) = [(2/3)*(v+2)^(3/2)] => I = [EKV(1)- EKV(-1)] = 2*sqrt(3)-(2/3)
% ~= 2.797
x = [-1:0.001:1];
plot(x, ekv(x), 'r')
grid on;
hold on;

%b) Approximate I using the Trapezoidal rule for h = 1,
%0.5,0.25,0.125,0.0625
% yes the approximations seem to converge as h->0
hs = [1,0.5,0.25,0.125,0.0625]
T = @(h) h*(sum(ekv([-1:h:1]))-(ekv(-1)+ekv(1))/2);
results = zeros(size(hs));
for i= 1:size(hs,2)
    h = hs(i);
    fprintf('Trapezoid using h = %d \n', h);
    xs = [-1:h:1];
    ys = ekv(xs);
    results(i) = T(h);
    %check correctness of function
    if results(i) - trapz(ys) > 1e-14
       fprintf('Bad trapezoid rule implementation!');
    end
    plot(xs,ys, 'c --');
    pause
end
hold off;
%c) Calculate the error for each approximation. What does theory say?
%What's expected? Is that right?

%Theory tells us that the trapezoidal rule has a Order of accuracy of 2
%meaning the Error from using step-length h is O(h^2), this in turn means
%that we should expect the error quota difference after halving step length
%to be O(h^2)/O((h/2)^2) ~= 4. This is seen with some slight variation, so
%theory holds!

results 
change_err = zeros(size(hs));
errors = abs(results - (2*sqrt(3)-(2/3)))
for i = 2:size(errors,2)
    change_err(i) = errors(i-1)/errors(i);
end
change_err

%d) Now calculate I, using Simpsons method/ Richardson extrapolation, What
%about the errors there?

%Using richardson extrapolation theory tells us that the Order of Accuracy
%should increase by two p=2 -> p = 4. This would in turn mean that the
%error quota would be O(h^4)/O((h/2)^4) ~= 16. It seemingly takes a while
%before it reaches this zone of assymptotic convergence but it is close by
%the last two/three step-lengths

%Using Richardson extrapolation we calucalte for h = 1,
%0.5,0.25,0.125,0.0625, knowing the Order of accuracy is 2 => 
%cp = 1/2^p-1 = 1/3;
R = @(h) T(h)-(T(2*h)-T(h))/3;
r_results = zeros(size(hs));
for i = 1:size(hs,2)
    h = hs(i);
    r_results(i) = R(h);
end
r_results
r_change_err = zeros(size(r_results));
r_errors = abs(r_results - (2*sqrt(3)-(2/3)))
for i = 2:size(r_errors,2)
    r_change_err(i) = r_errors(i-1)/r_errors(i);
end
r_change_err

%e) Plot the errors of both mehods using loglog
% There too we see a slope of approximatly 2 for trapezoid & 4 for
% Richardsons extrapolated trapezoid (Simpsons) as according to theory

loglog(hs, errors);
hold on;
grid on;
loglog(hs, r_errors);
hold off;
