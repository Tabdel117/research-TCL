function [ P_max, P_min, P_set ] = IVABidPara(priceRecord, T_0, T_out, T_max, T_min, R, C, PN, Pmin, p1, p2, q1, q2, T, ratioIVA)
%�ײ�IVA���ݶ�̬���̽����Ż�, priceArray�������, T_0 t-1ʱ�������¶ȣ�T_out�����¶�����
%T_min������£� T_max�������
%Pset���ŵ�ǰ���
e = exp( - T / R / C);
denominator = R * (1 - e);
SOA_0 = (T_0 - T_min) / (T_max - T_min);
a =  - (T_max - T_min) / denominator;
b = - e * a;
[row, ~] = size(T_out);
if row == 1
    T_out = T_out';
end
c = (T_out - T_min) / R;
N = length(priceRecord);

QN = q1 / p1 * PN -(q1 * p2 - p1 * q2) / p1;
Qmin = q1 / p1 * Pmin -(q1 * p2 - p1 * q2) / p1;

Q_min = a + b * SOA_0 + c(1);
Q_max = b * SOA_0 + c(1);
if Q_min > QN
    Q_min = QN;
    Q_max = QN;
    Q_set = QN;
else
    Q_min = min(QN, Q_min);
    Q_min = max(Q_min, Qmin);
    Q_max = min(QN, Q_max);
    Q_max =max(Q_max, Qmin);
    A2_main = diag(a * ones(1, N), 0) + diag(b * ones(1, N - 1), -1);
    H = 2 * diag(priceRecord) * (PN - Pmin) * ratioIVA;
    f = (priceRecord' * A2_main * p1 / q1 -  priceRecord' * ((PN - Pmin)) * ratioIVA)';

    b22 = QN - c; b22(1) = b22(1) - b * SOA_0;
    b21 = Qmin - c; b21(1) = b21(1) - b * SOA_0;
    A2 = [A2_main; -A2_main];
    b2 = [b22; -b21];
    A = A2;
    B = b2;
    SOA = quadprog(H, f, A, B, [], [], zeros(N, 1), ones(N, 1));
    if exist('SOA', 'var') == 1
        SOA_1 = SOA(1);
        Q_set = a * SOA_1 + b * SOA_0 + c(1);
    else
        X = 1;
    end
end
P_set = p1 / q1 * Q_set + (q1 * p2 - p1 * q2) / q1;
P_max = p1 / q1 * Q_max + (q1 * p2 - p1 * q2) / q1;
P_min  = p1 / q1 * Q_min + (q1 * p2 - p1 * q2) / q1;
end