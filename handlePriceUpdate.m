function[myDemand]= handlePriceUpdate(demand,mypriceValue, mkt)     

minMarketPrice=mkt(1);%1����г����
maxMarketPrice=mkt(2);%2����г����
step=(maxMarketPrice-minMarketPrice)/mkt(3);
p = (mypriceValue - minMarketPrice) / step+1;
p1 =  fix((mypriceValue - minMarketPrice) / step)+1;
p2 =  fix((mypriceValue - minMarketPrice) / step)+2;
if p1==mkt(3)+1
    myDemand=demand(p1);
else
    if  p1 ~= p2
        slope = (demand(p2) - demand(p1)) / (p2 - p1);
        myDemand = slope * (p - p1) + demand(p1);
    else
        myDemand = demand(p1);
    end
end

end