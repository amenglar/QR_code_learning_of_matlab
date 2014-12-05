function rst = trans2(cchar)
a = cchar;
rst = char(dec2bin(a,8));

%以下是测试代码
%if (a > 64 && a < 91)
%    a = dec2bin(a,8);
%elseif (a > 48 && a < 59)
%    a = dec2bin(a,8);
%elseif (a > 96 && a < 123)
%    a = dec2bin(a,8);

%    case ''
%        a = ‘’;
%    
   
end