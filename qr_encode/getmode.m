function mode = getmode(chars)
mychars = chars;
code_length = length(mychars);
%ģʽʶ�𣬽��м򵥵�ģʽʶ�𣬽���ģʽ�ݲ�����
string_bin = dec2bin(mychars);   %�������ַ���
string_dec = bin2dec(string_bin);    %ת��Ϊʮ���ƾ�����ʽ
string_dec = string_dec'
b1 = '0'; b2 = '0'; b3 = '0'; b4 = '0';
for i = 1 : code_length
    if(string_dec(i)>=48 && string_dec(i)<=57)
        %���ֱ�־λ
        b1 = '1';
    elseif((string_dec(i)>=65 && string_dec(i)<=90)||string_dec(i)==36||...
        string_dec(i)==37||string_dec(i)==42||string_dec(i)==43||string_dec...
        (i)==45||string_dec(i)==46||string_dec(i)==47||string_dec(i)==58)
        %��д��ĸ�������ַ���־λ
        b2 = '1';
    elseif(string_dec(i)>=97 && string_dec(i)<=122)
        %Сд��ĸ��־λ
        b3 = '1';
    else
        %�����ַ���־λ
        b4 = '1';
    end
end
mark_bit = [b1 b2 b3 b4];
if (strcmp(mark_bit, '1000'))
    mode = '0001';
elseif(strcmp(mark_bit, '1100') || strcmp(mark_bit, '0100'))
    mode = '0010';
else
    mode = '0100';
end

end