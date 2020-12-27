function [R,L]= ciphertext_round1(pltxt,key)
% kiem tra chuoi dau vao co du 16 bit khong
if(length(pltxt)~=16) 
   disp('please enter a correct plaintext')
end
a=hexToBinaryVector(pltxt,64); %chuyen ban r� dang chuoi 16 bit hexa sang dang nhi phan 
%initial permutation
inip=[58 50 42 34 26 18 10 2 60 52 44 36 28 20 12 4 62 54 46 38 30 22 14 6 64 56 48 40 32 24 26 8 57 49 41 33 25 17 09 01 59 51 43 35 27 19 11 3 61 53 45 37 29 21 13 5 63 55 47 39 31 23 15 7];
b=zeros(1,64);
for i=1:64
    b(i)=a(inip(i));
end
%round 1
Bl=b(1:32);
Br=b(33:64);
%expansion P-box Ar
enpb=[32 1 2 3 4 5 4 5 6 7 8 9 8 9 10 11 12 13 12 13 14 15 16 17 16 17 18 19 20 21 20 21 22 23 24 25 24 25 26 27 28 29 28 29 30 31 32 1];
e=zeros(1,48);
for i=1:48
    u(i)=Br(enpb(i));
end
%XOR
k1=hexToBinaryVector(key,48);
for i=1:48
    c(i)=xor(u(i),k1(i));
end
%S-box 1
i=c(1)*2+c(6)+1;
j=c(2)*8+c(3)*4+c(4)*2+c(5)+1;
Sbox1=[14 4 13 1 2 15 11 8 3 10 6 12 5 9 0 7;
    0 15 7 4 14 2 13 10 3 6 12 11 9 5 3 8;
    4 1 14 8 13 6 2 11 15 12 9 7 3 10 5 0;
    15 12 8 2 4 9 1 7 5 11 3 14 10 0 6 13];
cc1=dec2bin(Sbox1(i,j),4);
%S-box 2
k=c(7)*2+c(12)+1;
n=c(8)*8+c(9)*4+c(10)*2+c(11)+1;
Sbox2=[15 1 8 14  6 11 3 4 9 7 2 13 12 0 5 10;
    3 13 4 7 15 2 8 14 12 0 1 10 6 9 11 5;
    0 14 7 11 10 4 13 1 5 8 12 6 9 3 2 15;
    13 8 10 1 3 15 4 2 11 6 7 12 0 5 14 9];
cc2=dec2bin(Sbox2(k,n),4);
%S-box 3
m=c(13)*2+c(18)+1;
l=c(14)*8+c(15)*4+c(16)*2+c(17)+1;
Sbox3=[10 0 9 14 6 3 15 5 1 13 12 7 11 4 2 8;
    13 7 0 9 3 4 6 10 2 8 3 14 12 11 15 1;
    13 6 4 9 8 15 3 0 11 1 2 12 5 10 14 7;
    1 10 13 0 6 9 8 7 4 15 14 3 11 5 2 12];
cc3=dec2bin(Sbox3(m,l),4);
%S-box 4
h=c(19)*2+c(24)+1;
f=c(20)*8+c(21)*4+c(22)*2+c(23)+1;
Sbox4=[7 13 14 3 0 6 9 10 1 2 8 5 11 12 4 15;
    13 8 11 5 6 15 0 3 4 7 2 12 1 10 14 9;
    10 6 9 0 12 11 7 13 15 1 3 14 5 2 8 4;
    3 15 0 6 10 1 13 8 9 4 5 11 12 7 2 14];
cc4=dec2bin(Sbox4(h,f),4);
%S-box 5
x=c(25)*2+c(30)+1;
z=c(26)*8+c(27)*4+c(28)*2+c(29)+1;
Sbox5=[2 12 4 1 7 10 11 6 8 5 3 15 13 0 14 9;
    14 11 2 12 4 7 13 1 5 0 15 10 3 9 8 6;
    4 2 1 11 10 13 7 8 15 9 12 5 6 3 0 14;
    11 8 12 7 1 14 2 13 6 15 0 9 10 4 5 3];
cc5=dec2bin(Sbox5(x,z),4);
%S-box 6
g=c(31)*2+c(36)+1;
t=c(32)*8+c(33)*4+c(34)*2+c(35)+1;
Sbox6=[12 1 10 15 9 2 6 8 0 13 3 4 14 7 5 11;
    10 15 4 2 7 12 9 5 6 1 13 14 0 11 3 8;
    9 14 15 5 2 8 12 3 7 0 4 10 1 13 11 6;
    4 3 2 12 9 5 15 10 11 14 1 7 10 0 8 13];
cc6=dec2bin(Sbox6(g,t),4);
%S-box 7
q=c(37)*2+c(42)+1;
p=c(38)*8+c(39)*4+c(40)*2+c(41)+1;
Sbox7=[4 11 2 14 15 0 8 13 3 12 9 7 5 10 6 1;
    13 0 11 7 4 9 1 10 14 3 5 12 2 15 8 6;
    1 4 11 13 12 3 7 14 10 15 6 8 0 5 9 2;
    6 11 13 8 1 4 10 7 9 5 0 15 14 2 3 12];
cc7=dec2bin(Sbox7(q,p),4);
%S-box 8
r=c(43)*2+c(48)+1;
s=c(44)*8+c(45)*4+c(46)*2+c(47)+1;
Sbox8=[13 2 8 4 6 15 11 1 10 9 3 14 5 0 12 7;
    1 15 13 8 10 3 7 4 12 5 6 11 10 14 9 2;
    7 11 4 1 9 12 14 2 0 6 10 10 15 3 5 8;
    2 1 14 7 4 10 8 13 15 12 9 9 3 5 6 11];
cc8=dec2bin(Sbox8(r,s),4);
%Straight permutation
cb=[cc1 cc2 cc3 cc4 cc5 cc6 cc7 cc8];
cb = logical(cb(:)'-'0'); %convert 'char' to logical data
str_b=[16 7 20 21 29 12 28 17 1 15 23 26 5 18 31 10 2 8 24 14 32 27 3 9 19 13 30 6 22 11 4 25];
d=zeros(1,32);
for i=1:32
    d(i)=cb(str_b(i));
end
% f is finished, then xor
for i=1:32
    Dl(i)=xor(Bl(i),d(i));
end
%swapper
L=binaryVectorToHex(Br);
R=binaryVectorToHex(Dl);
