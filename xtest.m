clear
clc
image = imread("2.png");
gray = rgb2gray(image);
% imshow(gray);
[ counts , num ]  = imhist(gray);
position = find( counts == max(counts));

[ row, col ] = size(gray);

delta = 15;

for i = 1:row
    for j = 1:col
        if gray(i,j) < position + delta
            if gray(i,j) > position - delta
                gray(i,j) = 255;
            else
                gray(i,j) = 0;
            end
        else
            gray(i,j) = 0;
        end
    end
end

RGB = imread('2.png');%Read the image
Highlight=RGB;
I=rgb2gray(RGB); %transform the image to gray
[x,y]=size(I);   %get the size of the picture
BW=edge(I);      %get the edge of the picture


rho_max=floor(sqrt(x^2+y^2))+1; %��ԭͼ����������������ֵ����ȡ�������ּ�1
%��ֵ��Ϊ�ѣ�������ϵ�����ֵ
accarray=zeros(rho_max,180); %����ѣ�������ϵ�����飬��ֵΪ0��
%�ȵ����ֵ��180��

Theta=[0:pi/180:pi]; %��������飬ȷ����ȡֵ��Χ

for n=1:x,
    for m=1:y
        if BW(n,m)==1
            for k=1:180
            %����ֵ����hough�任���̣����ֵ
                rho=(m*cos(Theta(k)))+(n*sin(Theta(k)));
                %����ֵ������ֵ�ĺ͵�һ����Ϊ�ѵ�����ֵ���������꣩����������Ϊ�˷�ֹ��ֵ���ָ���
                rho_int=round(rho/2+rho_max/2);
                %�ڦѦ����꣨���飩�б�ʶ�㣬�������ۼ�
                accarray(rho_int,k)=accarray(rho_int,k)+1;
            end
        end
    end
end



%=======����hough�任��ȡֱ��======%
%Ѱ��100���������ϵ�ֱ����hough�任���γɵĵ�
K=1; %�洢���������
for rho_n=1:rho_max %��hough�任�������������
    for theta_m=1:180
        if accarray(rho_n,theta_m)>=100 %�趨ֱ�ߵ���Сֵ��
        case_accarray_n(K)=rho_n; %�洢�������������±�
        case_accarray_m(K)=theta_m;
        K=K+1;
        end
    end
end

%=====����Щ�㹹�ɵ�ֱ����ȡ����,���ͼ������ΪI_out===%
I_out=zeros(x,y);
I_jiao_class=zeros(x,y);
for n=1:x,
    for m=1:y
         if BW(n,m)==1
             for k=1:180
              rho=(m*cos(Theta(k)))+(n*sin(Theta(k)));
              rho_int=round(rho/2+rho_max/2);
             %������ڼ���ĵ�����100�������ϵ㣬�������ȡ����
                for a=1:K-1
                    if rho_int==case_accarray_n(a)&k==case_accarray_m(a)%%%==gai==%%% k==case_accarray_m(a)&rho_int==case_accarray_n(a)
                    I_out(n,m)=BW(n,m); 
                        for p=0:5 %��ԭRGBͼ���ϸ���
                         Highlight(n,m+p,1)=255;
                         Highlight(n,m+p,2)=0;
                         Highlight(n,m+p,3)=0;
                        end
                    I_jiao_class(n,m)=k;
                    end
                end
             end
         end
    end
end


figure,imshow(RGB);
title('ԭͼ');
imwrite(RGB,'ԭͼ.jpg','jpg');

figure,imshow(BW);
title('edge�����ı߽�ͼ');
imwrite(BW,'edge�����ı߽�ͼ.jpg','jpg');

figure,imshow(I_out);
title('Hough�任������ֱ��');
imwrite(I_out,'Hough�任������ֱ��.jpg','jpg');

figure,imshow(Highlight);
title('�������ͼ');
imwrite(Highlight,'�������ͼ.jpg','jpg');