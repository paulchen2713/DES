%
% Initial Permutation(IP) function
%
function [L, R] = IP(plaintext)
IP = [58 50	42 34 26 18	10  2 ...
      60 52	44 36 28 20	12	4 ...
      62 54	46 38 30 22	14	6 ...
      64 56	48 40 32 24	16	8 ...
      57 49	41 33 25 17	9 	1 ...
      59 51	43 35 27 19	11	3 ...
      61 53	45 37 29 21	13	5 ...
      63 55	47 39 31 23	15	7];
L = plaintext(1:8); % L in hex char
R = plaintext(9:16);
Lb = uint32(hex2dec(L)); % Lb in 32 bits digit
Rb = uint32(hex2dec(R));
Lb_temp = Lb;
Rb_temp = Rb;
for i = 1 : 32
    if IP(i) <= 32
        Lb = bitset(Lb, 33 - i, bitget(Lb_temp, 33 - IP(i)));
    else
        Lb = bitset(Lb, 33 - i, bitget(Rb_temp, 65 - IP(i)));
    end
    if IP(i + 32) <= 32
        Rb = bitset(Rb, 33 - i, bitget(Lb_temp, 33 - IP(i + 32)));
    else
        Rb = bitset(Rb, 33 - i, bitget(Rb_temp, 65 - IP(i + 32)));
    end
end
L = dec2hex(Lb, 8);
R = dec2hex(Rb, 8);

return
