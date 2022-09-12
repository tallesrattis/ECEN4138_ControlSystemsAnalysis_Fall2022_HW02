% ECEN4138_ControlSystemsAnalysis_Fall2022 - Homework 02 (part 1)
syms i(t) r(t) 
syms t positive real % only consider t > 0
syms R L C
% L = 100;        % Henry
% C = 0.000022;  % Farad
% R = 1000;       % Ohm
di(t) = diff(i(t), 1);
d2i(t) = diff(i(t), 2);

% Define forcing function (input current)
%r(t) = 1;

% DE
r(t) = d2i(t) + (1/(R*C))*di(t) + (1/(L*C))*i(t);
%i(t) = L*C*(d2i(t) + (1/(R*C))*di(t) - 1);

% Laplace transforms
R1 = laplace(r(t));
R1 = collect(R1)


%% plot




