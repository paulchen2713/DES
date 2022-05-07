%
% DES Decryption function
%
function R_plaintext = DES_D(ciphertext, K)
%
% step: Initial Permutation(IP)
%
% round 0
[L0, R0] = IP(ciphertext);
L(1, :) = L0;
R(1, :) = R0;
%
% step: 16 rounds
%
for ir = 1 : 16
    [Li, Ri] = Round(L(ir, :), R(ir, :), K(17 - ir, :));
    L(ir + 1, :) = Li;
    R(ir + 1, :) = Ri;
end
%
% step: L <-> R (L and R Swap)
%
L16 = R(17, :);
R16 = L(17, :);
%
% step: Inverse Initial Permutation(IIP)
%
R_plaintext = IIP(L16, R16);

return
