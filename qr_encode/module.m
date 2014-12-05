function b = module(totalbits,QrcodeErrorCorrection,QrcodeVersion)

mtotalbits = totalbits;
mQrcodeErrorCorrection = QrcodeErrorCorrection;
mQrcodeVersion = QrcodeVersion;
a = map(QrcodeVersion);

m = 10;
[w,h] = size(a);
%length(mtotalbits)
%填充部分，a是得到的填充方式地图
for i = 1 : w
    for j = 1 : h
        if ((a(i,j) < 10)&&(mod(a(i,j),10) == 0))
            b(i,j) = 0;
            %b(i,j) = uint8(0);
            %b((i-1)*m+1:(i-1)*m+m,(j-1)*m+1:(j-1)*m+m) = uint8(0);
        elseif((a(i,j) < 10)&&(mod(a(i,j),10) == 1))
            b(i,j) = 1;
            %b(i,j) = uint8(255);
            %b((i-1)*m+1:(i-1)*m+m,(j-1)*m+1:(j-1)*m+m) = uint8(255);
        else
            %取出“地图”中的指示符，各位表示码字的位，十位和百位表示码字的号
            lol1 = floor(a(i,j)/10);
            lol2 = mod(a(i,j),10);
            %(lol1-1)*8+(8-lol2)
            %lol3表示的是对应的码流当中的数值
            if (a(i,j)==999)
                lol3 = 0;
            else
                lol3 = str2double(mtotalbits((lol1-1)*8+(8-lol2)));
            end
            if (lol3 == 0)
                %lol3 = 255;
                lol3 = 1;
            else
                lol3 = 0;
            end
            b(i,j) = lol3;
            %b(i,j) = uint8(lol3);
            %b((i-1)*m+1:(i-1)*m+m,(j-1)*m+1:(j-1)*m+m) = uint8(lol3);
        end
        
    end
end
subplot(2,2,1)
imshow(b);

%掩模部分
mask_pic = '010';
mask = mask_pattern(w,mask_pic);
for i = 1 : w
    for  j = 1 : h
        if (a(i,j)>10)
            
            b(i,j) = bitxor(b(i,j), mask(i,j));
            if (b(i,j) == 1)
                b(i,j) = 0;
            else
                b(i,j) = 1;
            end
        end
    end
end

%格式信息部分
info_mask = '101010000010010';
switch mQrcodeErrorCorrection
    case 'M'
        ecc_pointer = '00';
    case 'L'
        ecc_pointer = '01';
    case 'Q'
        ecc_pointer = '11';
    case 'H'
        ecc_pointer = '00';
    otherwise
        ecc_pointer = '10';
end

%bch自制算法，在其它的情境下，可能出现错误，需要注意。
info_org = [ecc_pointer mask_pic '0000000000'];
len_div = length(dec2bin(bin2dec(info_org)));
%得出码字前0的个数
len_div = len_div - 11;
g = ['10100110111',dec2bin(0,len_div)];
g = dec2bin(bin2dec(g),15);

bch = dec2bin(bitxor(uint16(bin2dec(info_org)),uint16(bin2dec(g))),10);
data_add_bch = [ecc_pointer mask_pic bch];
%bch = dec2bin(mod(bin2dec(info_org),bin2dec('10100110110')),15)

info = dec2bin(bitxor( uint16(bin2dec(data_add_bch)), uint16(bin2dec(info_mask)) ),15 );
%进行1-0反转
for i = 1 : length(info)
    if(info(i) == '1')
        info_inqr(i) = 0;
    else
        info_inqr(i) = 1;
    end
end
%info_inqr




%填充格式信息部分

b(1,9) = info_inqr(15);
b(2,9) = info_inqr(14);
b(3,9) = info_inqr(13);
b(4,9) = info_inqr(12);
b(5,9) = info_inqr(11);
b(6,9) = info_inqr(10);
b(8,9) = info_inqr(9);
b(9,9) = info_inqr(8);
b(9,8) = info_inqr(7);
b(9,6) = info_inqr(6);
b(9,5) = info_inqr(5);
b(9,4) = info_inqr(4);
b(9,3) = info_inqr(3);
b(9,2) = info_inqr(2);
b(9,1) = info_inqr(1);

b(9,w) = info_inqr(15);
b(9,w-1) = info_inqr(14);
b(9,w-2) = info_inqr(13);
b(9,w-3) = info_inqr(12);
b(9,w-4) = info_inqr(11);
b(9,w-5) = info_inqr(10);
b(9,w-6) = info_inqr(9);
b(9,w-7) = info_inqr(8);
b(h-6,9) = info_inqr(7);
b(h-5,9) = info_inqr(6);
b(h-4,9) = info_inqr(5);
b(h-3,9) = info_inqr(4);
b(h-2,9) = info_inqr(3);
b(h-1,9) = info_inqr(2);
b(h,9) = info_inqr(1);
b(h-7,9) = 0;

subplot(2,2,2)
imshow(b);
subplot(2,2,3)
imshow(mask);
end
