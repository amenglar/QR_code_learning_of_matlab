function a = trans1(cchar)
%��ĸ����ģʽ�ķ��ű����ASCII���ת��
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