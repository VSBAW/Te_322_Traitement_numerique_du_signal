"Exercice 1 : Analyse spectrale d'un signal par la TFD";

clear all; clc; close all;
%1.Analyse spectrale élémentaire

load('signal_inconnu.mat'); %charge le fichier inconnu
whos("-file", 'signal_inconnu.mat');
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
plot(f,abs(Xn));
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
f0=1000;%frequence fondamentale
t=0 :(1/Fs) :(N-1)*(1/Fs);%vecteur temps
x=sin(2*pi*f0*t);%signal analytique
%on trace
figure(5)
plot(t,x)%signal analytique
title('Signal analytique')
xlabel('Temps(s)')
ylabel('Amplitude')
X=fft(x)
figure(6)
plot(f,abs(X))% TF du signal analytique
title('TFD du Signal analytique')
xlabel('Fréquence(Hz)')
ylabel('Amplitude')


