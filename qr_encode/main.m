clc; clear; clear all;

%mychars = 'AC-42451ABC//YUN'
%mychars = '1568995331312156899533131215689953313121568995331312156899533122'
%mychars = '123321456'
%mychars = 'WWW.BAIDU.COM'
mychars = 'www.qust.edu.cn'
%mychars = 'http://www.baidu.com'
%mychars = 'This is the voa special English'
code_length = length(mychars)
%%

%0001��ʾ����ģʽ��0010��ʾ������ĸģʽ,0100��ʾ8bitsģʽ��
mode = getmode(mychars);
%%
%����ȷ��QrcodeVersion

QrcodeErrorCorrection = 'M';
QrcodeVersion = findTable7(code_length,mode);


%%%%%%%%%%%
%bit�����ݱ�����Բ���
rst_bit = encode(mychars,mode,QrcodeVersion);
%%%%%%%%%%%

%������벿��
%��Ҫ�ж������ַ�������ѡ����ʵľ����С,��ʱ��������Ҫʹ��Ԥ����ķ�ʽָ���ߴ�;�����

totalbits = ecc(rst_bit,QrcodeVersion,QrcodeErrorCorrection);
%����������ģͼ�μ��㲿�֣���ʱ�ϲ�һ���ļ�
bbb = module(totalbits,QrcodeErrorCorrection,QrcodeVersion);
totalbits_size = length(totalbits);