"Exercice 2: Analyse spectrale d'un signal par la TFD";

clear all; clc; close all;

load('signal_inconnu2.mat'); %charge le fichier inconnu
whos("-file", 'signal_inconnu2.mat');
Fs
xk
n=0 :1 :1999 ;%on va afficher 200 valeurs du signal
size(n);
N=2000;
subplot(2,1,1);
plot(n,xk) ;
title('Représentation du signal xk')
%Génération du vecteur fréquence
f=0 :(Fs/(N-1)) :Fs;
subplot(2,1,2);
Xn=fft(xk);
plot(f,2/N*abs(Xn));
title('Représentation de la TFD du signal xk')
grid on;

%2. Amélioration de la précision fréquencielle (% lobbes secondaires sin cardinal)

M=10;
xk1 = [xk zeros(1,M*N)]; %On concatène M*N zéros à xk
Xn1=fft(xk1,2048); %On calcule la transformée de Fourier de xk1
figure(2);
plot(linspace(0,Fs,length(Xn1)),abs(Xn1));% On trace la courbe de Xn1
title('Represéntation de Xn1, la TFD de xk1')

%3.Intérêt d'une fenêtre de pondération
w = window(@hamming, length(xk));%Pondération avec une fenêtre de Hamming
xkh = xk.*w.';

%Calcul de la TFD
Xnh = fft(xkh, 2048);

xkh1 = [xkh zeros(1,M*N)];%On concatène M*N zéros à xkh
Xnh1=fft(xkh1, 2048);

%tracés
figure(3);
plot(linspace(0,1,2048), log10(abs(Xnh)), linspace(0,1,2048), log10(abs(Xnh1)));
title('Xnh et Xnh1 pondérés par une fenêtre de Hamming');

%fenêtre de hanning et Blackman
w2 = window(@hanning, length(xk));
xkh2 = xk.*w2.';

w3 = window(@blackman, length(xk));
xkh3 = xk.*w3.';

%Calcul des TFD
Xnh2 = fft(xkh2, 2048);

Xnh3 = fft(xkh3, 2048);

%tracés
figure(4);
plot(linspace(0,1,2048), log10(abs(Xnh2)), linspace(0,1,2048), log10(abs(Xnh3)), linspace(0,1,2048), log10(abs(Xnh)),linspace(0,1,2048), log10(abs(Xn1))  );
legend('Fenêtre de Hanning','Fenêtre de Blackman','fenêtre de Hamming','fenêtre de rectangulaire','Location','north')
title('Fenetre rectangulaire, de Hamming, de Hanning et de Blackmann');

%vérification
t=0 :(1/Fs) :(N-1)*(1/Fs);%vecteur temps
%On lit les ampitudes
A1 = 0.473178;
A2 = 0.145188;
A3 = 0.963602;
A4 = 0.291654;
%On lit les fréquences
f1 = 968;
f2 = 984;
f3 = 1000;
f4 = 1040;
x1 = A1*sin(2*pi*f1*t);
x2 = A2*sin(2*pi*f2*t);
x3 = A3*sin(2*pi*f3*t);
x4 = A4*sin(2*pi*f4*t);
x = x1+x2+x3+x4%Signal analytique

figure(7);
plot(n,x);
title('Signal analytique')
xlabel('Temps(s)')
ylabel('Amplitude')
figure(8);
X=fft(x)
plot(f,abs(X))
title('Signal analytique')
xlabel('Frequence(Hz)')
ylabel('Amplitude')
