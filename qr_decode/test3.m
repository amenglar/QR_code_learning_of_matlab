f=imread('test3.jpg');%�����ɫͼ��,ע�ⲻ��ʹ�ûҶ�ͼ�� 
o=f; %������ɫԭͼ 
f=rgb2gray(f);%����ɫͼ��ת��Ϊ�Ҷ�ͼ��, 
f=im2double(f);
figure(); subplot(2,2,1);imshow(o);title('ԭͼ');
[m,n]=size(f);%�õ�ͼ��������� m,���� n 
for i=3:m-2
    for j=3:n-2%��������ϴ�,���Դ�ͼ��(3,3)��ʼ,��(m-2,n-2)���� 
        l(i,j)=-f(i-2,j)-f(i-1,j-1)-2*f(i-1,j)-f(i-1,j+1)-f(i,j-2)-2*f(i,j-1)+16*f(i,j)-2*f(i,j+1)-f(i,j+2)-f(i+1,j-1)-2*f(i+1,j)-f(i+1,j+1)-f(i+2,j);%LoG ����
    end
end
subplot(2,2,2);imshow(l);title('LoG ������ȡͼ���Ե');
[m,n]=size(l);
for i=2:m-1
    for j=2:n-1 y(i,j)=l(i-1,j-1)+l(i-1,j)+l(i-1,j+1)+l(i,j-1)+l(i,j)+l(i,j+1)+l(i+1,j-1)+l(i+1,j)+l(i+1,j+1);
        y(i,j)=y(i,j)/9; %LoG ������ȡ��Ե��,�Խ�����о�ֵ�˲���ȥ������,Ϊ��һ�� hough �任��ȡֱ����׼�� 
        subplot(2,2,3);imshow(y);title('��ֵ�˲��������')
        q=im2uint8(y);
        [m,n]=size(q);
        for i=1:m
            for j=1:n
                if q(i,j)>80; %���ö�ֵ������ֵΪ 80
                    q(i,j)=255; %��ͼ����ж�ֵ������,ʹͼ���Ե����ͻ������ 
                else
                    q(i,j)=0;
                end
            end
        end
        subplot(2,2,4);imshow(q);title('��ֵ�������');
    end
end%Hough �任���ֱ��,ʹ��(a,p)�����ռ�,a��[0,180],p��[0,2d] a=180; %�Ƕȵ�ֵΪ 0 �� 180 ��
d=round(sqrt(m^2+n^2)); %ͼ��Խ��߳���Ϊ p �����ֵ s=zeros(a,2*d); %�洢ÿ��(a,p)����
z=cell(a,2*d); %��Ԫ���洢ÿ�������ĵ������ 
for i=1:m
    for j=1:n%����ͼ��ÿ���� 
        if(q(i,j)==255)%ֻ���ͼ���Ե�İ׵�,����㲻���
            for k=1:a
                p = round(i*cos(pi*k/180)+j*sin(pi*k/180));%��ÿ�����1 �� 180 �ȱ���һ��,ȡ�þ����õ������ֱ�ߵ� p ֵ(ȡ��) 
                if(p > 0)%�� p ���� 0,�򽫵�洢��(d,2d)�ռ�
                    s(k,d+p)=s(k,d+p)+1;%(a,p)��Ӧ���ۼ�����Ԫ��һ
                    z{k,d+p}=[z{k,d+p},[i,j]'];%�洢������ 
                else
                    ap=abs(p)+1;%�� p С�� 0,�򽫵�洢��(0,d)�ռ�
                    s(k,ap)=s(k,ap)+1;%(a,p)��Ӧ���ۼ�����Ԫ��һ 
                    z{k,ap}=[z{k,ap},[i,j]'];%�洢������
                end
            end
        end
    end
end
for i=1:a
    for j=1:d*2
        if(s(i,j) >70) %����ȡֱ�ߵ���ֵ��Ϊ 70
            lp=z{i,j};%��ȡ��Ӧ������
            for k=1:s(i,j)%��������ֵ�������ۼ�����Ԫ��(a,p)��Ӧ�����е���в���
                o(lp(1,k),lp(2,k),1)=255; %ÿ���� R ����=255,G ����=0,
                B ����=0
                o(lp(1,k),lp(2,k),2)=0;
                o(lp(1,k),lp(2,k),3)=0; %���Ϊ��ԭͼ�϶�������ֵҪ��
            end
        end
    end
end
%���ÿ���ۼ�����Ԫ�д洢����
figure,imshow(o);title('hough �任��ȡֱ��');