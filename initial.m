function [R,L]= initial(pltxt)
% kiem tra chuoi dau vao co du 16 bit khong
if(length(pltxt)~=16) 
   disp('please enter a correct plaintext')
end
a=hexToBinaryVector(pltxt,64); %chuyen ban rõ dang chuoi 16 bit hexa sang dang nhi phan 
%initial permutation
inip=[58 50 42 34 26 18 10 2 60 52 44 36 28 20 12 4 62 54 46 38 30 22 14 6 64 56 48 40 32 24 26 8 57 49 41 33 25 17 09 01 59 51 43 35 27 19 11 3 61 53 45 37 29 21 13 5 63 55 47 39 31 23 15 7];
b=zeros(1,64);
for i=1:64
    b(i)=a(inip(i));
end
%round 1
R=b(1:32);
L=b(33:64);