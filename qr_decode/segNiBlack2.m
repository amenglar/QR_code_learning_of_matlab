function g=segNiBlack(f,w2,k)

% segmentation method using Niblack thresholding method

% input: w2 is the half width of the window
w = 2*w2 + 1;
window = ones(w, w);
sp = conv2(f, window, 'same');
n = w^2; 
m = sp / n;
if k ~= 0
    sp2 = conv2(f.^2, window, 'same');
    var = (n*sp2 - sp.^2) / n / (n-1);
    s = sqrt(var); 
    t = m + k * s;
else
    t = m;
end
g=f>t;
end