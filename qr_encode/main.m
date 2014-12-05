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

%0001表示数字模式，0010表示数字字母模式,0100表示8bits模式？
mode = getmode(mychars);
%%
%这里确定QrcodeVersion

QrcodeErrorCorrection = 'M';
QrcodeVersion = findTable7(code_length,mode);


%%%%%%%%%%%
%bit流数据编码调试部分
rst_bit = encode(mychars,mode,QrcodeVersion);
%%%%%%%%%%%

%纠错编码部分
%需要判断码流字符长度来选择合适的矩阵大小,暂时，我们需要使用预定义的方式指定尺寸和纠错级别

totalbits = ecc(rst_bit,QrcodeVersion,QrcodeErrorCorrection);
%数据填充和掩模图形计算部分，暂时合并一个文件
bbb = module(totalbits,QrcodeErrorCorrection,QrcodeVersion);
totalbits_size = length(totalbits);