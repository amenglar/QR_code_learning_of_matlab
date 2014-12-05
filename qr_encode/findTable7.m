function rst = findTable7(code_number, mode)
%查询不同版本的二维码不同数据类型的数据容量表
ccode_number = code_number;
mmode = mode;
switch mmode
    case '0001'
        mmode = 3;
    case '0010'
        mmode = 4;
    case '0100'
        mmode = 5;
    case '1000'
        mmode = 6;
    otherwise
        mmode = 6;
end
table7 = [
    1 1 41 25 17 10;
    1 2 34 20 14 8;
    1 3 27 16 11 7;
    1 4 17 10 7 4;
    2 1 77 47 32 20;
    2 2 63 38 26 16;
    2 3 48 29 20 12;
    2 4 34 20 14 8;
    3 1 127 77 53 32;
    3 2 101 61 42 26;
    3 3 77 47 32 20;
    3 4 58 35 24 15;
    4 1 187 114 78 48;
    4 2 149 90 62 38;
    4 3 111 67 46 28;
    4 4 82 50 34 21;
    5 1 255 154 106 65;
    5 2 202 122 84 52;
    5 3 144 87 60 37;
    5 4 106 64 44 27;
    ];
[width,~] = size(table7); 
rst = '1';
for i = 1 : width
    if((table7(i,2) == 2)&&(code_number>=table7(i,mmode)))
        rst = num2str(table7(i,1)+1);
    end
end