function [ result ] = appendStairArray(array)%Ϊstairs��ͼ�������������һ��
[row, col] = size(array);
if col > 1 %������
    result = [array, array(end)];
else
    result = [array; array(end)];
end
end