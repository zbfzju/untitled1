L = bwlabel(binary): %binary = �������������ͼ
rect = zeros(size(binary));
rect(L==3) = 1; %ͼ�о����ǵ���������
rect = repmat(rect,[1,1,3]);
rect(rect==1) = I(rect==1); % I = RGBͼ