function rtn = get_mid_point(gb2)

[H,W] = size(gb2);
store_lines = [];
hh = 1;
for i = 1 : H
    store_lines = [store_lines ; deal(gb2,i,'x')];
end
%mark(store_lines);
linesA = [0 0 0 0];
linesB = [0 0 0 0];
linesC = [0 0 0 0];
linesD = [0 0 0 0];
linesE = [0 0 0 0];
linesF = [0 0 0 0];
linesG = [0 0 0 0];
linesH = [0 0 0 0];
linesI = [0 0 0 0];
color = 'red';
[h w] = size(store_lines);
linesA(1,:) = store_lines(1,:);
counter = 1;
for i = 2 : h
    if (neighbor(linesA(end,:),store_lines(i,:))==1)
        linesA(end+1,:) = store_lines(i,:);
        
    elseif (neighbor(linesB(end,:),store_lines(i,:))==1)
        linesB(end+1,:) = store_lines(i,:);
        
    elseif (neighbor(linesC(end,:),store_lines(i,:))==1)
        linesC(end+1,:) = store_lines(i,:);
        
    elseif (neighbor(linesD(end,:),store_lines(i,:))==1)
        linesD(end+1,:) = store_lines(i,:);
        
    elseif (neighbor(linesE(end,:),store_lines(i,:))==1)
        linesE(end+1,:) = store_lines(i,:);
        
    elseif (neighbor(linesF(end,:),store_lines(i,:))==1)
        linesF(end+1,:) = store_lines(i,:);
        
    elseif (neighbor(linesG(end,:),store_lines(i,:))==1)
        linesG(end+1,:) = store_lines(i,:);
        
    elseif (neighbor(linesH(end,:),store_lines(i,:))==1)
        linesH(end+1,:) = store_lines(i,:);
        
    elseif (neighbor(linesI(end,:),store_lines(i,:))==1)
        linesI(end+1,:) = store_lines(i,:);
        
    else
        counter = counter + 1;
        if (counter == 2)
            linesB(end+1,:) = store_lines(i,:);
            
        elseif (counter == 3)
            linesC(end+1,:) = store_lines(i,:);
            
        elseif (counter == 4)
            linesD(end+1,:) = store_lines(i,:);
            
        elseif (counter == 5)
            linesE(end+1,:) = store_lines(i,:);
            
        elseif (counter == 6)
            linesF(end+1,:) = store_lines(i,:);
            
        elseif (counter == 7)
            linesG(end+1,:) = store_lines(i,:);
            
        elseif (counter == 8)
            linesH(end+1,:) = store_lines(i,:);
            
        elseif (counter == 9)
            linesI(end+1,:) = store_lines(i,:);
            
        end
    end
end

[A,~] = size(linesA);
[B,~] = size(linesB);
[C,~] = size(linesC);
[D,~] = size(linesD);
[E,~] = size(linesE);
[F,~] = size(linesF);
[G,~] = size(linesG);
[H,~] = size(linesH);
[I,~] = size(linesI);
[sizes,index] = sort([A,B,C,D,E,F,G,H,I],'descend');


%取出前三的矩阵
switch index(1)
    case 1
        line_x_1 = linesA;
    case 2
        line_x_1 = linesB;
    case 3
        line_x_1 = linesC;
    case 4
        line_x_1 = linesD;
    case 5
        line_x_1 = linesE;
    case 6
        line_x_1 = linesF;
    case 7
        line_x_1 = linesG;
    case 8
        line_x_1 = linesH;
    case 9
        line_x_1 = linesI;
    otherwise
end
switch index(2)
    case 1
        line_x_2 = linesA;
    case 2
        line_x_2 = linesB;
    case 3
        line_x_2 = linesC;
    case 4
        line_x_2 = linesD;
    case 5
        line_x_2 = linesE;
    case 6
        line_x_2 = linesF;
    case 7
        line_x_2 = linesG;
    case 8
        line_x_2 = linesH;
    case 9
        line_x_2 = linesI;
    otherwise
end
switch index(3)
    case 1
        line_x_3 = linesA;
    case 2
        line_x_3 = linesB;
    case 3
        line_x_3 = linesC;
    case 4
        line_x_3 = linesD;
    case 5
        line_x_3 = linesE;
    case 6
        line_x_3 = linesF;
    case 7
        line_x_3 = linesG;
    case 8
        line_x_3 = linesH;
    case 9
        line_x_3 = linesI;
    otherwise
end

%mark(line_x_1,'red');
%mark(line_x_2,'yellow');
%mark(line_x_3,'blue');



%%
gb2_y = gb2';
[H,W] = size(gb2_y);
store_lines_y = [];
hh = 1;
for i = 1 : H
    store_lines_y = [store_lines_y ; deal(gb2_y,i,'y')];
end
%mark(store_lines);
line_y_A = [0 0 0 0];
line_y_B = [0 0 0 0];
line_y_C = [0 0 0 0];
line_y_D = [0 0 0 0];
line_y_E = [0 0 0 0];
line_y_F = [0 0 0 0];
line_y_G = [0 0 0 0];
line_y_H = [0 0 0 0];
line_y_I = [0 0 0 0];
color = 'red';
[h w] = size(store_lines_y);
linesA(1,:) = store_lines_y(1,:);
counter = 1;
for i = 2 : h
    if (neighbor(line_y_A(end,:),store_lines_y(i,:))==1)
        line_y_A(end+1,:) = store_lines_y(i,:);
        
    elseif (neighbor(line_y_B(end,:),store_lines_y(i,:))==1)
        line_y_B(end+1,:) = store_lines_y(i,:);
        
    elseif (neighbor(line_y_C(end,:),store_lines_y(i,:))==1)
        line_y_C(end+1,:) = store_lines_y(i,:);
        
    elseif (neighbor(line_y_D(end,:),store_lines_y(i,:))==1)
        line_y_D(end+1,:) = store_lines_y(i,:);
        
    elseif (neighbor(line_y_E(end,:),store_lines_y(i,:))==1)
        line_y_E(end+1,:) = store_lines_y(i,:);
        
    elseif (neighbor(line_y_F(end,:),store_lines_y(i,:))==1)
        line_y_F(end+1,:) = store_lines_y(i,:);
        
    elseif (neighbor(line_y_G(end,:),store_lines_y(i,:))==1)
        line_y_G(end+1,:) = store_lines_y(i,:);
        
    elseif (neighbor(line_y_H(end,:),store_lines_y(i,:))==1)
        line_y_H(end+1,:) = store_lines_y(i,:);
        
    elseif (neighbor(line_y_I(end,:),store_lines_y(i,:))==1)
        line_y_I(end+1,:) = store_lines_y(i,:);
        
    else
        counter = counter + 1;
        if (counter == 2)
            line_y_B(end+1,:) = store_lines_y(i,:);
            
        elseif (counter == 3)
            line_y_C(end+1,:) = store_lines_y(i,:);
            
        elseif (counter == 4)
            line_y_D(end+1,:) = store_lines_y(i,:);
            
        elseif (counter == 5)
            line_y_E(end+1,:) = store_lines_y(i,:);
            
        elseif (counter == 6)
            line_y_F(end+1,:) = store_lines_y(i,:);
            
        elseif (counter == 7)
            line_y_G(end+1,:) = store_lines_y(i,:);
            
        elseif (counter == 8)
            line_y_H(end+1,:) = store_lines_y(i,:);
            
        elseif (counter == 9)
            line_y_I(end+1,:) = store_lines_y(i,:);
            
        end
    end
end

[A,~] = size(line_y_A);
[B,~] = size(line_y_B);
[C,~] = size(line_y_C);
[D,~] = size(line_y_D);
[E,~] = size(line_y_E);
[F,~] = size(line_y_F);
[G,~] = size(line_y_G);
[H,~] = size(line_y_H);
[I,~] = size(line_y_I);
[sizes,index] = sort([A,B,C,D,E,F,G,H,I],'descend');


%取出前三的矩阵
switch index(1)
    case 1
        line_y_1 = line_y_A;
    case 2
        line_y_1 = line_y_B;
    case 3
        line_y_1 = line_y_C;
    case 4
        line_y_1 = line_y_D;
    case 5
        line_y_1 = line_y_E;
    case 6
        line_y_1 = line_y_F;
    case 7
        line_y_1 = line_y_G;
    case 8
        line_y_1 = line_y_H;
    case 9
        line_y_1 = line_y_I;
    otherwise
end
switch index(2)
    case 1
        line_y_2 = line_y_A;
    case 2
        line_y_2 = line_y_B;
    case 3
        line_y_2 = line_y_C;
    case 4
        line_y_2 = line_y_D;
    case 5
        line_y_2 = line_y_E;
    case 6
        line_y_2 = line_y_F;
    case 7
        line_y_2 = line_y_G;
    case 8
        line_y_2 = line_y_H;
    case 9
        line_y_2 = line_y_I;
    otherwise
end
switch index(3)
    case 1
        line_y_3 = line_y_A;
    case 2
        line_y_3 = line_y_B;
    case 3
        line_y_3 = line_y_C;
    case 4
        line_y_3 = line_y_D;
    case 5
        line_y_3 = line_y_E;
    case 6
        line_y_3 = line_y_F;
    case 7
        line_y_3 = line_y_G;
    case 8
        line_y_3 = line_y_H;
    case 9
        line_y_3 = line_y_I;
    otherwise
end

hold on;
%mark(line_y_1,'red');
%mark(line_y_2,'yellow');
%mark(line_y_3,'blue');

%%
%求y中心点
mid_x_1 = round([ ((line_x_1(2,1) + line_x_1(2,3))/2 + (line_x_1(end,1) + line_x_1(end,3))/2)/2 ...
    , ((line_x_1(2,2) + line_x_1(2,4))/2 + (line_x_1(end,2) + line_x_1(end,4))/2)/2 ]);
mid_x_2 = round([ ((line_x_2(2,1) + line_x_2(2,3))/2 + (line_x_2(end,1) + line_x_2(end,3))/2)/2 ...
    , ((line_x_2(2,2) + line_x_2(2,4))/2 + (line_x_2(end,2) + line_x_2(end,4))/2)/2 ]);

mid_x_3 = round([ ((line_x_3(2,1) + line_x_3(2,3))/2 + (line_x_3(end,1) + line_x_3(end,3))/2)/2 ...
    , ((line_x_3(2,2) + line_x_3(2,4))/2 + (line_x_3(end,2) + line_x_3(end,4))/2)/2 ]);

mid_y_1 = round([ ((line_y_1(2,1) + line_y_1(2,3))/2 + ((line_y_1(end,1) + line_y_1(end,3))/2))/2 ...
    , ((line_y_1(2,2) + line_y_1(2,4))/2 + (line_y_1(end,2) + line_y_1(end,4))/2)/2 ]);
mid_y_2 = round([ ((line_y_2(2,1) + line_y_2(2,3))/2 + ((line_y_2(end,1) + line_y_2(end,3))/2))/2 ...
    , ((line_y_2(2,2) + line_y_2(2,4))/2 + (line_y_2(end,2) + line_y_2(end,4))/2)/2 ]);
mid_y_3 = round([ ((line_y_3(2,1) + line_y_3(2,3))/2 + ((line_y_3(end,1) + line_y_3(end,3))/2))/2 ...
    , ((line_y_3(2,2) + line_y_3(2,4))/2 + (line_y_3(end,2) + line_y_3(end,4))/2)/2 ]);

%{
mark(mid_x_1,'red')
mark(mid_x_2,'yellow')
mark(mid_x_3,'blue')
mark(mid_y_1,'red')
mark(mid_y_2,'yellow')
mark(mid_y_3,'blue')
%}      
        
        
        
for i = 1 : 3;
    hold on
    if(i == 1)
        the_length = abs(line_x_1(2,1) - line_x_1(2,3));
        
        distance(mid_x_1,mid_y_1)
        
        distance(mid_x_1,mid_y_2)
        
        distance(mid_x_1,mid_y_3)
       
        if (distance(mid_x_1,mid_y_1)<(0.1*the_length))
            point1 = interpoint(mid_x_1,mid_y_1);
            mark(point1,'green')
            
        elseif(distance(mid_x_1,mid_y_2)<(0.1*the_length))
            point1 = interpoint(mid_x_1,mid_y_2);
            mark(point1,'green')
            
        elseif(distance(mid_x_1,mid_y_3)<(0.1*the_length))
            point1 = interpoint(mid_x_1,mid_y_3);
            mark(point1,'green')
            
       
        end
    elseif(i == 2)
        %mark(mid_x_2,'blue')
        %mark(mid_y_1,'red')
        the_length = abs(line_x_2(2,1) - line_x_2(2,3));
        if (distance(mid_x_2,mid_y_1)<(0.1*the_length))
            
            point2 = interpoint(mid_x_2,mid_y_1);
            mark(point2,'green')
        elseif(distance(mid_x_2,mid_y_2)<(0.1*the_length))
            point2 = interpoint(mid_x_2,mid_y_2);
            mark(point2,'green')
        elseif(distance(mid_x_2,mid_y_3)<(0.1*the_length))
            point2 = interpoint(mid_x_2,mid_y_3);
            mark(point2,'green')
        
        end
    elseif(i == 3)
        %mark(mid_x_3,'red')
        %mark(mid_y_3,'blue')
        the_length = abs(line_x_3(2,1) - line_x_3(2,3));
        if (distance(mid_x_3,mid_y_1)<(0.2*the_length))
            point3 = interpoint(mid_x_3,mid_y_1);
            mark(point3,'green')
        elseif(distance(mid_x_3,mid_y_2)<(0.2*the_length))
            point3 = interpoint(mid_x_3,mid_y_2);
            mark(point3,'green')
        elseif(distance(mid_x_3,mid_y_3)<(0.2*the_length))
            point3 = interpoint(mid_x_3,mid_y_3);
            mark(point3,'green')
    
        end
    end
    
    
end

minlength = round((abs(line_x_1(2,1) - line_x_1(2,3))+abs(line_x_2(2,1) ...
    - line_x_2(2,3))+abs(line_x_3(2,1) - line_x_3(2,3))+abs(line_y_1(2,2)-...
    line_y_1(2,4))+abs(line_y_2(2,2)-line_y_2(2,4))+abs(line_y_3(2,2)-line_y_3(2,4)))/(6*7))

points_lengths = [distance(point1,point2), distance(point2,point3), distance(point1,point3)]

[sort_point_lengths,new_index] = sort(points_lengths,'descend')

level = ((points_lengths(new_index(2)))+(points_lengths(new_index(3))))/(2*minlength)

rtn = [point1;point2;point3;[minlength,round(level)]];


end