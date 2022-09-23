%% Numerical Problem Presented in the class on Sept 7th
%% Numerical Problem RLC Parallel Circuit

%% transfer function 

syms s;
H_s = 1/(L*C*s^2+L/R*s+1);

%% overdamped case - step

% solve for the tf
L = 5; R = 1; C = 0.1;
H_s = 1/(L*C*s^2+L/R*s+1)

syms s;

% compute laplace transfer function 
s=tf('s');

% define the transfer function
sys = (1)/(0.5*s^2+5*s+1);

% plot the step response
subplot(2,1,1)
hold on
step(sys)

%% underdamped case - step

% solve for the tf
L = 1; R = 5; C = 1;
H_s = 1/(L*C*s^2+L/R*s+1)

syms s;

% compute laplace transfer function 
s=tf('s');

% define the transfer function
sys = (1)/(1*s^2+0.2*s+1);

% plot the step response
hold on
step(sys)


%% critically damped case - step

% solve for the tf
L = 5; R = 5; C = 0.1;
H_s = 1/(L*C*s^2+L/R*s+1)

syms s;

% compute laplace transfer function 
s=tf('s');

% define the transfer function
sys = (1)/(0.5*s^2+1*s+1);

% plot the step response
hold on
step(sys)
hold off

%% overdamped case - bode 

% L = 5, R = 1, C = 0.1

syms s;

% compute laplace transfer function 
s=tf('s');

% define the transfer function
sys = (1)/(0.5*s^2+5*s+1);

% plot the freq response
subplot(2,1,2)
hold on
bode(sys)

%% underdamped case - bode

% L = 1, R = 5, C = 1

syms s;

% compute laplace transfer function 
s=tf('s');

% define the transfer function
sys = (1)/(1*s^2+0.2*s+1);

% plot the freq response
hold on
bode(sys)

%% critically damped case - bode

% L = 5, R = 5, C = 0.1

syms s;

% compute laplace transfer function 
s=tf('s');

% define the transfer function
sys = (1)/(0.5*s^2+1*s+1);

% plot the freq response
hold on
bode(sys)
hold off
