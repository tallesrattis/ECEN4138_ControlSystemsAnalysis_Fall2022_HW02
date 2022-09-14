% ECEN4138_ControlSystemsAnalysis_Fall2022 - RLC series
% reference: https://www.mathworks.com/help/symbolic/solve-differential-equations-using-laplace-transform.html
close all ; clear all ; clc

%% parameters

syms R L C Vc(t) s 
assume([L C R] > 0)

V(t)=1*heaviside(t) ;
%V(t)=1*sin(t) 
%V(t)=1*dirac(t) ;

%% equation 

D_Vc = diff(Vc,t);
D2_Vc = diff(Vc,t,2);

eqn1 = ( 1/(L*C) )* V(t) == D2_Vc + (R/L)*D_Vc + (1/(L*C)) * Vc(t)


% laplace
eqn1LT = laplace(eqn1,t,s)


% substitute
syms V_LT Vc_LT 
eqn1LT = subs( eqn1LT,[ Vc(0)  subs(diff(Vc(t), t), t, 0)  laplace(Vc(t), t, s) ] , ...
                      [ 0      0                           Vc_LT                ] )

              
% solve Vc
eqns = [eqn1LT];
vars = [Vc_LT];
[Vc_LT] = solve(eqns,vars)


% ilaplace
Vc_sol = ilaplace(Vc_LT,s,t)
Vc_sol = simplify(Vc_sol)



%% Example (L=1, R=3, C=1/2) 

%Substitute Values
vars = [L R C];
values = [1 3 1/2];
vc_sol = subs(Vc_sol,vars,values)


%% plot
figure; hold on ;

subplot(1,3,1);hold on ;
fplot(V,[0 20],'r')
fplot(vc_sol,[0 20],'k')
title('vc')
ylabel('vc(t)')
xlabel('t')
legend('v','vc')

subplot(1,3,2);hold on ;
fplot(V,[0 50],'r')
fplot(vc_sol,[0 50],'k')
title('vc')
ylabel('vc(t)')
xlabel('t')
legend('v','vc')

subplot(1,3,3);hold on ;
fplot(V,[0 100],'r')
fplot(vc_sol,[0 100],'k')
title('vc')
ylabel('vc(t)')
xlabel('t')
legend('v','vc')
