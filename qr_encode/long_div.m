function mdata = long_div(ndata,ngenerater,mgf8,mngf8)
%长除法求多项式余式

data = ndata;
generater = ngenerater;
gf8 = mgf8;
ngf8 = mngf8;
num = length(data) - length(generater) +1;

%for k = 1 : table9(3)
    mdata = data;
    %分块
    %{
    for i = 1 :  : org_bitsize
        chars = '';
        
        if ((org_bitsize-i) > 7)
            hh = 7;
        else
            hh = org_bitsize - i; %@@@@@此处设置可能存在问题，暂时不影响使用，有时间详细推导一下
        end
        
        for j = 0 : hh
            chars = strcat(chars,org_data(i+j));
        end
    
        %判断是否是8位，不是8位，说明到了结尾不足8位的时候，分别判断补全字符长度r值
        [~,w2] = size(chars);
        if w2 == 8
            r = 0;
        else
            r = 8 - w2;
        end
        chars = strcat(chars,dec2bin(0,r));
        data(n) = bin2dec(chars);
        n = n + 1;
        %datastr = strcat(datastr,num2str(dec2bin(chars,r)));
    end
    %}
    for i = 1 : num
        mgener = generater;
        for j = 1 : length(mgener)
            mgener(j) = gf8( mod(ngf8(mgener(j)+1) + ngf8(mdata(i)+1),255) +1);
        
        %mdata(i+j-1) = bitxor(uint8(mgener(j)), uint8(mdata(i+j-1)));
        end
        %测试代码，查看最后一次的模二加，曾查出纠错码生成多项式缺一位数据的错误
        %{
        if(i == num)
            for j = 1 : length(mgener)
                %aa = uint8(mgener(j)) 
                %bb = uint8( mdata(i+j-1)) 
                cc = bitxor(uint8(mgener(j)), uint8(mdata(i+j-1)))
            end 
        end
        %}
        for j = 1 : length(mgener)
            %mgener(j) = gf8( mod(ngf8(mgener(j)+1) + ngf8(mdata(i)+1),255) +1);
            mdata(i+j-1) = bitxor(uint8(mgener(j)), uint8(mdata(i+j-1)));
        end
    end
%end

end