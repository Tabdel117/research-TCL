% ����EV�Ƿ��뿪�����رջ�����Ӧ�յ� 
for ev = 1 : EV
    if time >= EVdata(1, ev) || time < EVdata(2,ev)
        isUserAtHome(ev) = 1;
    else
        isUserAtHome(ev) = 0;
    end
end
isTCLon = repmat(isUserAtHome, 2, 1);
if willFFAclose
    isFFAon = isTCLon(1:FFA, :);
else
    isFFAon = ones(FFA, 1);
end
if willIVAclose
    isIVAon = isTCLon(FFA + 1:end, :);
else
    isIVAon = ones(IVA, 1);
end