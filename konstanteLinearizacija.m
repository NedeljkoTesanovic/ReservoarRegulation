clear variables;

% Konstante
g = 9.81;

R=1;
A0 = 0.01;
qu_max =0.04;

% Odabir mirne radne tacke
h1 = 0.8;
h2 = 0.8;

c=A0*sqrt(2*g);
q0 = c*sqrt(h1);
A1=pi*h1*(R-h1/2);

a=c/(pi*(h1^(3/2))*(2*R-h1));
b=2/(pi*h1*(2*R-h1));


T=1;
% Racunanje matrica linearnog modela u prostoru stanja
A = [-a 0; a -a];
B = [b; 0];
C = [0 1];
D = 0;


