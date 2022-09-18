%% 
% This code accompanies question 1 on homework 2 for ECEN 4138 Fall 2022.
% It describes a parallel RLC circuit and the circuit's responses to four
% particular inputs.
% Author: Kyle Thompson

clear all

%% Develop transfer function for Parallel RLC
syms R L C IL(t) s
assume ([R L C] > 0)

r1(t) = heaviside(t); % step function
r2(t) = dirac(t); % impulse function
r3(t) = sin(t); 
r4(t) = heaviside(t) - heaviside(t - 2); % pulse w/ width = 2
inputs = {r1 r2 r3 r4};

D_IL = diff(IL, t); % first derivative
D2_IL = diff(IL, t, 2); % second derivative

eqn1 = (r1(t) == (D2_IL + 1/(R*C)*D_IL + 1/(L*C)*IL(t))*L*C);
eqn2 = (r2(t) == (D2_IL + 1/(R*C)*D_IL + 1/(L*C)*IL(t))*L*C);
eqn3 = (r3(t) == (D2_IL + 1/(R*C)*D_IL + 1/(L*C)*IL(t))*L*C);
eqn4 = (r4(t) == (D2_IL + 1/(R*C)*D_IL + 1/(L*C)*IL(t))*L*C);

eqns = {eqn1; eqn2; eqn3; eqn4};

%% laplace transform
syms IL_LT 
syms 'eqn%dLT' [1 4]
eqnsLT = [eqn1LT eqn2LT eqn3LT eqn4LT];

for i = 1:4
    eqnsLT(i) = laplace(eqns(i), t, s);
    eqnsLT(i) = subs(eqnsLT(i),...
            [IL(0) subs(diff(IL(t), t), t, 0) laplace(IL(t), t, s)],...
            [0     0                          IL_LT               ]);
end

%% Solve
for i = 1:4
    sol(i) = solve(eqnsLT(i), IL_LT);
    iL_sol{i} = ilaplace(sol(i), s, t);
    iL_sol{i} = simplify(iL_sol{i});
end

%% Substitute values for R, L, and C
% R=3 ohm, L=1 Henry, C=0.5 Farad
vars = [R L C];
values = [1 3 0.5];

for i = 1:4
    iL_sol{i} = subs(iL_sol{i}, vars, values);
end

%% Plot
figure(1)
sgtitle("Parallel RLC Response to Various Inputs")

for i = 1:4
    subplot(2, 2, i)
    hold on
    fplot(iL_sol{i}, [0 15])
    fplot(inputs{i}, [0 15])

    if i == 1
        ylim([0 1.25])
    end
    if i == 3
        ylim([-1 1.5])
    end

    title_str = sprintf("Response to r(t) = %s", string(inputs{i}));
    title(title_str)
    xlabel('t (seconds)')
    legend("{\it I_{L}} (amps)", "{\it r(t)} (amps)", 'Location', 'NorthEast')
    legend('boxoff')
end
