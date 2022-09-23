% ECEN4138_ControlSystemsAnalysis_Fall2022 - RLC Parallel
% Characterize a parallel RLC circuit with its transfer functions then
% also plot four specific responses.
% reference: https://www.mathworks.com/help/symbolic/solve-differential-equations-using-laplace-transform.html

% Author: Ethan Bishop

close all ; clear all ; clc

%% parameters

syms R L C IL(t) s 
assume([L C R] > 0)

r1(t) = heaviside(t);                       % step function
r2(t) = sin(t);                             % sine function
r3(t) = dirac(t);                           % impulse function
r4(t) = heaviside(t) - heaviside(t-2);      % pulse function

%% equation 

D_IL = diff(IL,t);
D2_IL = diff(IL,t,2);

eqn1 = r1(t) == L*C*D2_IL + (L/R)*D_IL + IL(t);
eqn2 = r2(t) == L*C*D2_IL + (L/R)*D_IL + IL(t);
eqn3 = r3(t) == L*C*D2_IL + (L/R)*D_IL + IL(t);
eqn4 = r4(t) == L*C*D2_IL + (L/R)*D_IL + IL(t);

% laplace
eqn1LT = laplace(eqn1,t,s)
eqn2LT = laplace(eqn2,t,s)
eqn3LT = laplace(eqn3,t,s)
eqn4LT = laplace(eqn4,t,s)

% substitute
syms IL_LT 
eqn1LT = subs( eqn1LT,[ IL(0)  subs(diff(IL(t), t), t, 0)  laplace(IL(t), t, s) ] , ...
                      [ 0      0                           IL_LT                ] );
eqn2LT = subs( eqn2LT,[ IL(0)  subs(diff(IL(t), t), t, 0)  laplace(IL(t), t, s) ] , ...
                      [ 0      0                           IL_LT                ] );
eqn3LT = subs( eqn3LT,[ IL(0)  subs(diff(IL(t), t), t, 0)  laplace(IL(t), t, s) ] , ...
                      [ 0      0                           IL_LT                ] );
eqn4LT = subs( eqn4LT,[ IL(0)  subs(diff(IL(t), t), t, 0)  laplace(IL(t), t, s) ] , ...
                      [ 0      0                           IL_LT                ] );
              
% solve IL
eqns1 = [eqn1LT];
eqns2 = [eqn2LT];
eqns3 = [eqn3LT];
eqns4 = [eqn4LT];

vars = [IL_LT];
sol1 = solve(eqns1,vars);
sol2 = solve(eqns2,vars);
sol3 = solve(eqns3,vars);
sol4 = solve(eqns4,vars);


% ilaplace
iL_sol1 = ilaplace(sol1,s,t)
iL_sol2 = ilaplace(sol2,s,t)
iL_sol3 = ilaplace(sol3,s,t)
iL_sol4 = ilaplace(sol4,s,t)

iL_sol1 = simplify(iL_sol1)
iL_sol2 = simplify(iL_sol2)
iL_sol3 = simplify(iL_sol3)
iL_sol4 = simplify(iL_sol4)



%% Example (L=1, R=3, C=1/2) 

%Substitute Values
vars = [L R C];
values = [1 3 1/2];
iL_sol1 = subs(iL_sol1,vars,values);
iL_sol2 = subs(iL_sol2,vars,values);
iL_sol3 = subs(iL_sol3,vars,values);
iL_sol4 = subs(iL_sol4,vars,values);

%% plot
figure; hold on ;

subplot(2,2,1);hold on ;
fplot(r1,[0 20],'r')
fplot(iL_sol1,[0 20],'k')
title('Response to step u(t)')
ylabel('iL(t) (amps)')
xlabel('t (s)')
legend('r1','iL')

subplot(2,2,2);hold on ;
fplot(r2,[0 20],'r')
fplot(iL_sol2,[0 20],'k')
title('Response to sin(t)')
ylabel('iL(t) (amps)')
xlabel('t (s)')
legend('r2','iL')

subplot(2,2,3);hold on ;
fplot(r3,[0 20],'r')
fplot(iL_sol3,[0 20],'k')
title('Response to impulse dirac(t)')
ylabel('iL(t) (amps)')
xlabel('t (s)')
legend('r3','iL')

subplot(2,2,4);hold on ;
fplot(r4,[0 20],'r')
fplot(iL_sol4,[0 20],'k')
title('Response to u(t)-u(t-2)')
ylabel('iL(t) (amps)')
xlabel('t (s)')
legend('r4','iL')



