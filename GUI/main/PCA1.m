function Y=PCA1(X,T)
%此函数为PCA特征提取算法
%X为P行N列高光谱图像矩阵，P为维数，N为单幅图像像素数,T为定的值（T<1）

%Y=[];
[dim,num_data]=size(X);
mean_X=mean(X')';       %得到一个X各行均值的一个列向量
%X1=X-mean_X*ones(1,num_data);  %X中的每一个元素减去其所在行的均值 
L=mean_X*ones(1,num_data);
X1=X-L;
S=X1*X1';              %得到PCA所需的协方差阵
[V,D]=eig(S);    %求取S的特征值
eigval=diag(D);   %特征值


%计算T阈值条件下所需波段数m
[i,j]=size(eigval);
tzhe=0;
tzhe1=0;
for ii=1:i
    tzhe=tzhe+eigval(ii);
end

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

for ii=1:i
    tzhe1=tzhe1+eigval1(ii);
    if (tzhe1/tzhe)>=T
        m=ii;
        break;
    end
end

% 从转换的Y矩阵中挑选所需的m行
% V=V';
% Y1=V*X;       %Y1为转换后的全矩阵
V1=[];
for ii=1:m
    for iii=1:i
        if eigval1(ii)==eigval(iii)
            V1=[V1 V(:,iii)];
        end
        %break;
    end
end  
V1=V1';
Y=V1*X;



