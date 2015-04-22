function [me] = emittance(lambda, T)
h= 6.6262e-34;      %Plancks konstant [Js]
c = 2.9979e8;       %Ljusets hastighet i tomrum [m/s]
k = 1.3807e-23;     %Bolzmanns konstant [J/K]

me = 2*pi*h*c^2./(lambda.^5.*(exp(h*c./(k*lambda*T))-1));

end

