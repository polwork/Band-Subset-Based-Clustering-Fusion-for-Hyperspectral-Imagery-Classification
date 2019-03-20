function [B,dim,r,c]=imageread(pathname,filename2,i,N,n,jietu)
%此函数读入一个文件夹中的若干幅图像，各幅图像以行的形式存入矩阵B中
%i为第一幅图像文件名，N为图像总数，n为文件名递增数目

B=[];
for j=1:N
    Path=[ pathname,int2str(i),filename2];
    Aa=imread(Path);
    A=imcrop(Aa,jietu);
    B=[B;A(:)'];
    i=i+n;
end 
dim=N;
[r,c]=size(A);
B=double(B);
    