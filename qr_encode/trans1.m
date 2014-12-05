function a = trans1(cchar)
%字母数字模式的符号编码和ASCII码的转换
a = cchar;
if (a > 64 && a < 91)
    a = a - 55;
elseif (a > 48 && a < 59)
    a = a - 48;
elseif (a == 32)
    a = 36;
elseif (a == 42)
    a = 39;
elseif (a == 43)
    a = 40;
elseif (a == 45)
    a = 41;
elseif (a == 46)
    a = 42;
elseif (a == 47)
    a = 43;
elseif (a == 58)
    a = 44;
end