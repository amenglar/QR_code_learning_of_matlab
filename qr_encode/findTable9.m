function rst = findTable9(QrcodeVersion,QrcodeErrorCorrection)
%table9:¿é½á¹¹±í
mQrcodeVersion = str2double(QrcodeVersion);
mQrcodeErrorCorrection = QrcodeErrorCorrection;
switch (mQrcodeErrorCorrection)
    case  'L'
        nQrcodeErrorCorrection = 1;
    case  'M'
        nQrcodeErrorCorrection = 2;
    case  'Q'
        nQrcodeErrorCorrection = 3;
    case  'H'
        nQrcodeErrorCorrection = 4;
    otherwise
        nQrcodeErrorCorrection = 2;   
end
%version level block_kind block1_size total1 data1 block2_size total2 data2
table9 = [
    1 1 1 1 26 19 0 0 0;
    1 2 1 1 26 16 0 0 0;
    1 3 1 1 26 13 0 0 0;
    1 4 1 1 26 9 0 0 0;
    2 1 1 1 44 34 0 0 0;
    2 2 1 1 44 28 0 0 0;
    2 3 1 1 44 22 0 0 0;
    2 4 1 1 44 16 0 0 0;
    3 1 1 1 70 55 0 0 0;
    3 2 1 1 70 44 0 0 0;
    3 3 2 2 35 17 0 0 0;
    3 4 2 2 35 13 0 0 0;
    4 1 1 1 100 80 0 0 0;
    4 2 2 2 50 32 0 0 0;
    4 3 2 2 50 24 0 0 0;
    4 4 4 4 25 9 0 0 0;
    5 1 1 1 134 108 0 0 0;
    5 2 2 2 67 43 0 0 0;
    5 3 4 2 33 15 2 34 16;
    5 4 4 2 33 11 2 34 12;
    ];
rst(1) = table9((mQrcodeVersion-1)*4+nQrcodeErrorCorrection,3);
rst(2) = table9((mQrcodeVersion-1)*4+nQrcodeErrorCorrection,4);
rst(3) = table9((mQrcodeVersion-1)*4+nQrcodeErrorCorrection,5);
rst(4) = table9((mQrcodeVersion-1)*4+nQrcodeErrorCorrection,6);
rst(5) = table9((mQrcodeVersion-1)*4+nQrcodeErrorCorrection,7);
rst(6) = table9((mQrcodeVersion-1)*4+nQrcodeErrorCorrection,8);
rst(7) = table9((mQrcodeVersion-1)*4+nQrcodeErrorCorrection,9);
end