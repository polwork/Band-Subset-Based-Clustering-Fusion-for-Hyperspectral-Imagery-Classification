function o=quanzhi(X)

[dim,num_data]=size(X);
mean_X=mean(X')';       %得到一个X各行均值的一个列向量
%X1=X-mean_X*ones(1,num_data);  %X中的每一个元素减去其所在行的均值 
L=mean_X*ones(1,num_data);
X1=X-L;
S=X1*X1';              %得到PCA所需的协方差阵
[V,D]=eig(S);    %求取S的特征值
eigval=diag(D);

%对特征值排序
eigval1=eigval;
for ii=i:-1:2
    for iii=1:(ii-1)
        if eigval1(iii)<eigval1(iii+1)
            t=eigval1(iii);
            eigval1(iii)=eigval1(iii+1);
            eigval1(iii+1)=t;
        end
    end
end 
eigval1=mat2gray(eigval1);

for ii=1:length(eigval1)
    y=eigval1(ii+1)-eigval1(ii);
    if y>0.01
        m=ii;
        break;
    end
end

sum1=0;
for ii=1:m
    sum1=sum1+eigval1(ii);
end
sum2=0;
for ii=m+1:length(eigval1)
    sum2=sum2+eigval1(ii);
end

o=sum2/(sum1+sum2);


