function [] = clusterer()
%CLUSTERER Summary of this function goes here
%   Detailed explanation goes here
clc;
fid = fopen('irisNEW.txt');
if fid==-1
    error('File not found');
end
AllFlowers=fscanf(fid, '%f;%f;%f;%f;%f',[5,150])';
G1=AllFlowers(1:40,1:4);
G2=AllFlowers(51:90,1:4);
G3=AllFlowers(101:140,1:4);
G2=[G2;AllFlowers(101:140,1:4)];
B=AllFlowers(41:50,1:4);
B=[B;AllFlowers(91:100,1:4)];
B=[B;AllFlowers(141:150,1:4)];


[G1a,G2c] = discrFunc(G1,G2,B);
[G2a,G3a] = discrFunc(G2,G3,G2c);

disp 
end

