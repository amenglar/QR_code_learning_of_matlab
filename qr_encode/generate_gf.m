function alpha_to=generate_gf(m,n)
%parameter m is the size of Galois field's size.The n is the size you need.
alpha_to=zeros(1,2^m);
mask=1;
alpha_to(m+1)=0;
Pp=primpoly(m);
for i=1:m
  alpha_to(i)=mask;
    if (Pp(i)~=0)
       alpha_to(m+1)=bitxor(alpha_to(m+1),mask);
    end;
      mask=mask*2;
end;


mask=alpha_to(m);


for i=m+2:n
     if (alpha_to(i-1)>=mask)
        alpha_to(i)=bitxor(alpha_to(m+1),bitxor(alpha_to(i-1),mask)*2);
     else
        alpha_to(i)=alpha_to(i-1)*2;
     end;
end;


alpha_to(2^m)=0;    %把元素0放在最后一位。
