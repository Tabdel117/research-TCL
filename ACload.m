function [Pmax,Pmin,Pset]=ACload(Tmax,Tmin,Ta,R,C,T0,Pa)
%�Ա��������ֱ��Ӧ����¶ȣ���С�¶ȣ���ǰ�����¶ȣ��յ���Ч�迹����Ч���ݣ������¶ȣ������

a=(Tmax-Tmin)/R/(1-exp(-1/R/C));
b=-(Tmax-Tmin)/R*exp(-1/R/C)/(1-exp(-1/R/C));
c=-(T0-Tmin-(T0-Tmin)*exp(-1/R/C))/R/(1-exp(-1/R/C));
SOC=(Ta-Tmin)/(Tmax-Tmin);
Pmax=(b*SOC+c)/2.7/-1;
Pmin=(a+b*SOC+c)/-2.7;
Pmax=min(Pa,Pmax);
Pmin=max(Pmin,0);
Pset=(0.5*(Tmax+Tmin)-T0)/R/-2.7;