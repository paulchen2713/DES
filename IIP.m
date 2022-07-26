%
% Inverse Initial Permutation(IIP) function
%
function out = IIP(L, R)
    IIP = [40	8	48	16	56	24	64	32 ...
           39	7	47	15	55	23	63	31 ...
           38	6	46	14	54	22	62	30 ...
           37	5	45	13	53	21	61	29 ...
           36	4	44	12	52	20	60	28 ...
           35	3	43	11	51	19	59	27 ...
           34	2	42	10	50	18	58	26 ...
           33	1	41	9	49	17	57	25];
    Lb = uint32(hex2dec(L)); % Lb in 32 bits digit
    Rb = uint32(hex2dec(R));
    Lb_temp = Lb;
    Rb_temp = Rb;
    %
    for i = 1 : 32
        if IIP(i) <= 32
            Lb = bitset(Lb, 33 - i, bitget(Lb_temp, 33 - IIP(i)));
        else
            Lb = bitset(Lb, 33 - i, bitget(Rb_temp, 65 - IIP(i)));
        end
        %
        if IIP(i + 32) <= 32
            Rb = bitset(Rb, 33 - i, bitget(Lb_temp, 33 - IIP(i + 32)));
        else
            Rb = bitset(Rb, 33 - i, bitget(Rb_temp, 65 - IIP(i + 32)));
        end
    end
    L = dec2hex(Lb, 8);
    R = dec2hex(Rb, 8);
    out = strcat(L, R); % str L + str R
return

