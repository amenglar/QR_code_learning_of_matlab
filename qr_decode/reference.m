clear;
%读取图像
G=imread('test6.jpg');
%G=imread('test4.png');
%二值化图像
B=rgb2gray(G);
%中值滤波
M=medfilt2(B);
% 最大间方差法找到一个合适的阈值(二值化)
thresh=graythresh(M);
% M中大于thresh的像素就设为1（白色），小于thresh的像素就设为0（黑色）
BW=im2bw(M,thresh);
%imshow(BW);
%图像0，1互换
BW2=~BW;
%形态学膨胀
SE=strel('square',15);
I=imdilate(BW2,SE);
%求取整幅图的重心
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
%标记连通域
[L,num]=bwlabel(I,8);
%剔除无关连通域
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
%形态学腐蚀
T=imerode(L,SE);
%提取边缘
T2=bwperim(T);
%Hough变换
E=zeros(height,width);
a=180;                           %角度的值为0到180度
d=round(sqrt(height^2+width^2));%图像对角线长度为p的最大值
s=zeros(a,2*d);                  %存储每个(a,p)个数
z=cell(a,2*d);                   %用元胞存储每个被检测的点的坐标
for i=1:height
    for j=1:width                %遍历图像每个点
        if(T2(i,j)==1)           %只检测图像边缘的白点，其余点不检测
            for k=1:a
                p =round(i*cos(pi*k/180)+j*sin(pi*k/180));
                %对每个点从1到180度遍历一遍，取得经过该点的所有直线的p值（取整）
                if(p > 0)
                    %若p大于0，则将点存储在（d，2d）空间
                    s(k,d+p)=s(k,d+p)+1;%（a，p）相应的累加器单元加一
                    z{k,d+p}=[z{k,d+p},[i,j]'];%存储点坐标
                else
                    ap=abs(p)+1;%若p小于0，则将点存储在（0，d）空间
                    s(k,ap)=s(k,ap)+1;%(a，p)相应的累加器单元加一
                    z{k,ap}=[z{k,ap},[i,j]'];%存储点坐标
                end
            end
        end
    end
end
for i=1:a
    for j=1:d*2 %检查每个累加器单元中存储数量
        if(s(i,j) >50) %将提取直线的阈值设为70
            lp=z{i,j};%提取对应点坐标
            for k=1:s(i,j)
               %对满足阈值条件的累加器单元中(a，p)对应的所有点进行操作
               E(lp(1,k),lp(2,k))=1;
            end
        end
    end
end
%寻找边缘点
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
%近似边缘点
plot(ding(1,2),ding(1,1),'x','Color','red');
plot(ding(2,2),ding(2,1),'x','Color','red');
plot(ding(3,2),ding(3,1),'x','Color','red');
plot(ding(4,2),ding(4,1),'x','Color','red');
%根据四个边缘点求取四条直线
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
%修改ρ θ
for i=1:4
   K(i,1)=K(i,1)/pi*180;
   if K(i,2)>0
       K(i,2)=K(i,2)+d;
   else
       K(i,2)=abs(K(i,2))+1;
   end
end
%对累加器排序
m=zeros(4,2);
[a,index]=sort(s(:),'descend');
i=1;
while(i<5)
    j=1;
    flag=0;
    while(flag==0)
        m(i,2)=fix((index(j,1)-1)/180)+1;          % 获取ρ
        m(i,1)=index(j,1)-(m(i,2)-1)*180;          % 获取θ
        %求取误差范围内且累加值最大的ρθ
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
%提取角点坐标
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
%角点
plot(ding2(1,2),ding2(1,1),'o','Color','red');
plot(ding2(2,2),ding2(2,1),'o','Color','red');
plot(ding2(3,2),ding2(3,1),'o','Color','red');
plot(ding2(4,2),ding2(4,1),'o','Color','red');
%}


%%

%{
%解双线性方程系数
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
%双线性插值
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