clear;
%��ȡͼ��
G=imread('test6.jpg');
%G=imread('test4.png');
%��ֵ��ͼ��
B=rgb2gray(G);
%��ֵ�˲�
M=medfilt2(B);
% ���䷽��ҵ�һ�����ʵ���ֵ(��ֵ��)
thresh=graythresh(M);
% M�д���thresh�����ؾ���Ϊ1����ɫ����С��thresh�����ؾ���Ϊ0����ɫ��
BW=im2bw(M,thresh);
%imshow(BW);
%ͼ��0��1����
BW2=~BW;
%��̬ѧ����
SE=strel('square',15);
I=imdilate(BW2,SE);
%��ȡ����ͼ������
[height,width]=size(I);
x=0;
y=0;
n=0;
for i=1:height
    for j=1:width
        if I(i,j)==1
            x=x+i;
            y=y+j;
            n=n+1;
        end
    end
end
x=fix(x/n);
y=fix(y/n);
%�����ͨ��
[L,num]=bwlabel(I,8);
%�޳��޹���ͨ��
z=L(x,y);
for i=1:height
    for j=1:width
        if L(i,j)~=z
            L(i,j)=0;
        else
            L(i,j)=1;
        end
    end
end
%��̬ѧ��ʴ
T=imerode(L,SE);
%��ȡ��Ե
T2=bwperim(T);
%Hough�任
E=zeros(height,width);
a=180;                           %�Ƕȵ�ֵΪ0��180��
d=round(sqrt(height^2+width^2));%ͼ��Խ��߳���Ϊp�����ֵ
s=zeros(a,2*d);                  %�洢ÿ��(a,p)����
z=cell(a,2*d);                   %��Ԫ���洢ÿ�������ĵ������
for i=1:height
    for j=1:width                %����ͼ��ÿ����
        if(T2(i,j)==1)           %ֻ���ͼ���Ե�İ׵㣬����㲻���
            for k=1:a
                p =round(i*cos(pi*k/180)+j*sin(pi*k/180));
                %��ÿ�����1��180�ȱ���һ�飬ȡ�þ����õ������ֱ�ߵ�pֵ��ȡ����
                if(p > 0)
                    %��p����0���򽫵�洢�ڣ�d��2d���ռ�
                    s(k,d+p)=s(k,d+p)+1;%��a��p����Ӧ���ۼ�����Ԫ��һ
                    z{k,d+p}=[z{k,d+p},[i,j]'];%�洢������
                else
                    ap=abs(p)+1;%��pС��0���򽫵�洢�ڣ�0��d���ռ�
                    s(k,ap)=s(k,ap)+1;%(a��p)��Ӧ���ۼ�����Ԫ��һ
                    z{k,ap}=[z{k,ap},[i,j]'];%�洢������
                end
            end
        end
    end
end
for i=1:a
    for j=1:d*2 %���ÿ���ۼ�����Ԫ�д洢����
        if(s(i,j) >50) %����ȡֱ�ߵ���ֵ��Ϊ70
            lp=z{i,j};%��ȡ��Ӧ������
            for k=1:s(i,j)
               %��������ֵ�������ۼ�����Ԫ��(a��p)��Ӧ�����е���в���
               E(lp(1,k),lp(2,k))=1;
            end
        end
    end
end
%Ѱ�ұ�Ե��
mor_pic=E;
[mor_pich,mor_picl]=size(mor_pic);
k=(mor_picl-1)/(1-mor_pich);
d1=0; d2=0;d3=0; d4=0;t=0;
d1min=0;d2min=0;d3min=0;d4min=0;
ding=zeros(4,2);
for i =10:mor_pich-10
    for j = 10:mor_picl-10
        if mor_pic(i,j)==1
            d1=abs(j-k*i-1+k)/sqrt(1+k^2);    
            d2=abs(j+(1/k)*i-mor_pich-1/k)/sqrt((-1/k)^2+1);   
            d3=abs(j+(1/k)*i-mor_picl/k-1)/sqrt((-1/k)^2+1);
            d4=abs(j-k*i-mor_picl+mor_pich*k)/sqrt(1+k^2);   
            if t==0      
                d1min=d1;
                ding(1,:)=[i,j];
                d2min=d2;
                ding(2,:)=[i,j];
                d3min=d3;
                ding(3,:)=[i,j];
                d4min=d4;
                ding(4,:)=[i,j];
                t=t+1;
            end
            if d1min>d1
                d1min=d1;
                ding(1,:)=[i,j];
            end
            if d2min>d2
                d2min=d2;
                ding(2,:)=[i,j];
            end            
            if d3min>d3
                d3min=d3;
                ding(3,:)=[i,j];
            end
            if d4min>d4
                d4min=d4;
                ding(4,:)=[i,j];
            end           
        end        
    end
end
figure,imshow(G),hold on
%���Ʊ�Ե��
plot(ding(1,2),ding(1,1),'x','Color','red');
plot(ding(2,2),ding(2,1),'x','Color','red');
plot(ding(3,2),ding(3,1),'x','Color','red');
plot(ding(4,2),ding(4,1),'x','Color','red');
%�����ĸ���Ե����ȡ����ֱ��
K=zeros(4,2);
K(1,1)=atan((ding(2,1)-ding(1,1))/(ding(1,2)-ding(2,2)));
if(K(1,1)<0)
   K(1,1)=K(1,1)+pi;
end
K(1,2)=ding(1,1)*cos(K(1,1))+ding(1,2)*sin(K(1,1));
K(2,1)=atan((ding(3,1)-ding(1,1))/(ding(1,2)-ding(3,2)));
if(K(2,1)<0)
   K(2,1)=K(2,1)+pi;
end
K(2,2)=ding(1,1)*cos(K(2,1))+ding(1,2)*sin(K(2,1));
K(3,1)=atan((ding(4,1)-ding(2,1))/(ding(2,2)-ding(4,2)));
if(K(3,1)<0)
   K(3,1)=K(3,1)+pi;
end
K(3,2)=ding(2,1)*cos(K(3,1))+ding(2,2)*sin(K(3,1));
K(4,1)=atan((ding(3,1)-ding(4,1))/(ding(4,2)-ding(3,2)));
if(K(4,1)<0)
   K(4,1)=K(4,1)+pi;
end
K(4,2)=ding(3,1)*cos(K(4,1))+ding(3,2)*sin(K(4,1));
k = K;
%%
%
%�޸Ħ� ��
for i=1:4
   K(i,1)=K(i,1)/pi*180;
   if K(i,2)>0
       K(i,2)=K(i,2)+d;
   else
       K(i,2)=abs(K(i,2))+1;
   end
end
%���ۼ�������
m=zeros(4,2);
[a,index]=sort(s(:),'descend');
i=1;
while(i<5)
    j=1;
    flag=0;
    while(flag==0)
        m(i,2)=fix((index(j,1)-1)/180)+1;          % ��ȡ��
        m(i,1)=index(j,1)-(m(i,2)-1)*180;          % ��ȡ��
        %��ȡ��Χ�����ۼ�ֵ���ĦѦ�
        if abs(m(i,1)-K(i,1))<1&&abs(m(i,2)-K(i,2))<1
            flag=1;
            i=i+1;
        else
            j=j+1;
        end
    end
end
n=zeros(4,2);
for i=1:4
    n(i,1)=m(i,1)/180*pi;
    if m(i,2)>d
        n(i,2)=m(i,2)-d;
    else
        n(i,2)=1-m(i,2);
    end
end
%��ȡ�ǵ�����
ding2=zeros(4,2);
A=[cos(n(1,1)) sin(n(1,1));cos(n(2,1)) sin(n(2,1))];
b=[n(1,2);n(2,2)];
y=A\b;
ding2(1,1)=round(y(1,1));
ding2(1,2)=round(y(2,1));
A=[cos(n(1,1)) sin(n(1,1));cos(n(3,1)) sin(n(3,1))];
b=[n(1,2);n(3,2)];
y=A\b;
ding2(2,1)=round(y(1,1));
ding2(2,2)=round(y(2,1));
A=[cos(n(2,1)) sin(n(2,1));cos(n(4,1)) sin(n(4,1))];
b=[n(2,2);n(4,2)];
y=A\b;
ding2(3,1)=round(y(1,1));
ding2(3,2)=round(y(2,1));
A=[cos(n(3,1)) sin(n(3,1));cos(n(4,1)) sin(n(4,1))];
b=[n(3,2);n(4,2)];
y=A\b;
ding2(4,1)=round(y(1,1));
ding2(4,2)=round(y(2,1));
hold on
%�ǵ�
plot(ding2(1,2),ding2(1,1),'o','Color','red');
plot(ding2(2,2),ding2(2,1),'o','Color','red');
plot(ding2(3,2),ding2(3,1),'o','Color','red');
plot(ding2(4,2),ding2(4,1),'o','Color','red');
%}


%%

%{
%��˫���Է���ϵ��
A=[10 10 10*10 1 0 0 0 0;
   0 0 0 0 10 10 10*10 1;
   10 360 10*360 1 0 0 0 0;
   0 0 0 0 10 360 10*360 1;
   360 10 360*10 1 0 0 0 0;
   0 0 0 0 360 10 360*10 1;
   360 360 360*360 1 0 0 0 0;
   0 0 0 0 360 360 360*360 1;
  ];
b=[ding2(1,1);ding2(1,2);ding2(2,1);ding2(2,2);
   ding2(3,1);ding2(3,2);ding2(4,1);ding2(4,2)];
C=A\b;
%˫���Բ�ֵ
M2=uint8(zeros(height,width));
for x=5:height-5
    for y=5:width-5
        xx=C(1,1)*x+C(2,1)*y+C(3,1)*x*y+C(4,1);
        yy=C(5,1)*x+C(6,1)*y+C(7,1)*x*y+C(8,1);
       if(xx/double(uint16(xx))==1.0)&&(yy/double(uint16(yy))==1.0)
            M2(x,y)=B(int16(xx),int16(yy));
        else
            a=double(uint16(xx));
            b=double(uint16(yy));
            x11=double(B(a,b));
            x12=double(B(a,b+1));
            x21=double(B(a+1,b));
            x22=double(B(a+1,b+1));
           M2(x,y)=uint8((b+1-yy)*((xx-a)*x21+(a+1-xx)*x11)+(yy-b)*((xx-a)*x22+(a+1-xx)*x12));
        end
    end
end

figure;
imshow(M2);
%}