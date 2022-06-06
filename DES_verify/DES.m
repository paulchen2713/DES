%
% DES main program
%
% clear all;
clc;
%
% input message and key
%
plaintext = '0123456789abcdef';
key = '133457799bbcdff1';
%
% Key Schedule
%
K = KS(key);
%
% Encryption
%
ciphertext = DES_E(plaintext, K);
%
% Decryption
%
R_plaintext = DES_D(ciphertext, K);
%
% print data
%
fprintf('\n Original plaintext is: %s\n', plaintext);
fprintf('\n Encryption key is: %s \n', key);
fprintf('\n Encrypted ciphertext is: %s \n', ciphertext);
fprintf('\n Rcovered plaintext is %s \n', R_plaintext);
