%My Gradient descent implementation

%initial positions (u,v) = (1,1)
u = 1;
v = 1;
n = 0.1;

for i = 1:20
temp_u = u - n*(2*(exp(v)+2*v*exp(-u))*(u*exp(v) - 2*v*exp(-u)));
temp_v = v - n*(2*(u*exp(v)-2*exp(-u))*(u*exp(v)-2*v*exp(-u)));

Error = (u*exp(v)-2*v*exp(-u))^2;

u = temp_u;
v = temp_v;


end