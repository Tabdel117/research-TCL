close all;
global dt T T_tcl I1 I I2 EV FFA IVA RATIO TOTAL_PLOT t1 t2                                                                                                                                         
T = 15 / 60;%控制周期15min                                                                                                                                              
dt = 1 / 60 / 60;%空调控制周期2s                                                                                                                                          
I1 = 24 / dt;                                                                                                                                                       
I = 24 / T;                                                                                                                                                        
T_tcl = 1; %空调控制指令周期60min                                                                                                                                       
I_tcl = T_tcl / T;                                                                                                                                
T_mpc = 6;                                                                                                                                             
I2 = 24 / T_tcl;                   
orange = [1 0.65 0];
gold = [1 0.843 0];
gray = [0.8 0.8 0.8];
black = [0, 0, 0];
olivedrab = [0.41961 0.55686 0.13725];
light_olivedrab = [203, 218, 175] / 255;
yellowgreen = [0.60392 0.80392 0.19608];

firebrick = [0.69804 0.13333 0.13333];
tomato = [1 0.38824 0.27843];
brown = [0.80392 0.2 0.2];
maroon = [0.6902 0.18824 0.37647];

royalblue = [0.2549 0.41176 0.88235];
royalblue_dark = [0.15294 0.25098 0.5451];
darkblue =[0 0 0.5451];
dodgerblue = [0.11765 0.56471 1];
light_dodgerblue = [157,197,238]/255;
indianred = [1 0.41 0.42];
chocolate3 = [0.804 0.4 0.113];
tan2 = [0.93  0.60 0.286];

green = [103, 138 ,38] / 255;
blue = [38, 131, 138] / 255;
orange = [138, 78, 38] / 255;

t1 = dt: dt : 24;
t = T : T :24;
t2 = 0 : T_tcl : 24;

%----------------------
%主变功率，EV，TCL功率曲线，
%电价曲线
TOTAL_PLOT = 2;
subplot(TOTAL_PLOT, 1 ,1);
isFill = 0;
hold on;
yyaxis left
%IVA TCL EV上下限
light_green = [154, 184, 98] / 255;
light_blue = [98, 171, 184] / 255;
light_orange = [184, 154, 98] / 255;
if isTCLflex == 1
    H0 = fill([t, fliplr(t)], [offsetArray(sum(IVAminPowerRecord/1000), I / 2), fliplr(offsetArray(sum(IVAmaxPowerRecord/1000), I / 2))], light_orange);
    alpha(0.5);set(H0, {'LineStyle'}, {'none'});
    aggTCLminPowerRecord = sum(TCLminPowerRecord);
    aggTCLmaxPowerRecord = sum(TCLmaxPowerRecord);
    H2 = fill([t2, fliplr(t2)], [appendStairArray(offsetArray(aggTCLminPowerRecord, I2 / 2))/1000, fliplr(appendStairArray(offsetArray(aggTCLmaxPowerRecord, I2 / 2))/1000)], light_blue);
    alpha(0.5);set(H2, {'LineStyle'}, {'none'});
end
if isEVflex == 1
    H1 = fill([t, fliplr(t)], [offsetArray(sum(EVminPowerRecord/1000), I / 2), fliplr(offsetArray(sum(EVmaxPowerRecord/1000), I / 2))], light_green);
    alpha(0.5);set(H1, {'LineStyle'}, {'none'});
end

TCLpowerAvg = zeros(1, I2);
TCLpowerAvg_benchmark = zeros(1, I2);

for i = 1 : I2
    if isTCLflex == 1
        TCLpowerAvg(1, i) = mean(sum(TCLdata_P(:, (i - 1) * T_tcl / dt + 1 : i * T_tcl / dt)));
    end
    TCLpowerAvg_benchmark(1, i) = mean(sum(TCLdata_P_benchmark(1: FFA, (i - 1) * T_tcl / dt + 1 : i * T_tcl / dt)));
end
if isEVflex == 1
    Hev = plot(t, offsetArray(sum(EVavgPowerRecord), I / 2) / 1000);
    set(Hev, 'color', green, 'LineWidth', 1, 'LineStyle', '-.', 'marker', 'none');
end
H1 = plot(t, [offsetArray(EV_totalpowerRecord/1000, I / 2); offsetArray(tielineRecord/1000, I / 2) ]);
set(H1(1), 'color', green, 'LineWidth', 1.5, 'LineStyle', '-', 'marker', 'none');
set(H1(2), 'color', [138, 38, 38]/ 255, 'LineWidth', 1.5, 'LineStyle', '-');

if isTCLflex ==1
    Htcl = stairs(t2, appendStairArray(offsetArray(sum(TCLsetPowerRecord), I2 / 2))/1000);
    set(Htcl, 'color', blue, 'LineWidth', 1.5, 'LineStyle', '-.', 'marker', 'none');
    Hiva = plot(t, offsetArray(sum(IVAsetPowerRecord), I / 2) / 1000);
    set(Hiva, 'color', orange, 'LineWidth', 1, 'LineStyle', '-.', 'marker', 'none');
end
H4(1) = stairs(t, offsetArray(TCL_totalpowerRecord, I2 / 2)/1000);
H4(2) = plot(t, offsetArray(IVA_totalpowerRecord/1000, I / 2));
set(H4(1), 'color', blue, 'LineWidth', 1.5, 'LineStyle', '-', 'marker', 'none');
set(H4(2), 'color', orange, 'LineWidth', 1.5, 'LineStyle', '-');

H3 = plot(t2, tielineBuy/1000 * ones(1, length(t2)),...
    'color', black, 'LineWidth' , 1, 'LineStyle', ':', 'DisplayName', '功率上限', 'marker', 'none');

% ylim([-tielineSold/1000, tielineBuy/1000 * 1.1]);
ylabel('功率(MW)')
yyaxis right
H5 = plot(1 / 60 : 1 / 60 : 24 , offsetArray(Tout, 720), 'color', tomato, 'LineWidth', 1.5, 'LineStyle', '-', 'DisplayName', '室外温度');
ylabel('温度(摄氏度)');
% le = legend([H1(2), H1(1), H4(1), Hev, Htcl, H5],...
%     '主变功率', 'EV出清功率', 'TCL出清功率', 'EV最优功率', 'TCL最优功率', '室外温度','Orientation','horizontal'); set(le, 'Box', 'off')
xlim([0, 24]);
xticks(0 : 6 : 24);
% xticklabels({ '12:00', '18:00', '24:00', '6:00', '12:00'});
set(gca,'xticklabel','');

subplot(TOTAL_PLOT, 1, 2); hold on;
yyaxis left;
Hbar = bar(t - 0.25, [offsetArray(gridPriceRecord4, I / 2);offsetArray(priceRecord - gridPriceRecord4, I / 2)]', 'stacked');
Hbar(1).FaceColor = gray;
Hbar(1).EdgeColor = Hbar(1).FaceColor;
Hbar(2).FaceColor = chocolate3;
Hbar(2).EdgeColor = 'none';% Hbar(2).FaceColor;
ylabel('电价(元/kWh)');
yyaxis right;

H1 = stairs(t, offsetArray((TCL_totalpowerRecord + IVA_totalpowerRecord)/1000, I2 / 2));
set(H1, 'color', black, 'LineWidth', 1, 'LineStyle', '-', 'marker', 'none');

if isTCLflex == 1
    H0 = plot(t1, offsetArray(sum(TCLdata_P/1000), I1 / 2));
    set(H0, 'color', black, 'LineWidth', 0.5, 'LineStyle', '-', 'marker', 'none');
    H2 = stairs(t2, appendStairArray(offsetArray(TCLpowerAvg/1000, I2 / 2)));
    set(H2, 'color', dodgerblue - 0.1, 'LineWidth', 2, 'LineStyle', '-', 'marker', 'none');
    H3 = stairs(t2, appendStairArray(offsetArray(TCLpowerAvg_benchmark/1000, I2 / 2)));
    set(H3, 'color', brown, 'LineWidth', 2, 'LineStyle', '-', 'marker', 'none');
    ylim([min(sum(TCLdata_P/1000)) / 1.1, max(sum(TCLdata_P/1000)) * 1.1])
    le = legend([H1, H2, H0, H3],'出清功率', '平均功率','实际功率', '不控功率', 'Orientation','horizontal'); set(le, 'Box', 'off');

else
    H0 = plot(t1, offsetArray(sum(TCLdata_P_benchmark/1000), I1 / 2));
    set(H0, 'color', black, 'LineWidth', 0.5, 'LineStyle', '-', 'marker', 'none');
    H2 = stairs(t2, appendStairArray(offsetArray(TCLpowerAvg_benchmark/1000, I2 / 2)));
    set(H2, 'color', dodgerblue - 0.1, 'LineWidth', 2, 'LineStyle', '-', 'marker', 'none');
    ylim([min(sum(TCLdata_P_benchmark/1000)) / 1.1, max(sum(TCLdata_P_benchmark/1000)) * 1.1]);
    le = legend([H1, H2, H0],'实际功率', '平均功率','实际功率', 'Orientation','horizontal'); set(le, 'Box', 'off');
end

ylabel('TCL聚合功率(MW)');
xlim([0, 24]);
xticks(0 : 6 : 24);
xticklabels({ '12:00', '18:00', '24:00', '6:00', '12:00'});
% set(gca,'xticklabel','');

% subplot(TOTAL_PLOT, 1, 3); hold on;
% H1 = plot(t1, offsetArray(TCLdata_Ta_benchmark, I1 / 2), 'color', gray , 'LineWidth' , 0.5);
% H2 = plot(t1, offsetArray(TCLdata_Ta, I1 / 2), 'color', maroon, 'LineWidth' , 0.5);
% xlim([0, 24]);
% xticks(0 : 6 : 24);
% xticklabels({ '12:00', '18:00', '24:00', '6:00', '12:00'});
% le = legend([H1(1), H2(1)], '参与优化', '不参与优化', 'Orientation','vertical'); set(le, 'Box', 'off');
% set(gcf,'unit','normalized','position',[0,0,0.3,0.5]);

if isAging == 0 %计算老化
    for i = 1 : I
        t_index = mod(i - 1 + offset / T , I) + 1;
        mod_t = mod(t_index, I) + 1;
        mod_t_1 = mod(t_index - 1, I) + 1;
        isBid = 0;
        time = (t_index - 1) * T ;
        theta_a = mean(Tout( 1 + time * 60 : (time + 0.25) * 60));%C
        transformer_ageing;
    end
end

if isTCLflex == 1
    figure; hold on;
    TOTAL_PLOT = 3;
    %TCL跟踪曲线和实际响应曲线
    [~, tcl_max] = max(EVdata_beta(1 : FFA));
    draw(1, EVdata_beta(tcl_max), TCLdata_P(tcl_max, :), TCLpowerRecord(tcl_max, :), TCLdata_PN(tcl_max), TCLdata_Ta(tcl_max, :), ...
        T_tcl, Tout, TCLdata_T(1, tcl_max), TCLdata_T(2, tcl_max), dodgerblue, black, tomato, 0);
    tcl = 1;
    draw(2, EVdata_beta(tcl), TCLdata_P(tcl, :), TCLpowerRecord(tcl, :), TCLdata_PN(tcl), TCLdata_Ta(tcl, :),...
        T_tcl, Tout, TCLdata_T(1, tcl), TCLdata_T(2, tcl), dodgerblue, black, tomato, 0);
    [~, tcl_min] = min(EVdata_beta(1 : FFA));
    draw(3, EVdata_beta(tcl_min), TCLdata_P(tcl_min, :), TCLpowerRecord(tcl_min, :), TCLdata_PN(tcl_min), TCLdata_Ta(tcl_min, :),...
        T_tcl, Tout, TCLdata_T(1, tcl_min), TCLdata_T(2, tcl_min), dodgerblue, black, tomato, 1);
    set(gcf,'unit','normalized','position',[0,0,0.2,0.4]);
end
%各TCL实际成本和优化所得成本
%统计单个TCL电费
TCLdata_cost = zeros(3, FFA);
for tcl = 1 : FFA
    cost = 0;
    cost_benchmark = 0;
    for i = 1 : 24
        if isTCLflex == 1
            cost = cost + T * mean(TCLdata_P(tcl, (i - 1) * T_tcl / dt + 1 : i * T_tcl / dt )) * gridPriceRecord(1, i);
        end
        cost_benchmark = cost_benchmark + T * mean(TCLdata_P_benchmark(tcl, (i - 1) * T_tcl / dt + 1 : i * T_tcl / dt )) * gridPriceRecord(1, i);
    end
    if isTCLflex == 1
        TCLdata_cost(1, tcl) = cost;
        TCLdata_cost(2, tcl) = T * TCLpowerRecord(tcl, :) * gridPriceRecord';
    end
    TCLdata_cost(3, tcl) = cost_benchmark;
end
if isTCLflex == 1
IVAdata_cost(1,:) = gridPriceRecord4 * IVApowerRecord' * T;
IVAdata_cost(2,:) = priceRecord * IVApowerRecord'* T;
end

EVdata_cost(1,:) = gridPriceRecord4 * EVpowerRecord' * T;
EVdata_cost(2,:) = priceRecord * EVpowerRecord'* T;

%计算配网成本
DSO_cost(1) = tielineRecord * (priceRecord - gridPriceRecord4)' * T; %DSO收益
DSO_cost(2) = sum(DL_record) * install_cost / expectancy;%变压器老化成本
DSO_cost(3) = tielineRecord * gridPriceRecord4' * T; %配网总用电成本
%-------------function definition-------------------------------------
function [] = draw( subNo, beta, P, powerRecord, PN, Ta,...
    T_tcl, Tout, T_max, T_min,  dodgerblue, black, tomato, showAxis)
global dt I2 I1 t1 t2 TOTAL_PLOT
P = offsetArray(P, I1 / 2);
powerRecord = offsetArray(powerRecord, I2 / 2);
Ta = offsetArray(Ta, I1 / 2);
Tout = offsetArray(Tout, 720);
subplot(TOTAL_PLOT, 1, subNo);
hold on;
TCLpowerAvg = zeros(1, I2);
for ii = 1 : I2
    TCLpowerAvg(1, ii) = mean(P(1, (ii - 1) * T_tcl / dt + 1 : ii * T_tcl / dt));
end
yyaxis left
H1 = stairs(t2, appendStairArray(powerRecord), 'color', black, 'LineWidth', 2, 'DisplayName', '出清功率');
H2 = stairs(t2, appendStairArray(TCLpowerAvg) , 'color', dodgerblue, 'LineWidth', 1, 'DisplayName', '平均功率', 'LineStyle', '-');
ylabel('单个TCL功率(kW)');
ylim([0, PN]);
yyaxis right
TaNormalize = (Ta - T_min) / (T_max - T_min) * 100;
H3 = plot(t1, TaNormalize , 'color', tomato, 'LineWidth', 1.5,'DisplayName', '室内温度');
plot(t1, [zeros(1, I1); 100 * ones(1, I1)],...
    'color', tomato, 'LineWidth' , 0.5, 'LineStyle', '-.', 'DisplayName', '室温上下限');
ylabel('SOA(%)');

le = legend([H1, H2, H3], '出清功率', '平均功率', 'SOA', 'Orientation','horizontal'); set(le ,'Box', 'off');
ymin =  min(0, min(TaNormalize));
ymax = max(100, max(TaNormalize));
ylim([ymin - 10, ymax + 10]);
xlim([0, 24]);
xticks(0 : 6 : 24);
if showAxis == 1
    xticklabels({ '12:00', '18:00', '24:00', '6:00', '12:00'});
else
    set(gca,'xticklabel','');
end
content = sprintf('gamma = %2f', beta);
title(content)
end

function [ result ] = offsetArray(array, offset)
[row, col] = size(array);
offset = mod(offset, max(row, col));
if row == 1 %行向量
    result = [ array(1, offset + 1 : end), array(1, 1: offset)];
elseif col == 1
    result = [ array(offset + 1: end, 1); array(1 : offset, 1)];
else
    result = [ array(:, offset + 1 : end), array(:, 1: offset)];
end
end

function [ result ] = appendStairArray(array)%为stairs作图的数组增加最后一列
[row, col] = size(array);
if col > 1 %行向量
    result = [array, array(end)];
else
    result = [array; array(end)];
end
end