% TC��������EV��TCL�����Ż�����Ƚ�
addPath;warning('off');
startmatlabpool();
clc; clear;
path = '..\..\data\0702-2';
dataPath = [path, '\data'];
DAY = 7;
RATIO = 100;
EV = 4.63 * RATIO; % EV�����������Ϊ3.7kW
FFA = 5.56 * RATIO; % �յ�����
IVA = 3.7 * RATIO;
T = 15 / 60; % ��������15min
dt = 1 / 60 / 60; % �յ���������2s
T_tcl = 1; % �յ�����ָ������60min
T_mpc = 6;
I1 = 24 * DAY / dt;
I = 24 * DAY / T;
I_day = 24 / T;
I_tcl = T_tcl / T;
I2 = 24 * DAY / T_tcl;
LOAD = 17 * RATIO; % LOAD��󸺺ɣ�kW��
WIND = 9.26 * RATIO; % WIND���װ��������kW��
tielineSold = 10 * RATIO;
tielineBuy = 31.5 * RATIO;
eta = 0.9;
ratioFFA = 0.7;
ratioIVA = 1;
tolerance = 0.01;
if exist('DAY', 'var') == 1
    isMultiDay = 1;
else
    isMultiDay = 0;
    
end
mktInit;
priceInit;
EVinit;
TCLinit;
save(dataPath);

modeType = [
    0, 0, 0;
    0, 1, 0;
    0, 1, 1;
    1, 1, 1;
];
for mode = 1:4
    clearvars -except modeType mode dataPath
    load(dataPath);
    isAging = modeType(mode, 1);
    isEVflex = modeType(mode,2);
    isTCLflex = modeType(mode, 3);
    main_multidays;
    if mode == 1
        save([path, '\mode']);
    elseif mode == 2
        save([path, '\modeEV']);
    elseif mode == 3
        save([path, '\modeTCL']);
    else
        save([path, '\modeAging']);
    end
end
clearvars -except dataPath
load(dataPath);
priceDriven;
save([path, '\modePD']);
closematlabpool();