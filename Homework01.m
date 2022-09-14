%% Homework 01 Problem 4
% By: Ethan Bishop
%% solve for the tf
L = 5; R = 100; C = 0.01;
sys = 1/(L*C*s^2+C*R*s+1);

syms s;

% compute laplace transfer function 
s=tf('s');

% define the step inputs
u1 = 5;
u2 = stepDataOptions('InputOffset', 2, 'StepAmplitude', 1); % collab: Kyle Thompson

% plot the step response
subplot(2,1,1)
hold on
step(u1*sys)
hold on
subplot(2,1,2)
step(sys,u2)