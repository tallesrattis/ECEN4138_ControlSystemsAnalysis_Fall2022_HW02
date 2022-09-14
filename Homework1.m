%% Problem 4
%% Collaborator: Kyle Thompson
% Parameters
R = 100;
L = 10;
C = 47*10^-6;
s = tf('s');
u1 = 5;
u2 = stepDataOptions('InputOffset',-1,'StepAmplitude',2);

% Transfer Function
sys = 1/((L*C)*s^2+(R*C)*s+1);

% Plot
step(u1*sys)
hold on
step(sys,u2)
legend('Vs = 5u(t)','Vs = 2u(t)-1')