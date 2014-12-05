function  mark(a,color)
%给出坐标矩阵，根据坐标点，标记“x”！
%输入：坐标矩阵。
mycolor = color;
[H,W] = size(a);
for i = 1 : H
    for j = 1 : 2 : W
        text(a(i,j),a(i,j+1),'。','Color',mycolor);
    end
end
end