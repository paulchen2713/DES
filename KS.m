%
% Key Schedule function for DES
%
function out = KS(key)
    %
    % permutation choice one
    %
    PC1L = [57	49	41	33	25	17	9 ...
            1	58	50	42	34	26	18 ...
            10	2	59	51	43	35	27 ...
            19	11	3	60	52	44	36];
    PC1R = [63	55	47	39	31	23	15 ...
            7	62	54	46	38	30	22 ... 
            14	6	61	53	45	37	29 ...
            21	13	5	28	20	12	4];
    %
    % shift number
    %
    Shift = [1 1 2 2 2 2 2 2 1 2 2 2 2 2 2 1];
    %
    % permutation choice two
    %
    PC2 = [14   17	11	24	1	5	3	28 ...
           15	6	21	10	23	19	12	4 ...
           26	8	16	7	27	20	13	2 ...
           41	52	31	37	47	55	30	40 ...
           51	45	33	48	44	49	39	56 ...
           34	53	46	42	50	36	29	32];
    %
    % key from input key string
    %
    K_L = key(1:8);
    K_R = key(9:16);
    K_Lb = uint32(hex2dec(K_L));
    K_Rb = uint32(hex2dec(K_R));
    %
    % key schedule
    %
    C = uint32(0);
    D = uint32(0);
    for i = 1 : 28
        if PC1L(i) <= 32
            C = bitset(C, 33-i, bitget(K_Lb, 33-PC1L(i)));
        else
            C = bitset(C, 33-i, bitget(K_Rb, 65-PC1L(i)));        
        end
        if PC1R(i) <= 32
            D = bitset(D, 33-i, bitget(K_Lb, 33-PC1R(i)));
        else
            D = bitset(D, 33-i, bitget(K_Rb, 65-PC1R(i)));        
        end
    end
    %
    K = uint64(zeros(16, 1));
    for ir = 1 : 16
        if Shift(ir) == 1
            C = bitset(C, 4, bitget(C, 32));
            C = bitshift(C, 1);
            D = bitset(D, 4, bitget(D, 32));
            D = bitshift(D, 1);
        else
            C = bitset(C, 4, bitget(C, 32));
            C = bitshift(C, 1);
            D = bitset(D, 4, bitget(D, 32));
            D = bitshift(D, 1);
            C = bitset(C, 4, bitget(C, 32));
            C = bitshift(C, 1);
            D = bitset(D, 4, bitget(D, 32));
            D = bitshift(D, 1);
        end
        for i = 1 : 48
            if PC2(i) <= 28
                K(ir) = bitset(K(ir), 49-i, bitget(C, 33-PC2(i)));
            else
                K(ir) = bitset(K(ir), 49-i, bitget(D, 61-PC2(i)));
            end
        end
    end
    out = dec2hex(double(K), 16);
return

