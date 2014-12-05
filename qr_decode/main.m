clear;clc;clear all;
f = imread('test6.jpg');
f = rgb2gray(f);
[H,W] = size(f);
sum1 = 0;
for i = 1 : H
    for j = 1 : W
        sum1 = sum1 + double(f(i,j));
    end
end
m = sum1 / (H*W);
model = ones(H,W) * m;
r = f > m;
%figure;
%imshow(uint8(abs(f)));
f=double(f);
f=medfilt2(f,[5,5]);  %��ά��ֵ�˲���
gb2=segNiBlack(f,48,-0.1);  %��������
gb2=medfilt2(gb2,[7,7]);  %�ٴε�����ֵ�˲���

subplot(1,2,1)
imshow(gb2);



%��λģ�����ĵ���������

mid_points_and_minlength_and_level = get_mid_point(gb2);
mid_point1 = mid_points_and_minlength_and_level(1,:);
mid_point2 = mid_points_and_minlength_and_level(2,:);
mid_point3 = mid_points_and_minlength_and_level(3,:);
blocks = mid_points_and_minlength_and_level(4,2)+7;
minlength = mid_points_and_minlength_and_level(4,1);
level = (blocks-21)/4+1;

%��λ��ʼ��
[sort_length,index] = sort([distance([0,0],mid_point1),distance([0,0],mid_point2),distance([0,0],mid_point3)]);
switch index(1)
    case 1
        start_point(1) = mid_point1(1) - 4*minlength;
        start_point(2) = mid_point1(2) - 4*minlength;
    case 2
        start_point(1) = mid_point2(1) - 4*minlength;
        start_point(2) = mid_point2(2) - 4*minlength;
    case 3
        start_point(1) = mid_point3(1) - 4*minlength;
        start_point(2) = mid_point3(2) - 4*minlength;
    otherwise
end
hold on;
%mark(start_point,'yellow');

%---------------------------------��Ϣ������------------------------------------------------
%��ת�任�ͷ���任�����ݲ�����
%��ת�Ƕ�
%����任
%˫���Բ�ֵУ��ͼ��
%-------------------------------------------------------------------------------------------

%����ɨ�貿��
hold on;
info_of_qrcode = zeros(blocks);
for i = 1 : blocks
    for j = 1 : blocks
        info_of_qrcode(i,j) = gb2(start_point(1)+i*minlength,start_point(2)+j*minlength);
        mark([start_point(1)+i*minlength,start_point(2)+j*minlength],'blue');
    end
end
subplot(1,2,2)
imshow(info_of_qrcode);

%---------------------------------��Ϣ������------------------------------------------------
%�õ���ʽ��Ϣ���������Ϣ
[h,w] = size(info_of_qrcode);
info_inqr = [];
info_inqr2 = [];
info_inqr(15) = info_of_qrcode(1,9);
info_inqr(14) = info_of_qrcode(2,9);
info_inqr(13) = info_of_qrcode(3,9);
info_inqr(12) = info_of_qrcode(4,9);
info_inqr(11) = info_of_qrcode(5,9);
info_inqr(10) = info_of_qrcode(6,9);
info_inqr(9) = info_of_qrcode(8,9);
info_inqr(8) = info_of_qrcode(9,9);
info_inqr(7) = info_of_qrcode(9,8);
info_inqr(6) = info_of_qrcode(9,6);
info_inqr(5) = info_of_qrcode(9,5);
info_inqr(4) = info_of_qrcode(9,4);
info_inqr(3) = info_of_qrcode(9,3);
info_inqr(2) = info_of_qrcode(9,2);
info_inqr(1) = info_of_qrcode(9,1);

info_inqr2(15) = info_of_qrcode(9,w);
info_inqr2(14) = info_of_qrcode(9,w-1);
info_inqr2(13) = info_of_qrcode(9,w-2);
info_inqr2(12) = info_of_qrcode(9,w-3);
info_inqr2(11) = info_of_qrcode(9,w-4);
info_inqr2(10) = info_of_qrcode(9,w-5);
info_inqr2(9) = info_of_qrcode(9,w-6);
info_inqr2(8) = info_of_qrcode(9,w-7);
info_inqr2(7) = info_of_qrcode(h-6,9);
info_inqr2(6) = info_of_qrcode(h-5,9);
info_inqr2(5) = info_of_qrcode(h-4,9);
info_inqr2(4) = info_of_qrcode(h-3,9);
info_inqr2(3) = info_of_qrcode(h-2,9);
info_inqr2(2) = info_of_qrcode(h-1,9);
info_inqr2(1) = info_of_qrcode(h,9);

is_same = info_inqr == info_inqr2;
the_sum = 0;
for i = 1 : length(is_same)
    the_sum = the_sum + is_same(i);
end
if(the_sum == length(is_same))
    %��ʽ��Ϣ�޴��󣬲���Ҫ���о���
    info_style = '';
    for i = 1 : length(info_inqr)
        info_style = strcat(info_style,num2str(info_inqr(i)));
    end
    
else
    %��ʽ��Ϣ������
    
end

%�õ��������ּ��������Ϣ
%�õ�����У�����Ϣ
%�õ�ԭʼ��Ϣ
%-------------------------------------------------------------------------------------------



%{
%���뱸�ݲ���

%}
