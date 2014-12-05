function rst = encode(mmychars,mmode,mQrcodeVersion)
mychars = mmychars;
QrcodeVersion = str2double(mQrcodeVersion);
mode = mmode;   %�ַ���ת��ģʽ
datastr = '';

w = length(mychars);

%ģʽһ
if mode == '0001'
    %�ж��ַ�����ָʾ�����ȵ��ж����
    if QrcodeVersion < 10
        c2 = 10;
    elseif QrcodeVersion < 27
        c2 = 12;
    elseif QrcodeVersion <41
        c2 = 14;
    end
    
    %�ַ�����ָʾ��ֵ
    str_length = num2str(dec2bin(w,c2));

    ww = mod(w,3);
    for i = 1 : 3 : w
        chars = '';
        
        if ((w-i) >= 2)
            hh = 2;
        else
            hh = w - i; %@@@@@�˴����ÿ��ܴ������⣬��ʱ��Ӱ��ʹ�ã���ʱ����ϸ�Ƶ�һ��
        end
        
        for j = 0 : hh
            chars = strcat(chars,mychars(i+j));
        end
        
        %�ж��Ƿ���3λ��������λ��˵�����˽�β����3Ϊ��ʱ�򣬷ֱ��жϲ�ȫ�ַ�����rֵ
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
%ģʽ��
elseif mode == '0010'
    %�ж��ַ�ͳ��ָʾ��
    if QrcodeVersion < 10
        c2 = 9;
    elseif QrcodeVersion < 27
        c2 = 11;
    elseif QrcodeVersion <41
        c2 = 13;
    end
    %�ַ�ͳ��ָʾ������
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
        
        %�ж��Ƿ���2λ��������λ��˵�����˽�β����2Ϊ��ʱ�򣬷ֱ��жϲ�ȫ�ַ�����rֵ
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
%ģʽ��
elseif mode == '0100'
    
    %�ж��ַ�ͳ��ָʾ��
    if QrcodeVersion < 10
        c2 = 8;
    elseif QrcodeVersion < 27
        c2 = 16;
    elseif QrcodeVersion <41
        c2 = 16;
    end
    %�ַ�ͳ��ָʾ������
    str_length = num2str(dec2bin(w,c2));
    
    for i = 1 : w
        
        datastr = strcat(datastr,trans2(mychars(i)));
    end
    
end
%���շ���������ģʽ�ı�����
%ͨ����ģʽ�ڴ˻����Ͻ����޸�
ends = '0000';
mode
str_length
datastr
rst = [mode,str_length,datastr,ends];


%��Ҫ���Բ��֣�������һЩ���Բ��֣����Ա������ȷ��

end