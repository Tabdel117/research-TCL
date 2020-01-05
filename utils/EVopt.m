% �����Ż����EV�����������EV�Ľ���ʱ���й�
function Parray = EVopt( T, E, alpha, E_min, E_max, PN, prePrice ) %tΪʣ��ʱ��
E_avg = alpha * E_max + (1 - alpha) * E_min;
delta_E = max(0, E_avg - E);
len = length(prePrice);
if len * PN * T < delta_E
    Parray = PN * ones(len, 1);
else
    f = prePrice;
    A = - ones(1, len);
    b = - delta_E / T;
    Parray = linprog(f, A, b, [], [], zeros(len, 1), ones(len, 1) * PN);
    if exist('Parray', 'var') ~= 1
        delta_E
        len
    end
end
end

