close all;
isEn = 0;
% load('../../data/0423/hiearchical.mat')
load('../../data/COLOR');

% transAdmm1.calculateCost();
% transAdmm2.calculateCost();
% transAdmm3.calculateCost();
% ccpAdmm.calculateCost();
trans1.calculateCost();
trans2.calculateCost();
trans3.calculateCost();
ccp.calculateCost();

% transAdmm1.priceRecord = pu_avg(:,1) + gridPriceRecord;
% transAdmm2.priceRecord = pu_avg(:,2) + gridPriceRecord;
% transAdmm3.priceRecord = pu_avg(:,3)+ gridPriceRecord;
% ccpAdmm.priceRecord =  pu_avg(:,4)+ gridPriceRecord;

t = T : T :24;
t2 = 0 : T_tcl : 24;
load('../../data/COLOR');

% ����
figure; hold on;
H0 = fill([t, fliplr(t)], [DRmode'/max(DRmode)*max(ccp.tielineRecord/1000)*1.1, zeros(1, length(t))], gray);
    alpha(0.5);set(H0, {'LineStyle'}, {'none'});
H = plot(t, ccp.tielineRecord/1000,...
    'color', black, 'LineWidth', 2, 'LineStyle', '-', 'marker', 'none', 'DisplayName', 'T');
H01 = plot(t, ccp.CAPACITY * ones(1, I)/1000,...
    'color', tomato, 'LineWidth', 1, 'LineStyle', '--', 'marker', 'none', 'DisplayName', 'T');
if isEn == 1
    xlabel('t(h)')
    ylabel('transformer power(MW)')
    le = legend([H1, H2, H3], 'T1', 'T2', 'T3'); 
    set(gcf,'unit','normalized','position',[0,0,0.3,0.15]);
else
    xlabel('ʱ��(��)')
    ylabel('���书��(MW)')
    set(gcf,'Position',[0 0 650 250]);
end
xlim([0, 24 * 1]);
ylim([5, max(ccp.tielineRecord/1000)*1.1])
xticks(0 : 12 : 24 * 1);
xticks(0 : 6 : 24 * 1);
xticklabels({ '12:00', '18:00', '24:00', '6:00', '12:00'});


figure; hold on;
H0 = fill([t, fliplr(t)], [DRmode'/max(DRmode)*max(ccp.tielineRecord/1000)*1.1, zeros(1, length(t))], gray, 'DisplayName', '������Ӧʱ��');
    alpha(0.5);set(H0, {'LineStyle'}, {'none'});
H1 = plot(t, trans1.tielineRecord/1000,...
    'color', darkblue, 'LineWidth', 1.5, 'LineStyle', '-', 'marker', 'none', 'DisplayName', 'T1');
H2 = plot(t, trans2.tielineRecord/1000,...
    'color', darkblue, 'LineWidth', 1.5, 'LineStyle', '--', 'marker', 'o', 'DisplayName', 'T2', 'MarkerSize', 2);
H3 = plot(t, trans3.tielineRecord/1000,...
    'color', black, 'LineWidth', 1.5, 'LineStyle', '--', 'marker', 'none', 'DisplayName', 'T3');
H11 = plot(t, trans1.CAPACITY * ones(1, I)/1000,...
    'color', tomato, 'LineWidth', 1, 'LineStyle', '--', 'marker', 'none', 'DisplayName', 'T1');

H0 = fill([t, fliplr(t)], [DRmode'/max(DRmode)*max(ccp.tielineRecord/1000)*1.1, zeros(1, length(t))], gray);
    alpha(0.5);set(H0, {'LineStyle'}, {'none'});
 
if isEn == 1
    xlabel('t(h)')
    ylabel('transformer power(MW)')
    le = legend(H0, [H1, H2, H3], 'Demand response period''T1', 'T2', 'T3'); 
    set(gcf,'unit','normalized','position',[0,0,0.3,0.15]);
else
    xlabel('ʱ��(��)')
    ylabel('��ѹ������(MW)')
    le = legend([H0, H1, H2, H3],'������Ӧʱ��' ,'����ѹ��T1', '����ѹ��T2', '����ѹ��T3'); 
    set(gcf,'Position',[0 0 650 250]);
end
set(le, 'Box', 'off', 'Orientation', 'horizontal')
DAY = 1;
xlim([0, 24 * DAY]);
ylim([1.3, 4])
xticks(0 : 12 : 24 * DAY);
xticks(0 : 6 : 24 * DAY);
xticklabels({ '12:00', '18:00', '24:00', '6:00', '12:00'});


% figure;
% hold on
% H1 = plot(t, ccpAdmm.DL_record,...
%     'color', tomato, 'LineWidth', 2, 'LineStyle', '--', 'marker', 'none', 'DisplayName', '����');
% H2 = plot(t, transAdmm1.DL_record,...
%     'color', purple, 'LineWidth', 2, 'LineStyle', '--', 'marker', 'none', 'DisplayName', '���վ1');
% H3 = plot(t, transAdmm2.DL_record,...
%     'color', blue, 'LineWidth', 2, 'LineStyle', '--', 'marker', 'none', 'DisplayName', '���վ2');
% H4 = plot(t, transAdmm3.DL_record,...
%     'color', green, 'LineWidth', 2, 'LineStyle', '--', 'marker', 'none', 'DisplayName', '���վ3');

% H1 = plot(t, ccp.DL_record,...
%     'color', tomato, 'LineWidth', 1.5, 'LineStyle', '-', 'marker', 'none', 'DisplayName', '����');
% H2 = plot(t, trans1.DL_record,...
%     'color', purple, 'LineWidth', 1.5, 'LineStyle', '-', 'marker', 'none', 'DisplayName', '���վ1');
% H3 = plot(t, trans2.DL_record,...
%     'color', blue, 'LineWidth', 1.5, 'LineStyle', '-', 'marker', 'none', 'DisplayName', '���վ2');
% H4 = plot(t, trans3.DL_record,...
%     'color', green, 'LineWidth', 1.5, 'LineStyle', '-', 'marker', 'none', 'DisplayName', '���վ3');
% xlim([0, 24 * DAY]);
% xticks(0 : 12 : 24 * DAY);
% xticks(0 : 6 : 24 * DAY);
% xticklabels({ '12', '18', '24', '6', '12'});
% xlabel('t(h)')
% set(gcf,'unit','normalized','position',[0,0,0.3,0.15]);ylabel('lol of life(min)')

% figure
% plot(dlRecord,'DisplayName','dlRecord')
% ���
figure
hold on;
H0 = fill([t, fliplr(t)], [DRmode'/max(DRmode)*mkt_max, zeros(1, length(t))], gray);
    alpha(0.5);set(H0, {'LineStyle'}, {'none'});
H0 = plot(t, ccp.gridPriceRecord ,...
    'color', [0.5 0.5 0.5], 'LineWidth', 2, 'LineStyle', '-', 'marker', 'o', 'DisplayName', '�������','MarkerSize', 3);
H1 = plot(t, ccp.priceRecord,...
    'color', tomato, 'LineWidth', 1.5, 'LineStyle', ':', 'marker', 'none', 'DisplayName', '���������');
H2 = plot(t, trans1.priceRecord,...
    'color', darkblue, 'LineWidth', 1, 'LineStyle', '-.', 'marker', 'none', 'DisplayName', '���վ1������');
H3 = plot(t, trans2.priceRecord,...
    'color', darkblue, 'LineWidth', 1, 'LineStyle', '-', 'marker', 'none', 'DisplayName', '���վ2������');
H4 = plot(t, trans3.priceRecord,...
    'color', black, 'LineWidth', 1, 'LineStyle', '--', 'marker', 'none', 'DisplayName', '���վ3������');

% subplot(2,1,2);
% hold on
% H1 = plot(t, ccpAdmm.priceRecord,...
%     'color', gold, 'LineWidth', 1.5, 'LineStyle', '--', 'marker', 'none', 'DisplayName', '�����');
% H2 = plot(t, transAdmm1.priceRecord,...
%     'color', purple, 'LineWidth', 1.5, 'LineStyle', '--', 'marker', 'none', 'DisplayName', '���վ1���');
% H3 = plot(t, transAdmm2.priceRecord,...
%     'color', blue, 'LineWidth', 1.5, 'LineStyle', '--', 'marker', 'none', 'DisplayName', '���վ2���');
% H4 = plot(t, transAdmm3.priceRecord,...
%     'color', green, 'LineWidth', 1.5, 'LineStyle', '--', 'marker', 'none', 'DisplayName', '���վ3���');
xlim([0, 24 * DAY]);
ylim([0.45, 1.25]);
xticks(0 : 12 : 24 * DAY);
xticks(0 : 6 : 24 * DAY);
xticklabels({ '12:00', '18:00', '24:00', '6:00', '12:00'});
if isEn == 1
    xlabel('t(h)')
    set(gcf,'unit','normalized','position',[0,0,0.3,0.15]);
    ylabel('price(yuan/kW)')
else
    xlabel('ʱ��(��)');
    set(gcf,'Position',[0 0 650 250]);
    ylabel('���(Ԫ/kWh)');
end