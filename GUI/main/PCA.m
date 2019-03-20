function Y=PCA(X,T)
%此函数为PCA波段选择算法
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

%从特征值向量中挑选出所需的m个波段的图像
V=V';
tzxlhe=ones(dim,1);
i=1;
for ii=1:dim:dim*dim
    tzxlhe(i)=0;
    for iii=ii:(ii+dim-1)
        tzxlhe(i)=tzxlhe(i)+V(iii);
    end
    i=i+1;
end

tzxlhe1=tzxlhe;
for ii=dim:-1:2
    for iii=1:(ii-1)
        if tzxlhe1(iii)<tzxlhe1(iii+1)
            t=tzxlhe1(iii);
            tzxlhe1(iii)=tzxlhe1(iii+1);
            tzxlhe1(iii+1)=t;
        end
    end
end  

Y=[];    
for i=1:m
    for ii=1:dim
        if tzxlhe1(i)==tzxlhe(ii)
            Y=[Y;X(ii,:)];
        end
        %break;
    end
end    
