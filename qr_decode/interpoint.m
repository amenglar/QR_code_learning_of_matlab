function rtn = interpoint(point_x,point_y)
%function rtn = interpoint(mline_x,mline_y)

X = (point_x(1)+point_y(1))/2;
Y = (point_x(2)+point_y(2))/2;


rtn = floor([X,Y]);


%代码备份部分
%{
line_x = mline_x;
line_y = mline_y;

X1 = [ (line_x(2,2)+line_x(2,4))/2,(line_x(2,1)+line_x(2,3))/2   ];
Y1 = [ (line_x(end,2)+line_x(end,4))/2,(line_x(end,1)+line_x(end,3))/2];

X2 = [ (line_y(2,2)+line_y(2,4))/2,(line_y(2,1)+line_y(2,3))/2 ];
Y2 = [ (line_y(end,2)+line_x(end,4))/2,(line_y(end,1)+line_y(end,3))/2];
if X1(1)==Y1(1)
    4
    X=X1(1);
    k2=(Y2(2)-X2(2))/(Y2(1)-X2(1));
    b2=X2(2)-k2*X2(1); 
    Y=k2*X+b2;
end
if X2(1)==Y2(1)
    3
    X=X2(1);
    k1=(Y1(2)-X1(2))/(Y1(1)-X1(1));
    b1=X1(2)-k1*X1(1);
    Y=k1*X+b1;
end
if X1(1)~=Y1(1)&X2(1)~=Y2(1)
    2
    k1=(Y1(2)-X1(2))/(Y1(1)-X1(1));
    k2=(Y2(2)-X2(2))/(Y2(1)-X2(1));
    b1=X1(2)-k1*X1(1);
    b2=X2(2)-k2*X2(1);
    if k1==k2
       X=[];
       Y=[];
    else
        
    X=(b2-b1)/(k1-k2)
    Y=k1*X+b1
    end   
end
%}
end
