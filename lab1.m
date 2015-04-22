function lab1()
clear all
h= 6.6262e-34;      %Plancks konstant [Js]
c = 2.9979e8;       %Ljusets hastighet i tomrum [m/s]
k = 1.3807e-23;     %Bolzmanns konstant [J/K]
sigma = 5.67e-8;    %Stefan Bolzmanns konstant [W/(m^2*K^4)]
%% a
clc, close all
T = [3000, 4000, 5000];
lvec = linspace(0,3e-6,300);
for i = 1:3
    lambda = fminbnd(@(l) -emittance(l,T(i)),0,1e-3,optimset('TolX',1e-10));
    hold on
    h(i) = plot(lvec,emittance(lvec,T(i)),'Displayname',sprintf('T = %i',T(i)));
    plot(lambda,emittance(lambda,T(i)),'ko')
    ba(i) = lambda*T(i);
end
legend(h)
ba
%% b
clc, close all
lvec = linspace(0,5.5,200);
y = objFun(lvec);
plot(lvec, y)
x = newton(@(x)objFun(x), @(z)objFunPrime(z), 12, 1e-7)
bb = h*c/(k*x)
%% c
clc, close all
T = linspace(100,10000,1000);
x = linspace(100,10000,1000);
Ms = zeros(1,1000);
Me = zeros(1,1000);
t0 = cputime;
for i=1:1000
    Ms(i) = quadl(@(l) emittance(l,T(i)), 4e-7, 7e-7);
    Me(i) = sigma*T(i)^4;
end
t1 = cputime - t0;
plot(x,Ms./Me)
%% d
T = linspace(100,10000,1000);
x = linspace(100,10000,1000);
Ms2 = zeros(1,1000);
options = odeset('RelTol', 1e-4, 'AbsTol', 1e-4);
t0 = cputime;
for i=1:1000
    f = @(t,l) fprime(t,0,T(i));
    [t, y] = ode45(f,[4e-7, 7e-7], 0, options);
    Ms2(i) = y(end);
end
t2 = cputime - t0;
plot(x,Ms2./Me)
tdiff = t2 - t1
