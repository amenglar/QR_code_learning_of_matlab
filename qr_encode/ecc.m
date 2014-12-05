%clc; clear; clear all;
function totalbits = ecc(ddata,QrcodeVersion,QrcodeErrorCorrection)
%ԭʼ�汾
%
%����������
%data 00010000 00100000 00001100 01010110 01100001 10000000
%Pad code 11101100 00010001
%data2 32 91 11 120 209 114 220 77 67 64 236 17 236
%table:total codewords, data codewords
mQrcodeVersion = QrcodeVersion;
mQrcodeErrorCorrection = QrcodeErrorCorrection;

%table9���ݲ�ѯ������table9����������Ŀ�ṹ
table9 = findTable9(mQrcodeVersion,mQrcodeErrorCorrection)

%table9 = [26, 16];

org_data = ddata
org_bitsize = length(org_data)
%%
%�˷��ֽ�
n = 1;
for i = 1 : 8 : org_bitsize
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
org_dec_data = data
org_dec_num = length(data);
%%
%����������չ���Է������ױ�׼
org_size = length(data);
extend1 = floor((table9(4) - org_size)/2);
extend2 = table9(3) - table9(4);
extend3 = mod(table9(4) - org_size,2);
pad1 = bin2dec('11101100');
pad2 = bin2dec('00010001');
for i = 1 : extend1
    data(end+1) = pad1;
    data(end+1) = pad2;
end
if (extend3 == 1)
    data(end + 1) = pad1;
end

for i = 1 : extend2
    data(end+1) = 0;
end
data
%data = [bin2dec('00010000'), bin2dec('00100000'), bin2dec('00001100'), ...
%    bin2dec('01010110'), bin2dec('01100001'), bin2dec('10000000'), ...
%    pad1, pad2 ,pad1, pad2, pad1, pad2, pad1, pad2, pad1, pad2, 0, 0, 0,...
%    0, 0, 0, 0, 0, 0, 0];
%����ֵ+1���ܲ�ѯ٤�޻���ֵ
gf8 = generate_gf(8,256);
%gf8�򷴲�ѯ������٤�޻���ֵ��ѯ����ֵ
for i = 1 : 256
    ngf8(gf8(i)+1) = i-1;
end




%%
%�鳤�ȱ�
block_sizes = 0;
block_gx = 0;
for i = 1 : table9(2)
    block_sizes(end+1) = table9(3);
    block_gx(end+1) = table9(3) - table9(4);
end
for i = 1 : table9(5)
    block_sizes(end+1) = table9(6);
    block_gx(end+1) = table9(6) - table9(7);
end

block_num = length(block_sizes)-1;

%�ֿ�ʹ�ó�����������
for i = 1 : block_num
    
    %gf8 = circshift(gf8,[0,1]);
    %�������table9�����ݺ�findTableA��ȷ��G(x)��
    g = findTableA(block_gx(i+1));
    %g = [0 ,251, 67, 46, 61, 118, 70, 64, 94, 32, 45];
    g_length = length(g);
    for j = 1 : g_length
        generater(j) = gf8(g(j)+1);
        %���ǵ�gf8�����ǰ���������Ҫ+1��0Ԫ��ֵ��ע��
    end
    mdata = long_div(data,generater,gf8,ngf8)
end

%%
%total_codewords�������ֶ��ʱ����Ҫע��
mdata
totalbits = '';
 
for i = 1 : length(data)
    total_codewords(i) = data(i) + mdata(i);
    totalbits = [totalbits, dec2bin(total_codewords(i),8)];
end

%{
for i = 1 : table9(4)
    total_codewords(i) = data(i);
end
for i = table9(4)+1 : table9(3)
    total_codewords(i) = mdata(i);
end
for i = 1 : length(data)
    totalbits = [totalbits, dec2bin(total_codewords(i),8)];
end
%}
total_codewords
totalbits
%









%�°汾
%{

%����������
%data 00010000 00100000 00001100 01010110 01100001 10000000
%Pad code 11101100 00010001
%data2 32 91 11 120 209 114 220 77 67 64 236 17 236
%table:total codewords, data codewords
mQrcodeVersion = QrcodeVersion;
mQrcodeErrorCorrection = QrcodeErrorCorrection;

%table9���ݲ�ѯ������table9����������Ŀ�ṹ
table9 = findTable9(mQrcodeVersion,mQrcodeErrorCorrection)
%table9 = [26, 16];

org_data = ddata
org_bitsize = length(org_data)
%%
%�˷��ֽ�
n = 1;
for i = 1 : 8 : org_bitsize
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
org_dec_data = data
org_dec_num = length(data);
%%

%data = [bin2dec('00010000'), bin2dec('00100000'), bin2dec('00001100'), ...
%    bin2dec('01010110'), bin2dec('01100001'), bin2dec('10000000'), ...
%    pad1, pad2 ,pad1, pad2, pad1, pad2, pad1, pad2, pad1, pad2, 0, 0, 0,...
%    0, 0, 0, 0, 0, 0, 0];
%����ֵ+1���ܲ�ѯ٤�޻���ֵ
gf8 = generate_gf(8,256);
%gf8�򷴲�ѯ������٤�޻���ֵ��ѯ����ֵ
for i = 1 : 256
    ngf8(gf8(i)+1) = i-1;
end




%%
%�鳤�ȱ�
block_sizes = 0;
block_gx = 0;
block_info_sizes = 0;
for i = 1 : table9(2)
    block_sizes(end+1) = table9(3);
    block_info_sizes(end+1) = table9(4);
    block_gx(end+1) = table9(3) - table9(4);
end
for i = 1 : table9(5)
    block_sizes(end+1) = table9(6);
    block_info_sizes(end+1) = table9(7);
    block_gx(end+1) = table9(6) - table9(7);
end

block_num = length(block_sizes)-1;
block_sizes
%�ֿ�ʹ�ó�����������
for i = 1 : block_num
    
    pointer = 0;
    
    for j = 1 : i
        pointer = block_info_sizes(i)
    end
    
    endlength = length(data) - pointer;
    if (endlength > block_info_sizes(i+1))
        endlength = block_info_sizes(i+1);
    end
    block_data = zeros(1,endlength);
    for k = pointer+1 : pointer+endlength
        block_data(k-pointer) = data(k);
    end
    block_data
    %����������չ���Է������ױ�׼
    org_size = length(block_data);
    if org_size < table9(4)
        extend1 = floor((table9(4) - org_size)/2);
        
        pad1 = bin2dec('11101100');
        pad2 = bin2dec('00010001');
        for l = 1 : extend1
            block_data(end+1) = pad1;
            block_data(end+1) = pad2;
        end
    end
    extend2 = block_gx(i+1);
    extend3 = mod(table9(4) - org_size,2);
    
    if (extend3 == 1)
        block_data(end + 1) = pad1;
    end

    for m = 1 : extend2
        block_data(end+1) = 0;
    end
    block_data
    
    %gf8 = circshift(gf8,[0,1]);
    %�������table9�����ݺ�findTableA��ȷ��G(x)��
    g = findTableA(block_gx(i+1));
    %g = [0 ,251, 67, 46, 61, 118, 70, 64, 94, 32, 45];
    g_length = length(g);
    for j = 1 : g_length
        generater(j) = gf8(g(j)+1);
        %���ǵ�gf8�����ǰ���������Ҫ+1��0Ԫ��ֵ��ע��
    end
    %mdata = long_div(data,generater,gf8,ngf8)
    mdata = long_div(block_data,generater,gf8,ngf8)
end

%%
%total_codewords�������ֶ��ʱ����Ҫע��
mdata
totalbits = '';
 
for i = 1 : length(block_data)
    total_codewords(i) = block_data(i) + mdata(i);
    totalbits = [totalbits, dec2bin(total_codewords(i),8)];
end

%{
for i = 1 : table9(4)
    total_codewords(i) = data(i);
end
for i = table9(4)+1 : table9(3)
    total_codewords(i) = mdata(i);
end
for i = 1 : length(data)
    totalbits = [totalbits, dec2bin(total_codewords(i),8)];
end
%}
total_codewords
totalbits

%}

end