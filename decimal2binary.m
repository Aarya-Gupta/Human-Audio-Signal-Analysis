function [str] = decimal2binary(num)% I created this code from my coding skills
% Decimal to Binary convertor to get encoding bits
string = "";
while num > 0
    remainder = rem(num, 2);
    num = fix(num / 2);
    string = remainder + string;
end
str = string;
end
