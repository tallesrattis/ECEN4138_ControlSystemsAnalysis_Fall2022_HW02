% ECEN4138_ControlSystemsAnalysis_Fall2022 - Homework 02 (part 1)
% reference: https://www.mathworks.com/help/symbolic/solve-differential-equations-using-laplace-transform.html
close all ; clear all ; clc


%% parameters

syms R L C Vc(t) s V(t)
assume([L C R] > 0)


%% equation 
D_Vc = diff(Vc,t);
D2_Vc = diff(Vc,t,2);
eqn1 = ( 1/(L*C) )* V(t) == D2_Vc + (R/L)*D_Vc + (1/(L*C)) * Vc(t)


%% laplace

eqn1LT = laplace(eqn1,t,s)


% substitute
syms V_LT Vc_LT 
eqn1LT = subs( eqn1LT,[ Vc(0)  subs(diff(Vc(t), t), t, 0)  laplace(V(t), t, s)  laplace(Vc(t), t, s) ] , ...
                      [ 0      0                           V_LT                 Vc_LT                ] )

                  
% solve Vc
eqns = [eqn1LT];
vars = [Vc_LT];
[Vc_LT] = solve(eqns,vars)


% ilaplace
Vc_sol = ilaplace(Vc_LT,s,t)
Vc_sol = simplify(Vc_sol)




%% transfer function
H = Vc_LT/V_LT
H_subs = subs( H, [L R C],[1 3 1/2] )



%% freq. response
[N,D] = numden(H_subs)


N_coeffs = double( coeffs(N) )
D_coeffs = double( coeffs(D) )

w = logspace(-1,1);
freqs(N_coeffs,D_coeffs,w)




