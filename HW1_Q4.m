%%
% Code to go along with Homework 1, Q #4
% Authors: Kyle Thompson and Kyle Dorr
%%
syms t s

R = 100; % ohm
L = 10; % H
C = 0.00001; % Farad

num = 1;
den = [1 R/L 1/(L*C)];

SYS = 1/(s^2+(R/L)*s+1/(L*C));

x_t = ilaplace(SYS);
x_t = collect(x_t)

sys = tf(num, den);

%% plot

opt = stepDataOptions('InputOffset', -1,...
                      'StepAmplitude', 2);

figure
hold on
step(sys)
step(3*sys)
step(sys, opt)
legend('u(t)', '3*u(t)', '2*u(t)-1')
