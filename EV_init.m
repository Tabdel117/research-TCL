%���ɳ�ʼ���ó�ϰ��
TA_avg1=19.82;TA_sigma1=1.92;TD_avg1=7.56;TD_sigma1=2.33;%������
TA_avg2=20;TA_sigma2=2;TD_avg2=9;TD_sigma2=2;%��ĩ
EVdata_week=zeros(2,EV_total);%���湤����ƽ�����Һ��뿪�ҵ�ʱ��
EVdata_weekend=zeros(2,EV_total);%������Ϣ��ƽ�����Һ��뿪�ҵ�ʱ��
%�ڶ��֣�����̬�ֲ���������
EV=EV_total;
% EVdata_weekend=EVdata_week;
EVdata_week(1,:)=normrnd(TA_avg1,TA_sigma1,1,EV);
EVdata_week(2,:)=normrnd(TD_avg1+24,TD_sigma1,1,EV);
EVdata_weekend(1,:)=normrnd(TA_avg2,TA_sigma2,1,EV);
EVdata_weekend(2,:)=normrnd(TD_avg2+24,TD_sigma2,1,EV);

for ev=1:EV
    while EVdata_week(2,ev)<EVdata_week(1,ev)+1
        EVdata_week(2,ev)=normrnd(TD_avg1+24,TD_sigma1);
    end
    while EVdata_week(2,ev)-EVdata_week(1,ev)>20
        EVdata_week(2,ev)=normrnd(TD_avg1+24,TD_sigma1);
    end
    while EVdata_weekend(2,ev)<EVdata_weekend(1,ev)+1%����ͣ��1Сʱ
        EVdata_weekend(2,ev)=normrnd(TD_avg2+24,TD_sigma2);
    end
end

for ev=1:EV
    [EVdata_price_week(1,ev),EVdata_price_week(2,ev)]=price_pred(EVdata_week(1,ev),EVdata_week(2,ev),T,1);
    [EVdata_price_weekend(1,ev),EVdata_price_weekend(2,ev)]=price_pred(EVdata_weekend(1,ev),EVdata_weekend(2,ev),T,2);
end

% EVdata_mile=0.36*exp(normrnd(3.2,0.88,1,EV));%����ʻ���Ϊ������̬�ֲ�����ֵ3.2Ӣ�����0.88.ecr=0.36kWh/mile
EVdata_mile=unifrnd(10,20,1,EV);%����ʻ���Ϊ������̬�ֲ�����ֵ3.2Ӣ�����0.88.ecr=0.36kWh/mile
% EVdata_mile=15*ones(1,EV);
EVdata_capacity=ceil(unifrnd(20,25,1,EV));%��ʾEV����ϻ�

for ev=1:EV
    if EVdata_mile(ev)>EVdata_capacity(ev)-1
        EVdata_mile(ev)=EVdata_capacity(ev)-1;
    end
end
EVdata_alpha=unifrnd(0,1,1,EV);
EVdata_beta=unifrnd(0.5,3,1,EV);
load('./data/bus');
EVdata_busnum=round(EVdata_busnum/500*EV);
allBus=sum(EVdata_busnum);
if allBus>EV
    for busi=1:min(nod33,allBus-EV)
        if EVdata_busnum(busi)>1
            EVdata_busnum(busi)=EVdata_busnum(busi)-1;
        end
    end
elseif allBus<EV
    for busi=min(nod33,EV-allBus):-1:1
        
            EVdata_busnum(busi)=EVdata_busnum(busi)+1;
        
    end
end
% EVdata_busnum=fix(bus(:,3)/sum(bus(:,3))*EV);
bus1=1;
for ev=1:EV
    while ev>sum(EVdata_busnum(1:bus1))
        bus1=bus1+1;
    end
    EVdata_bus(ev)=bus1; 
end
tmp=EVdata_bus;
EVdata_bus=tmp(randperm(numel(tmp)));
for ev=1:EV
    if EVdata_beta(ev)<0.5
        EVdata_beta(ev)=0.5;
    end    
end
EV_ta=zeros(DAY+1,EV);%EV����ʱ��
EV_td=zeros(DAY+1,EV);%EVʵ�����ʱ��
EV_mile_pred=zeros(DAY,EV);%EVԤ���õ���
EV_mile=zeros(DAY,EV);%EVʵ���õ���
% EV_last_a=zeros(1,EV);%�ϴεִ�ʱ����
EV_last_d=zeros(1,EV);%�뿪ʱ����
for day=1:DAY
    day1=mod(day,7);
    if day1>=2 && day1<=6
        for ev=1:EV
            %��Ԥ�����
            EV_ta(day,ev)=normrnd(EVdata_week(1,ev),0.5);
            EV_td(day,ev)=normrnd(EVdata_week(2,ev),0.5);
            while EV_ta(day,ev)>EV_td(day,ev)
                EV_ta(day,ev)=normrnd(EVdata_week(1,ev),0.5);
                EV_td(day,ev)=normrnd(EVdata_week(2,ev),0.5);
            end
        end
    else
        for ev=1:EV
            EV_ta(day,ev)=normrnd(EVdata_weekend(1,ev),0.5);
            EV_td(day,ev)=normrnd(EVdata_weekend(2,ev),0.5);
            while EV_ta(day,ev)>EV_td(day,ev)
                EV_ta(day,ev)=normrnd(EVdata_weekend(1,ev),0.5);
                EV_td(day,ev)=normrnd(EVdata_weekend(2,ev),0.5);
            end
        end
    end
    for ev=1:EV
         EV_mile_pred(day,ev)=min(EVdata_capacity(ev),max(2,normrnd(EVdata_mile(EV),EVdata_mile(EV)*0.1)));        
        EV_mile(day,ev)=min(EVdata_capacity(ev),normrnd(EV_mile_pred(day,ev),EV_mile_pred(day,ev)*0.05));
%         EV_mile(day,ev)=EV_mile_pred(day,ev);
    end
    EV_td(day,:)=EV_td(day,:)+(day-1)*24;
    EV_ta(day,:)=EV_ta(day,:)+(day-1)*24;
end

PN=3.7;
save('EVdata','PN','EV','EV_last_d','EV_mile','EV_mile_pred','EV_ta','EV_td','EVdata_alpha','EVdata_beta','EVdata_bus','EVdata_capacity','EVdata_mile','EVdata_price_week','EVdata_price_weekend','EVdata_week','EVdata_weekend');
