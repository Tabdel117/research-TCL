function [Pmax, Pmin, Pset] = ACload(Tmax, Tmin, Ta, R, C, T0, Pa, T_tcl)
%�Ա��������ֱ��Ӧ����¶ȣ���С�¶ȣ���ǰ�����¶ȣ��յ���Ч�迹����Ч���ݣ������¶ȣ������
eta = 2.7;%��Ч��
e = exp(- T_tcl / R / C);
a = (Tmax - Tmin) / R / (1 - e );
b = - (Tmax -Tmin) / R * e / (1 - e);
c = -(T0 - Tmin - (T0 - Tmin) * e) / R / (1 - e);
SOC = (Ta - Tmin) / (Tmax - Tmin);
Pmax = ( b * SOC + c) / -eta;
Pmin = ( a + b * SOC + c) / -eta;
Pmax = min(Pa, Pmax);
Pmin = max(Pmin, 0);
Pset = (0.5 * (Tmax + Tmin) - T0) / R / -eta;