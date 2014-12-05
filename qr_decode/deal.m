function rtn = deal(pic,line,deriction)
%扫描线处理函数；
%输入，待处理图像（logical类型），number要扫描的行数；
%坐标矩阵。

%测试命令
%l = imread('test4.png');
%l = rgb2gray(l);
%number = 160;
%figure;
%imshow(l);

[~,line_length] = size(pic);
for i = 1 : line_length
    pic_line(1,i) = pic(line,i);
end

each_color_length(1:40) = 0;
color_length_count = 0;
%u = logical(u);
%figure;
%imshow(u);
color_state = pic_line(1,1);
j = 1;
i = 1;
%统计一条扫描线中，各段颜色线段的长度
while i<=line_length
    
        while (logical(i<=line_length)&&logical(pic_line(i)==(color_state)))
            color_length_count = color_length_count + 1;
            i = i + 1;
        end
        each_color_length(j) = color_length_count;
        j = j + 1;
        color_length_count = 0;
        color_state = ~color_state;
    
end
%mm
five_colorlines(1:5) = 0;

%返回结果定义，纵向6个点，不一定只存在两条目标线段
rtn = [];

for i = 1 : 36
    summ = 0;
    for j = 1 : 5
        five_colorlines(1,j) = each_color_length(1,i+j-1);
        summ = summ + five_colorlines(j);
        
    end
    ssum = 0;
    
    for k = 1 : i-1
        ssum = ssum + each_color_length(k);
    end
    
    ssum = mod(ssum,line_length);
    if( logical(pic_line(ssum+1) == false) && ...
        logical(five_colorlines(1)/five_colorlines(2)>=(1/2)&&five_colorlines(1)/five_colorlines(2)<=(3/2)) && ...
        logical(five_colorlines(2)/five_colorlines(1)>=(1/2)&&five_colorlines(2)/five_colorlines(1)<=(3/2)) && ...
        logical(five_colorlines(3)/five_colorlines(1)>=(5/2)&&five_colorlines(3)/five_colorlines(1)<=(7/2)) && ...
        logical(five_colorlines(4)/five_colorlines(1)>=(1/2)&&five_colorlines(4)/five_colorlines(1)<=(3/2)) && ...
        logical(five_colorlines(5)/five_colorlines(1)>=(1/2)&&five_colorlines(5)/five_colorlines(1)<=(3/2)))
    
    %rtn(end+1,:) = ssum + 1;
    %rtn(bbb,2) = line;
    %rtn(bbb+1,1) = ssum + summ +1;
    %rtn(bbb+1,2) = line;
    %bbb = bbb + 2;
    
    %rtn(end+1,:) = [line,ssum + 1,line,ssum + summ + 1];
    if (deriction == 'x')
        rtn(end+1,:) = [ssum + 1,line,ssum + summ + 1,line];
    elseif (deriction == 'y')
        rtn(end+1,:) = [line,ssum + 1,line,ssum + summ + 1];
    end
    
end
[h w] = size(rtn);
if ((w+h)==3)
    rtn = [];
end
end