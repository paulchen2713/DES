%
% TDEA (Triple Data Encryption Algorithm)
%
clear;
clc;
%
% input message and key
%
% plaintext = '0123456789abcdef';
% plain = '0123456789abcdeffecdab1645237980fecdab16452379800123456789abcdef33';
%
% plain_text = '要做的事情總找得出時間和機會，不要做的事情總找的出藉口。--張愛玲';
text_mode = 'Chinese';
%
word = actxserver('Word.Application');
wdoc = word.Documents.Open('D:\Beginner MATLAB Projects\Post_Quantum_Cryptography_MATLAB\DES_verify\余光中_阿里山讚.docx');
plain_text = wdoc.Content.Text;
Quit(word);
delete(word);
%
% plain_text = 'No man is an island, Entire of itself, Every man is a piece of the continent';
% text_mode = 'English';
%
% Input key has to be 0-9, a-f, or A-F.
%
key1 = '133457799bbcdff1';
key2 = 'aabcdbcdeffe6497';
key3 = '974acfe58d1b32f6';
%
% Key Schedule 
%
K1 = KS(key1);
K2 = KS(key2);
K3 = KS(key3);
%
% check point
%
if strcmp(text_mode, 'English') == 1
    plain_text_len = length(plain_text);
    plain = char();
    for i = 1 : plain_text_len
        % turn the char string into a double, then turn into a 2 bits hexdecimal
        pp = dec2hex(double(plain_text(i)), 2);
        plain = strcat(plain, pp);
    end
elseif strcmp(text_mode, 'Chinese') == 1
    plain_text_len = length(plain_text);
    plain = char();
    for i = 1 : plain_text_len
        % turn the char string into a double, then turn into a 2 bits hexdecimal
        pp = dec2hex(double(plain_text(i)), 4);
        plain = strcat(plain, pp);
    end
end
% 
plain_len = length(plain);
q = floor(plain_len / 16); % integer division
r = mod(plain_len, 16);
if r ~= 0
    q = q + 1;
    % 
    % pending 
    % 
    plain = strcat(plain, '8');
    for i = 1 : 16-r-1
        plain = strcat(plain, '0');
    end
end
%
% Encryption
%
ciphertext = char();
for iq = 1 : q
    P = plain((iq-1)*16 + 1 : iq*16);
    C = DES_E(DES_D(DES_E(P, K1), K2), K3);
    ciphertext = strcat(ciphertext, C);
end
%
% Decryption
%
cipher_len = length(ciphertext);
q = cipher_len / 16;
R_plaintext = char();
for iq = 1 : q
    C = ciphertext((iq-1)*16 + 1 : iq*16);
    P = DES_D(DES_E(DES_D(C, K3), K2), K1);
    R_plaintext = strcat(R_plaintext, P);
end
%
if strcmp(text_mode, 'English') == 1
    R_plaintext_len = length(R_plaintext);
    R_plain_text = zeros(1, R_plaintext_len/2); % to preserve the spaces in the original char string, first 
    for i = 1 : R_plaintext_len/2
        R_plain_text(i) = hex2dec(R_plaintext((i-1)*2 + 1 : i*2));
    end
    R_plain_text = char(R_plain_text);
elseif strcmp(text_mode, 'Chinese') == 1
    R_plaintext_len = length(R_plaintext);
    R_plain_text = zeros(1, R_plaintext_len/4); % to preserve the spaces in the original char string, first 
    for i = 1 : R_plaintext_len/4
        R_plain_text(i) = hex2dec(R_plaintext((i-1)*4 + 1:i*4));
    end
    R_plain_text = char(R_plain_text);
end
%
fid = fopen('R_plaintext.doc', 'wt');
fprintf(fid, '%s', R_plain_text);
fclose(fid);
%
% print data
%
% fprintf('\n Original plaintext is: %s\n', plain);
fprintf('\n Original plaintext is: %s\n', plain_text);
fprintf('\n Encryption key1 is: %s \n', key1);
fprintf('\n Encryption key2 is: %s \n', key2);
fprintf('\n Encryption key3 is: %s \n', key3);
fprintf('\n Encrypted ciphertext is: %s \n', ciphertext);
% fprintf('\n Recovered plaintext is: %s \n', R_plaintext);
fprintf('\n Recovered plaintext is: %s \n', R_plain_text);

