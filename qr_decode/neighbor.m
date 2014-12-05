function rtn = neighbor(a,b)
A = [(a(1)+a(3))/2,(a(2)+a(4))/2];
B = [(b(1)+b(3))/2,(b(2)+b(4))/2];
the_length = abs(a(1)-a(3)) + abs(a(2)+a(4));
my_length = sqrt((A(1)-B(1))*(A(1)-B(1))+(A(2)-B(2))*(A(2)-B(2)));


if my_length >= 0.05*the_length
    rtn = 0;
else
    rtn = 1;
end