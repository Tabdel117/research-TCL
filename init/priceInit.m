% time of use price
% ��ʱ��23:00��7:00 0.43Ԫ
% ��ʱ��8:30~11:30, 16:00~21:00 1.17Ԫ
% ����ƽʱ 0.8Ԫ

gridPriceOneDay = 0.8 * ones(1, 24 * 4);
gridPriceOneDay(1:28) = 0.43;
gridPriceOneDay(end-3:end) = 0.43;
gridPriceOneDay(35:46) = 1.17;
gridPriceOneDay(65:84) = 1.17;
sigmaRecordOneDay = 0.5 * gridPriceOneDay;