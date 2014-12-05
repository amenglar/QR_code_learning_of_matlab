clc; clear; clear all;
table9 = findTable9('5','Q')

block_sizes = 0;
for i = 1 : table9(2)
    block_sizes(end+1) = table9(3);
end
for i = 1 : table9(5)
    block_sizes(end+1) = table9(6);
end
block_sizes