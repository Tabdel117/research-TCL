clear;clc;

Tmax = 26;
Tmin = 22;
Ta = 24;
T0 = 35;
state_flag = 3;%1��ӦON,2��ӦOFFLOCK,3��ӦOFF,4��ӦONLOCK
time = 4;%����ʱ��1�������ʾ2s
[Pmax, Pmin, Pset] = ACload(Tmax, Tmin, Ta, R, C, T0, P);
[Ta, state_flag, time] = AC(0.2 * P, P, Ta, T0, state_flag, time, R, C);