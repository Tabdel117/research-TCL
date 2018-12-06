function [ bidCurve ] = EVbid( mkt,Pmax,Pmin,Pavg,gamma,pavg,sigma )
%����BidPara�����Ĳ����Լ��û��趨��gamma������Ԥ��ĵ��ֵ����Ͷ��
mkt_min=mkt(1);%�г����
mkt_max=mkt(2);
step=mkt(3);
bidCurve=zeros(1,step+1);

pmax=min(pavg+gamma*sigma,mkt_max);%Ԥ����ƽ��ֵpavg,����sigma
pmin=max(pavg-gamma*sigma,mkt_min);
pCurve=(mkt_min:(mkt_max-mkt_min)/step:mkt_max);
for i=1:step+1
    if pCurve(i)<=pmin
        bidCurve(i)=Pmax;
    elseif pCurve(i)<=pavg
        bidCurve(i)=Pmax-(pCurve(i)-pmin)*(Pmax-Pavg)/(pavg-pmin);
    elseif pCurve(i)<=pmax
        bidCurve(i)=Pavg-(pCurve(i)-pavg)*(Pavg-Pmin)/(pmax-pavg);
    else
        bidCurve(i)=Pmin;
    end
end
% plot(bidCurve,pCurve);
end

