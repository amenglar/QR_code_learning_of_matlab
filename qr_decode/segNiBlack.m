function g=segNiBlack(f,w2,k)
%NiBlack�෧ֵ��ֵ������
%���룬f��������ͼ��w2�������ڣ�k������ϵ����
%�������ֵ��ͼ��������logical��
w = 2*w2 + 1;

window = ones(w, w);

% compute sum of pixels in WxW window

sp = conv2(f, window, 'same');

% convert to mean

n = w^2;            

m = sp / n;

% compute the std

if k ~= 0

    % compute sum of pixels squared in WxW window

    sp2 = conv2(f.^2, window, 'same');

    % convert to std

    var = (n*sp2 - sp.^2) / n / (n-1);

    s = sqrt(var); 

    % compute Niblack threshold

    t = m + k * s;

else

    t = m;

end

g=f>t;

end