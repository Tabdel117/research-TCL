% FFAȺ����پ���

figure; hold on;
H1 = stairs(t1, TCLinstantPowerRecord/1000); hold on;
set(H1, 'color', [109, 111, 223]/255, 'LineWidth', 1.5, 'LineStyle', '-', 'marker', 'none');
TCLinstantPower_avg = zeros(1, DAY / T_tcl);
for i = 1 : DAY * 24/ T_tcl
    TCLinstantPower_avg(i) = mean(TCLinstantPowerRecord((i - 1) * (T_tcl /dt) + 1 : i * T_tcl / dt));
end
H0 = stairs(t0 -1, TCLinstantPower_avg/ 1000);
set(H0, 'color', light_blue, 'LineWidth', 0.5, 'LineStyle', '-', 'marker', 'none');
H2 = stairs(T_tcl : T_tcl : DAY * 24, sum(TCLpowerRecord)/1000);
set(H2, 'color', blue, 'LineWidth', 1.5, 'LineStyle', '-', 'marker', 'none');
le = legend([H0, H1, H2, H3, H4], 'ʵ�ʹ���', '1hƽ������', '���幦��(Ŀ�깦��)', '����ʵ�ʹ���', '����ƽ������', 'Orientation', 'vertical'); set(le, 'Box', 'off');
ylabel('FFA�ۺϹ���(MW)')
ylim([min(sum(TCLdata_P_benchmark(1:FFA, :)/1000)) / 1.1, max(sum(TCLdata_P_benchmark(1:FFA, :)/1000)) * 1.1])
plotNormalize;
% FFA�ɱ�ƫ��
H0 = scatter(TCLdata_cost(1,:), TCLdata_cost(2,:),10, watermelon, 'filled');
alpha(0.5);
figure;
boxplot(100 * (TCLdata_cost(1,:) -  TCLdata_cost(2,:))./ TCLdata_cost(2,:), 0, '+', 0);
xlabel('������(%)')
set(gcf,'unit','normalized','position',[0,0,0.25,0.1]);
set(gca,'YTicklabel',{''})


% TCL�������ߺ�ʵ����Ӧ����
draw(1, EVdata_beta(tcl), TCLdata_P(tcl, :), TCLpowerRecord(tcl, :), TCLdata_PN(tcl), TCLdata_Ta(tcl, :), ...
    T_tcl, Tout, TCLdata_T(1, tcl), TCLdata_T(2, tcl), blue, tomato, light_blue, 0, dt, I2, I1, t1, t2);
