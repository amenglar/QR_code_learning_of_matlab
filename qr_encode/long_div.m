function mdata = long_div(ndata,ngenerater,mgf8,mngf8)
%�����������ʽ��ʽ

data = ndata;
generater = ngenerater;
gf8 = mgf8;
ngf8 = mngf8;
num = length(data) - length(generater) +1;

%for k = 1 : table9(3)
    mdata = data;
    %�ֿ�
    %{
    for i = 1 :  : org_bitsize
        chars = '';
        
        if ((org_bitsize-i) > 7)
            hh = 7;
        else
            hh = org_bitsize - i; %@@@@@�˴����ÿ��ܴ������⣬��ʱ��Ӱ��ʹ�ã���ʱ����ϸ�Ƶ�һ��
        end
        
        for j = 0 : hh
            chars = strcat(chars,org_data(i+j));
        end
    
        %�ж��Ƿ���8λ������8λ��˵�����˽�β����8λ��ʱ�򣬷ֱ��жϲ�ȫ�ַ�����rֵ
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
        %���Դ��룬�鿴���һ�ε�ģ���ӣ���������������ɶ���ʽȱһλ���ݵĴ���
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