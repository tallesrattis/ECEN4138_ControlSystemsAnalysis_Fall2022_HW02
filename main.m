% ECEN4138_ControlSystemsAnalysis_Fall2022 - Homework 02 (part 1)
%Garrett HAnsen
syms t i;
L = 10;
R = 100;
C = 5;
r_t = L*C*diff(i,2)+L/R*diff(i)+i

R_t = laplace(r_t)

fplot(R_t)
plot(r_t)

figure;
L = 1000;
R = 10;
c =5;
r_t = L*C*diff(i,2)+L/R*diff(i)+i
R_t = laplace(r_t)
fplot(R_t)

figure;
L = 10;
R = 1;
c =50;
r_t = L*C*diff(i,2)+L/R*diff(i)+i
R_t = laplace(r_t)
fplot(R_t)
