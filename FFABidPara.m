function [ P_max, P_min, P_set, SOA_1 ] = FFABidPara(priceRecord, T_0, T_out, T_max, T_min, R, C, PN, psi, T_tcl)
%底层TCL根据动态方程进行优化, priceArray电价序列, T_0 t-1时刻室内温度，T_out室外温度序列
%T_min最低室温， T_max最高室温
%Pset最优当前电价
eta = 2.7;
e = exp( - T_tcl / R / C);
denominator = eta * R * (1 - e);
SOA_0 = (T_0 - T_min) / (T_max - T_min);
a =  - (T_max - T_min) / denominator;
b = - e * a;
c = (T_out - T_min) / eta / R + psi;
N = length(priceRecord);
P_min = a + b * SOA_0 + c(1);
P_max = b * SOA_0 + c(1);
P_min = min(PN, P_min);
P_min = max(P_min, 0);
P_max = min(PN, P_max);
P_max = max(P_max, 0);
% A B 0 ... 0 0
% 0 A B ... 0 0
%..............
% 0 0 0 ... A B
% 0 0 0 ... 0 A
% fun = @(x) - x' * (diag(a * ones(1, N), 0) + diag(b * ones(1, N - 1), 1)) * priceRecord +  2.5 / beta * sum((x).^2); %beta 1-10 10-热 1-冷
fun = @(x) x' * (diag(a * ones(1, N), 0) + diag(b * ones(1, N - 1), 1)) * priceRecord + priceRecord' * (x - 0.5).^2 * (P_max - P_min); %beta 1-10 10-热 1-冷
% A2_main矩阵
% A 0 0 ... 0 0
% B A 0 ... 0 0
%..............
% 0 0 0 ... B A
%功率上下限约束
A2_main = diag(a * ones(1, N), 0) + diag(b * ones(1, N - 1), -1);
b22 =  PN - c; b22(1) = b22(1) - b * SOA_0;
b21 = - c; b21(1) = b21(1) - b * SOA_0;
A2 = [A2_main; -A2_main];
b2 = [b21; -b22];
A = A2;
B = b2;
% 10%边界
% [SOA, ~, exitflag] = linprog(- f1 + f2, A, B, [], [], 0.1 * ones(N, 1), 0.9 * ones(N, 1));
%多目标优化
[SOA, ~, exitflag] = fmincon(fun, SOA_0 * ones(N, 1), A, B, [], [], 0.1 * ones(N, 1), 0.9 * ones(N, 1));

SOA_1 = SOA(1);
if exist('SOA', 'var') == 1
    P_set = a * SOA_1 + b * SOA_0 + c(1);
else
    X = 1;
end
end