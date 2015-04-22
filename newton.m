function [xx] = newton(fun, funPrime, x0, tol)
MAX_ITER = 100000;
i = 0;

x = x0 - fun(x0)/funPrime(x0);
y = fun(x0) + funPrime(x0).*(x - x0);

while (abs(y) < tol) && (i < MAX_ITER)
    x0 = x;
    x = x - fun(x)/funPrime(x);
    y = fun(x0) + funPrime(x0).*(x - x0);
    i = i+1;
end
xx = x;
end


