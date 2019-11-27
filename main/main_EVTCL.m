addPath;warning('off');
startmatlabpool();
clc; clear;
path = '..\..\data\penetration';
dataPath = [path, '\data'];
DAY = 7;
RATIO = 100;
EV = 5 * RATIO; % EV�����������Ϊ3.7kW
FFA = 6 * RATIO; % �յ�����
IVA = 4 * RATIO;
T = 15 / 60; % ��������15min
dt = 1 / 60 / 60; % �յ���������2s
T_tcl = 1; % �յ�����ָ������60min
T_mpc = 6;
I1 = 24 * DAY / dt;
I = 24 * DAY / T;
I_day = 24 / T;
I_tcl = T_tcl / T;
I2 = 24 * DAY / T_tcl;
LOAD = 15 * RATIO; % LOAD��󸺺ɣ�kW��
WIND = 10 * RATIO; % WIND���װ��������kW��
tielineSold = 10 * RATIO;
tielineBuy = 31.5 * RATIO;
eta = 0.9;
ratioFFA = 0.7;
ratioIVA = 2;
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
maxEV = EV;
clear EV
save(dataPath);
modeType = [
    0, 0, 0;
    1, 1, 0;
    1, 1, 1;
];
for penetration = 4 : 2: 10
    % TC��������EV��TCL�����Ż�����Ƚ�
    for mode = 1:3
        clearvars -except modeType mode dataPath penetration EV
        load(dataPath);
        EV = 5 * RATIO * penetration / 10;
        isAging = modeType(mode, 1);
        isEVflex = modeType(mode,2);
        isTCLflex = modeType(mode, 3);
        main_multidays;
        if mode == 1
            save([path, '\mode', num2str(penetration)]);
        elseif mode == 2
            save([path, '\modeEV', num2str(penetration)]);
        elseif mode == 3
            save([path, '\modeTCL', num2str(penetration)]);
        else
            save([path, '\modeAging', num2str(penetration)]);
        end
    end
    clearvars -except dataPath modeType mode penetration RATIO 
    load(dataPath);
    EV = 5 * RATIO * penetration / 10;
    priceDriven;
    save([path, '\modePD', num2str(penetration)]);
    clearvars -except dataPath modeType mode penetration RATIO 
end
closematlabpool();