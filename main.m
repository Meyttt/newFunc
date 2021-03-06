function [Xmean1,Xmean2] = main()
clc;
fid = fopen('irisNEW.txt');
if fid==-1
    error('File not found');
end
AllFlowers=fscanf(fid, '%f;%f;%f;%f;%f',[5,150])';
G1=AllFlowers(1:40,1:4);
G2=AllFlowers(51:90,1:4);
G3=AllFlowers(101:140,1:4);
B=AllFlowers(41:50,1:4);
B=[B;AllFlowers(141:150,1:4)];
B=[B;AllFlowers(91:100,1:4)];


n=100;
p=4;
q=2;


[k1,m1]=size(G1);
Xmean1=[];
for i=1:m1
    G=mean(G1(:,i));
    Xmean1=[Xmean1;G];
end
[k2,m2]=size(G2);
Xmean2=[];
for i=1:m2
    G=mean(G2(:,i));
    Xmean2=[Xmean2;G];
end
[k3,m3]=size(G3);
Xmean3=[];
for i=1:m3
    G=mean(G3(:,i));
    Xmean3=[Xmean3;G];
end

S1=[];
for j=1:m1
    for l=1:m1
        sum=0;
        for i1=1:k1
            sum=sum+(1/4)*(G1(i1,j)-Xmean1(j))*(G1(i1,l)-Xmean1(l));
        end
        S1(j,l)=sum;
    end
end
S2=[];
for j=1:m2
    for l=1:m2
        sum=0;
        for i1=1:k2
            sum=sum+(1/4)*(G2(i1,j)-Xmean2(j))*(G2(i1,l)-Xmean2(l));
        end
        S2(j,l)=sum;
    end
end
S3=[];
for j=1:m3
    for l=1:m3
        sum=0;
        for i1=1:k3
            sum=sum+(1/4)*(G3(i1,j)-Xmean3(j))*(G3(i1,l)-Xmean3(l));
        end
        S3(j,l)=sum;
    end
end

So=(1/(k1+k2+k3-3))*(k1*S1+k2*S2+k3*S3);
Soinv = inv(So);
A=Soinv*(Xmean1-Xmean2-Xmean3);


F1=[];
for i=1:k1
    t=0;
    for j=1:m1
        t=t+A(j)*G1(i,j)
    end
    F1=[F1;t];
end
F1m=mean(F1);
F2=[];
for i=1:k2
    t=0;
    for j=1:m2
        t=t+A(j)*G2(i,j)
    end
    F2=[F2;t];
end
F2m=mean(F2);
F3=[];
for i=1:k3
    t=0;
    for j=1:m3
        t=t+A(j)*G3(i,j)
    end
    F3=[F3;t];
end
F3m=mean(F3);
F=(F1m+F2m+F3m)/3;
[Fs,I] = sort([F1m,F2m,F3m]);
FullFs=[F1,F2,F3];
disp(size(I));
disp(size(Fs));
F1=FullFs(I(1,1));
F2=FullFs(I(1,2));
F3=FullFs(I(1,3))
F12m= (F1m+F2m)/2;
F23m= (F2m+F3m)/2;
[k0,m0]=size(B);
F0=[];
for i=1:k0
    X=B(i,:);
    sum0=0;
    for j=1:m0
        sum0=sum0+A(j)*X(1,j);
    end
    if sum0>F12m
         F0=[F0;i,1];
    else if sum0>F23m
             F0=[F0;i,2];
        else
            F0=[F0;i,3];
        end
    end
    
end
disp(F0);
end

