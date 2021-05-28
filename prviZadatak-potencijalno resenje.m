%% inicijalizacija
clc
close all;
clear all;
s = tf('s');
%% definisanje signala
w1 = 1.5;
w2 = 750;

fs = 1600; %perioda odabiranja (fs>2*wmax; wmax = w2)
t = 0:1/fs:1001;

y = cos(2*w1*pi*t) + sin(2*w2*pi*t);
%% Crtanje signala

f = -fs/2: (fs/length(y)) :fs/2-(fs/length(y));
Y = fft(y);
Y = fftshift(Y);
figure
subplot(311);
plot(f, abs(Y));
title("Originalni signal");
grid on;
%% Konstrukcija filtera

x1=300;  %Na w1 zelimo neiskvaren signal, na w2 ne zelimo da imamo signala
x2=100; %ergo  w1<wp2<w2

k = sqrt(1+x2^2) %Zelimo da nam na w1=1.5 amplituda bude propustena bez slabljenja (tj. sa sto manjim slabljenjem)
G = k/(s+x2);

subplot(313)
bode(G);

%% Filtriranje signala

[ystar, ~] = lsim(G, y, t); %propustanje signala kroz filter
YSTAR = fft(ystar);
YSTAR = fftshift(YSTAR);

subplot(312);
plot(f, abs(YSTAR));
title("Filtrirani signal");
grid on;
%% Simuliranje odziva sistema propustenog kroz filter i poredjenje sa originalnim signalom
Ts=0.001;
t2 = 0:Ts:5;
y2 = cos(2*w1*pi*t2) + sin(2*w2*pi*t2);
yk = cos(2*w1*pi*t2);
[y2star, ~] = lsim(G, y2, t2);
figure;
subplot(211);
plot(t2,y2);
title("Originalni signal");
subplot(212);
plot(t2,y2star);
title("Filtriran signal");
%% Uticaj frekvencije odabiranja na signal

%Losa perioda
fs2 =0.5; %fs1 = 1.5; fs2 < 2 * fs1;
t2 = 0:1/fs2:1001;
y2 = cos(2*w1*pi*t2)+sin(2*w2*pi*t2);

f2 = -fs2/2:(fs2/length(y2)):fs2/2-(fs2/length(y2));

[ystar2, ~] = lsim(G, y2, t2);
Y2 = fftshift(fft(ystar2));

figure;
subplot(121)
plot(f2, abs(Y2),'-r');
title("Losa perioda: f = "+fs2);
grid on;

%Dobra perioda
fs3 = 6; %fs3 > 2 * fs1; Nema alijasa, signal na 1.5
t3 = 0:1/fs3:1001;
y3 = cos(2*w1*pi*t3) + sin(2*w2*pi*t3);

f3 = -fs3/2:(fs3/length(y3)):fs3/2-(fs3/length(y3));

[ystar3, ~] = lsim(G, y3, t3);
Y3 = fftshift(fft(ystar3));

subplot(122);
plot(f3, abs(Y3),'-g');
title("Dobra perioda: f = "+fs3);
grid on;