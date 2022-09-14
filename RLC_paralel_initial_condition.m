% ECEN4138_ControlSystemsAnalysis_Fall2022 - Homework 02 (part 1)
% reference: https://www.mathworks.com/help/symbolic/solve-differential-equations-using-laplace-transform.html
close all ; clear all ; clc

syms R L C I_l(t) s dIo
assume([L C R] > 0)
r(t)=1*heaviside(t) ;

D_I_l = diff(I_l,t);
D2_I_l_2 = diff(I_l,t,2);
eqn1 = r(t) == L*C*D2_I_l_2 + (L/R)*D_I_l + I_l(t)


% laplace
eqn1LT = laplace(eqn1,t,s)


% substitute
syms I_l_LT 
eqn1LT = subs( eqn1LT,[ laplace(I_l(t),t,s) subs(diff(I_l(t), t), t, 0)] , [I_l_LT dIo] )

% solve Il
eqns = [eqn1LT];
vars = [I_l_LT];
[I_l_LT] = solve(eqns,vars)


% ilaplace
I_l_sol = ilaplace(I_l_LT,s,t)
I_l_sol = simplify(I_l_sol)

% vc = vl = L dI/dt
vc = L * diff( I_l_sol ,t );

% Substitute Values 
vars = [R L C I_l(0) dIo];
values = [3 1 1/2 0.1 5];
vc_sol = subs(vc,vars,values)


%plot
fplot(vc_sol,[0 20])                      
title('vc')
ylabel('vc(t)')
xlabel('t')

