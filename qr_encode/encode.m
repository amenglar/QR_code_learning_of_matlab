function rst = encode(mmychars,mmode,mQrcodeVersion)
mychars = mmychars;
QrcodeVersion = str2double(mQrcodeVersion);
mode = mmode;   %字符串转换模式
datastr = '';

w = length(mychars);

%模式一
if mode == '0001'
    %判断字符计数指示符长度的判断语句
    if QrcodeVersion < 10
        c2 = 10;
    elseif QrcodeVersion < 27
        c2 = 12;
    elseif QrcodeVersion <41
        c2 = 14;
    end
    
    %字符计数指示符值
    str_length = num2str(dec2bin(w,c2));

    ww = mod(w,3);
    for i = 1 : 3 : w
        chars = '';
        
        if ((w-i) >= 2)
            hh = 2;
        else
            hh = w - i; %@@@@@此处设置可能存在问题，暂时不影响使用，有时间详细推导一下
        end
        
        for j = 0 : hh
            chars = strcat(chars,mychars(i+j));
        end
        
        %判断是否是3位，不是三位，说明到了结尾不足3为的时候，分别判断补全字符长度r值
        [~,w2] = size(chars);
        if w2 == 3
            r = 10;
        elseif w2 == 2
            r = 7;
        elseif w2 == 1
            r = 4;
        elseif w2 == 0
            r = 0;
        end
        %r = 10;
        chars = str2double(chars);
        datastr = strcat(datastr,num2str(dec2bin(chars,r)));
    end
%模式二
elseif mode == '0010'
    %判断字符统计指示符
    if QrcodeVersion < 10
        c2 = 9;
    elseif QrcodeVersion < 27
        c2 = 11;
    elseif QrcodeVersion <41
        c2 = 13;
    end
    %字符统计指示符长度
    str_length = num2str(dec2bin(w,c2));
    
    for i = 1 : 2 : w
        chars = '';
        
        if ((w-i) >= 1)
            hh = 1;
        else
            hh = 0;
        end
        
        for j = 0 : hh
            chars = strcat(chars,mychars(i+j));
        end
        
        %判断是否是2位，不是三位，说明到了结尾不足2为的时候，分别判断补全字符长度r值
        [~,w2] = size(chars);
        if w2 == 2
            r = 11;
            
            chars = trans1(chars(1)) * 45 + trans1(chars(2));
        else
            r = 6;
            chars = trans1(chars);
        end
        
        
        datastr = strcat(datastr,dec2bin(chars,r));
    end
    length(datastr)
%模式三
elseif mode == '0100'
    
    %判断字符统计指示符
    if QrcodeVersion < 10
        c2 = 8;
    elseif QrcodeVersion < 27
        c2 = 16;
    elseif QrcodeVersion <41
        c2 = 16;
    end
    %字符统计指示符长度
    str_length = num2str(dec2bin(w,c2));
    
    for i = 1 : w
        
        datastr = strcat(datastr,trans2(mychars(i)));
    end
    
end
%最终返还的数字模式的编码结果
%通用码模式在此基础上进行修改
ends = '0000';
mode
str_length
datastr
rst = [mode,str_length,datastr,ends];


%需要测试部分，以下是一些测试部分，测试编码的正确性

end