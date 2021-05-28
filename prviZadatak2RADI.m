%inicijalizacija
clc
close all;
clear all;
%%
fs = 1600; %broj uzoraka;
t = 0:1/fs:2000;
f1 = 1.5;
f2 = 750;

%%
%filtar
x1=100;
x2=100;
%k = sqrt(1+x2^2)/sqrt(1+x1^2);
k = sqrt(1+x2^2);
s = tf('s');
%G = k*((s+x1)/(s+x2));
G = k/(s+x2);

%%

y = cos(2*f1*pi*t) + sin(2*f2*pi*t);
%plot(t, y)
%title('Vremenski domen');

Y = fft(y);
Y = fftshift(Y);

f = -fs/2:(fs/length(y)):fs/2-(fs/length(y));


figure;
plot(f, abs(Y), '-g');
title("Originalni signal");
%axis([-800 800 0 0.5]);
figure
hold on;
xlabel("Frekvencija (Hz)");
ylabel("Amplituda");
%%
[ystar, tf] = lsim(G, y, t);
YSTAR = fft(ystar);
YSTAR = fftshift(YSTAR);
plot(f, abs(YSTAR),'-y');
title("Filtriran signal");
figure
hold on;
bode(G);
%%
Ts=0.001;
tk2 = 0:Ts:10;
y2 = cos(2*f1*pi*tk2) + sin(2*f2*pi*tk2);
[y2star, ~] = lsim(G, y2, tk2);
figure;
subplot(211);
plot(tk2,y2);
title("Originalni signal");
subplot(212);
plot(tk2,y2star);
title("Filtriran signal");
%%

fs1=4;  %dobra perioda fs1>2*1.5
t1 = 0:1/fs1:1001;
x=cos(3*pi*t1);

fn = -fs1/2:(fs1/length(x)):fs1/2-(fs1/length(x));

X = fft(x);
X = fftshift(X);
figure;
plot(fn, abs(X), '-b');
title("Dobra perioda");

%%
fs2=2; %losa perioda fs2<2*1.5
t2 = 0:1/fs2:1001;
x2=cos(3*pi*t2);

fn2 = -fs2/2:(fs2/length(x2)):fs2/2-(fs2/length(x2));

X2 = fft(x2);
X2 = fftshift(X2);
figure;
plot(fn2, abs(X2), '-r');
title("Losa perioda");



