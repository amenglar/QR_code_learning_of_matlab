f=imread('test3.jpg');%读入彩色图像,注意不能使用灰度图像 
o=f; %保留彩色原图 
f=rgb2gray(f);%将彩色图像转换为灰度图像, 
f=im2double(f);
figure(); subplot(2,2,1);imshow(o);title('原图');
[m,n]=size(f);%得到图像矩阵行数 m,列数 n 
for i=3:m-2
    for j=3:n-2%处理领域较大,所以从图像(3,3)开始,在(m-2,n-2)结束 
        l(i,j)=-f(i-2,j)-f(i-1,j-1)-2*f(i-1,j)-f(i-1,j+1)-f(i,j-2)-2*f(i,j-1)+16*f(i,j)-2*f(i,j+1)-f(i,j+2)-f(i+1,j-1)-2*f(i+1,j)-f(i+1,j+1)-f(i+2,j);%LoG 算子
    end
end
subplot(2,2,2);imshow(l);title('LoG 算子提取图像边缘');
[m,n]=size(l);
for i=2:m-1
    for j=2:n-1 y(i,j)=l(i-1,j-1)+l(i-1,j)+l(i-1,j+1)+l(i,j-1)+l(i,j)+l(i,j+1)+l(i+1,j-1)+l(i+1,j)+l(i+1,j+1);
        y(i,j)=y(i,j)/9; %LoG 算子提取边缘后,对结果进行均值滤波以去除噪声,为下一步 hough 变换提取直线作准备 
        subplot(2,2,3);imshow(y);title('均值滤波器处理后')
        q=im2uint8(y);
        [m,n]=size(q);
        for i=1:m
            for j=1:n
                if q(i,j)>80; %设置二值化的阈值为 80
                    q(i,j)=255; %对图像进行二值化处理,使图像边缘更加突出清晰 
                else
                    q(i,j)=0;
                end
            end
        end
        subplot(2,2,4);imshow(q);title('二值化处理后');
    end
end%Hough 变换检测直线,使用(a,p)参数空间,a∈[0,180],p∈[0,2d] a=180; %角度的值为 0 到 180 度
d=round(sqrt(m^2+n^2)); %图像对角线长度为 p 的最大值 s=zeros(a,2*d); %存储每个(a,p)个数
z=cell(a,2*d); %用元胞存储每个被检测的点的坐标 
for i=1:m
    for j=1:n%遍历图像每个点 
        if(q(i,j)==255)%只检测图像边缘的白点,其余点不检测
            for k=1:a
                p = round(i*cos(pi*k/180)+j*sin(pi*k/180));%对每个点从1 到 180 度遍历一遍,取得经过该点的所有直线的 p 值(取整) 
                if(p > 0)%若 p 大于 0,则将点存储在(d,2d)空间
                    s(k,d+p)=s(k,d+p)+1;%(a,p)相应的累加器单元加一
                    z{k,d+p}=[z{k,d+p},[i,j]'];%存储点坐标 
                else
                    ap=abs(p)+1;%若 p 小于 0,则将点存储在(0,d)空间
                    s(k,ap)=s(k,ap)+1;%(a,p)相应的累加器单元加一 
                    z{k,ap}=[z{k,ap},[i,j]'];%存储点坐标
                end
            end
        end
    end
end
for i=1:a
    for j=1:d*2
        if(s(i,j) >70) %将提取直线的阈值设为 70
            lp=z{i,j};%提取对应点坐标
            for k=1:s(i,j)%对满足阈值条件的累加器单元中(a,p)对应的所有点进行操作
                o(lp(1,k),lp(2,k),1)=255; %每个点 R 分量=255,G 分量=0,
                B 分量=0
                o(lp(1,k),lp(2,k),2)=0;
                o(lp(1,k),lp(2,k),3)=0; %结果为在原图上对满足阈值要求
            end
        end
    end
end
%检查每个累加器单元中存储数量
figure,imshow(o);title('hough 变换提取直线');