function  mark(a,color)
%����������󣬸�������㣬��ǡ�x����
%���룺�������
mycolor = color;
[H,W] = size(a);
for i = 1 : H
    for j = 1 : 2 : W
        text(a(i,j),a(i,j+1),'��','Color',mycolor);
    end
end
end