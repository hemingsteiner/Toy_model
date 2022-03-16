function y = Toy_Solver(x)
% Reading in exogenous variables  
k_bar       = evalin('base','k_bar');       % reading in capital stock
n_bar       = evalin('base','n_bar');       % reading in labour supply
tfp1_shk    = evalin('base','tfp1_shk');    % shock to sector 1 tfp
tfp2_shk    = evalin('base','tfp1_shk');    % shock to sector 2 tfp
p1          = evalin('base','p1');          % reading in numeraire  

% Reading in parameters
x1_x1       = evalin('base','x1_x1');       % capital share of sector one
x1_x2       = evalin('base','x1_x2');       % capital share of sector one
k_x1        = evalin('base','k_x1');        % capital share of sector one
n_x1        = evalin('base','n_x1');        % labour share of sector one
h_x1        = evalin('base','h_x1');        % consumption share of good one
tfp_1       = evalin('base','tfp_1');       % productivity of sector one
x2_x1       = evalin('base','x2_x1');       % capital share of sector one
x2_x2       = evalin('base','x2_x2');       % capital share of sector one
k_x2        = evalin('base','k_x2');        % capital share of sector one
n_x2        = evalin('base','n_x2');        % labour share of sector one
h_x2        = evalin('base','h_x2');        % consumption share of good one
tfp_2       = evalin('base','tfp_2');       % productivity of sector one

% Listing endogenous variables (wnat solutions not formualtes not fixed, allowing these things to move, 
% given behaviroual parameters,which satisfies our constraints) 
p2          = x(1);                         % price of good two
pK          = x(2);                         % price of capital
pN          = x(3);                         % price of labour
q1          = x(4);                         % output of sector one
q2          = x(5);                         % output of sector two
HH          = x(6);                         % total household consumption

% Setting initial formulas
x1_1  = q1/tfp_1*tfp1_shk*(x1_x1/p1)/((x1_x1/p1)^x1_x1*(x1_x2/p2)^x1_x2*(k_x1/pK)^k_x1*(n_x1/pN)^n_x1);
x1_2  = q1/tfp_1*tfp1_shk*(x1_x2/p2)/((x1_x1/p1)^x1_x1*(x1_x2/p2)^x1_x2*(k_x1/pK)^k_x1*(n_x1/pN)^n_x1);
x1_k  = q1/tfp_1*tfp1_shk*(k_x1/pK)/((x1_x1/p1)^x1_x1*(x1_x2/p2)^x1_x2*(k_x1/pK)^k_x1*(n_x1/pN)^n_x1); 
x1_n  = q1/tfp_1*tfp1_shk*(n_x1/pN)/((x1_x1/p1)^x1_x1*(x1_x2/p2)^x1_x2*(k_x1/pK)^k_x1*(n_x1/pN)^n_x1); 
x1_h  = HH/p1*(h_x1/(h_x1+h_x2));
x2_1  = q2/tfp_2*tfp2_shk*(x2_x1/p1)/((x2_x1/p1)^x2_x1*(x2_x2/p2)^x2_x2*(k_x2/pK)^k_x2*(n_x2/pN)^n_x2);
x2_2  = q2/tfp_2*tfp2_shk*(x2_x2/p2)/((x2_x1/p1)^x2_x1*(x2_x2/p2)^x2_x2*(k_x2/pK)^k_x2*(n_x2/pN)^n_x2);
x2_k  = q2/tfp_2*tfp2_shk*(k_x2/pK)/((x2_x1/p1)^x2_x1*(x2_x2/p2)^x2_x2*(k_x2/pK)^k_x2*(n_x2/pN)^n_x2); 
x2_n  = q2/tfp_2*tfp2_shk*(n_x2/pN)/((x2_x1/p1)^x2_x1*(x2_x2/p2)^x2_x2*(k_x2/pK)^k_x2*(n_x2/pN)^n_x2); 
x2_h  = HH/p2*(h_x2/(h_x1+h_x2));

% Defining independent equations
y(1,1)      = q1 - (x1_1 + x2_1 + x1_h)                        % market clearing in good one
y(2,1)      = q2 - (x1_2 + x2_2 + x2_h)                        % market clearing in good two
y(3,1)      = x1_k + x2_k - k_bar                              % market clearing in capital
y(4,1)      = x1_n + x2_n - n_bar                              % market clearing in labour
y(5,1)      = p1*q1 - pK*x1_k - pN*x1_n - p1*x1_1 - p2*x1_2    % zpc 1
y(6,1)      = p2*q2 - pK*x2_k - pN*x2_n - p1*x2_1 - p2*x2_2   % zpc 2

NewSam = [x1_1,x2_1,0,0,x1_h;x1_2,x2_2,0,0,x2_h;x1_k,x2_k,0,0,0;x1_n,x2_n,0,0,0;0,0,k_bar,n_bar,0]
end