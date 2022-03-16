%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Two sector, closed economy, no government, no saving %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('ToyData.mat')
%%%%%%%%%%%%%% Variables to shock %%%%%%%%%%%%%%%%%%%%%%
nhom        = 1;                           % nominal homogeneity
rhom        = 1;                           % real homogeneity
tfp1_shk    = 1;                           % shock to sector 1 tfp
tfp2_shk    = 1;                           % shock to sector 2 tfp
k_shk       = 1.20;                           % shock to capital supply
n_shk       = 1;                        % shock to labour supply

%%%%%%%%%%%%% Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
p1          = 1*nhom;                      % price of good one (numeraire)
k_bar       = ToyData(3,3)*k_shk*rhom;     % total capital supply
n_bar       = ToyData(4,3)*n_shk*rhom;     % total labour supply
x1_x1       = ToyData(1,1);                % labour share of sector two
x1_x2       = ToyData(2,1);                % labour share of sector two
k_x1        = ToyData(3,1);                % capital share of sector one
n_x1        = ToyData(4,1);                % labour share of sector one
h_x1        = ToyData(5,1);                % consumption share of good one
X1          = ToyData(1,3);                % total production of good one
tfp_1       = X1/((X1*x1_x1)^x1_x1*(X1*x1_x2)^x1_x2*(X1*k_x1)^k_x1*(X1*n_x1)^n_x1);  
x2_x1       = ToyData(1,2);                % labour share of sector two
x2_x2       = ToyData(2,2);                % labour share of sector two
k_x2        = ToyData(3,2);                % capital share of sector two
n_x2        = ToyData(4,2);                % labour share of sector two
h_x2        = ToyData(5,2);                % consumption share of good two
X2          = ToyData(2,3);                % total production of good one
tfp_2       = X2/((X2*x2_x1)^x2_x1*(X2*x2_x2)^x2_x2*(X2*k_x2)^k_x2*(X2*n_x2)^n_x2); 


%%%%%%%%%%%%% Solver %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
x0          = [1;1;1;170;140;250];         % first guess of solution
xsol        = fsolve (@Toy_Solver, x0);    % caling solver based on that guess
p2          = xsol(1)                    % solution for price of good two
pK          = xsol(2)                     % solution for price of capital
pN          = xsol(3)                   % solution for price of labour
q1          = xsol(4)                    % solution for output of sector one
q2          = xsol(5)                    % solution for output of sector two
HH          = xsol(6)                    % solution for level of consumption

% Caclulating deviations
p2_dev      = p2*100-100;
pK_dev      = pK*100-100;
pN_dev      = pN*100-100;
q1_dev      = (q1/170)*100-100;
q2_dev      = (q2/140)*100-100;
HH_dev      = (HH/250)*100-100;
kbar_dev    = (k_bar/150)*100-100;
nbar_dev    = (n_bar/100)*100-100;

% Processing and presenting results
%dev_names = categorical({'p2', 'pK', 'pN', 'q1', 'q2', 'HH', 'K', 'N'});
%dev_names = reordercats(dev_names,{'p2', 'pK', 'pN', 'q1', 'q2', 'HH', 'K', 'N'});
devs = [p2_dev, pK_dev, pN_dev, q1_dev, q2_dev, HH_dev, kbar_dev, nbar_dev];
%bar(dev_names,devs);
bar(devs);

##x1_1  = q1/tfp_1*tfp1_shk*(x1_x1/p1)/((x1_x1/p1)^x1_x1*(x1_x2/p2)^x1_x2*(k_x1/pK)^k_x1*(n_x1/pN)^n_x1);
##x1_2  = q1/tfp_1*tfp1_shk*(x1_x2/p2)/((x1_x1/p1)^x1_x1*(x1_x2/p2)^x1_x2*(k_x1/pK)^k_x1*(n_x1/pN)^n_x1);
##x1_k  = q1/tfp_1*tfp1_shk*(k_x1/pK)/((x1_x1/p1)^x1_x1*(x1_x2/p2)^x1_x2*(k_x1/pK)^k_x1*(n_x1/pN)^n_x1); 
##x1_n  = q1/tfp_1*tfp1_shk*(n_x1/pN)/((x1_x1/p1)^x1_x1*(x1_x2/p2)^x1_x2*(k_x1/pK)^k_x1*(n_x1/pN)^n_x1); 
##x1_h  = HH/p1*(h_x1/(h_x1+h_x2));
##x2_1  = q2/tfp_2*tfp2_shk*(x2_x1/p1)/((x2_x1/p1)^x2_x1*(x2_x2/p2)^x2_x2*(k_x2/pK)^k_x2*(n_x2/pN)^n_x2);
##x2_2  = q2/tfp_2*tfp2_shk*(x2_x2/p2)/((x2_x1/p1)^x2_x1*(x2_x2/p2)^x2_x2*(k_x2/pK)^k_x2*(n_x2/pN)^n_x2);
##x2_k  = q2/tfp_2*tfp2_shk*(k_x2/pK)/((x2_x1/p1)^x2_x1*(x2_x2/p2)^x2_x2*(k_x2/pK)^k_x2*(n_x2/pN)^n_x2); 
##x2_n  = q2/tfp_2*tfp2_shk*(n_x2/pN)/((x2_x1/p1)^x2_x1*(x2_x2/p2)^x2_x2*(k_x2/pK)^k_x2*(n_x2/pN)^n_x2); 
##x2_h  = HH/p2*(h_x2/(h_x1+h_x2));

##NewSam = [x1_1,x2_1,0,0,x1_h;x1_2,x2_2,0,0,x2_h;x1_k,x2_k,0,0,0;x1_n,x2_n,0,0,0;0,0,k_bar,n_bar,0]

