% time of use price
% ��ʱ��23:00��7:00 0.43Ԫ
% ��ʱ��8:30~11:30, 16:00~21:00 1.17Ԫ
% ����ƽʱ 0.8Ԫ
priceValley = 0.43;
pricePeak = 1.17;
priceFlat = 0.8;
gridPriceOneDay = priceFlat * ones(1, 24 * 4);
gridPriceOneDay(1:28) = priceValley;
gridPriceOneDay(end-3:end) = priceValley;
gridPriceOneDay(35:46) = pricePeak;
gridPriceOneDay(65:84) = pricePeak;
sigmaRecordOneDay = 0.5 * gridPriceOneDay;