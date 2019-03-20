%对高光谱图像分组
function [zu,S2]=Grouping(T)
load va,XX;
X=XX;
clear XX;
 [dim,num_data]=size(X);
mean_X=mean(X,2);       %得到一个X各行均值的一个列向量
%X1=X-mean(X')'*ones(1,num_data);  %X中的每一个元素减去其所在行的均值 
% L=mean(X')'*ones(1,num_data);
% X1=X-L;
% S=X1*X1';
for i=1:dim
    for j=1:num_data
        X(i,j)=X(i,j)-mean_X(i);   
    end
end
S=X*X';
% S=(X-mean(X')'*ones(1,num_data))*(X-mean(X')'*ones(1,num_data))';
[sr,sc]=size(S)
for i=1:sr
    for j=1:sc
        S1(i,j)=S(i,j)/sqrt(S(j,j)*S(i,i));
    end
end
S1=mat2gray(S1);
S2=S1;
% figure,imshow(S1);

zu=[];
for k=1:1000
    [Sr,Sc]=size(S1);
    for i=2:Sc
        sum1=0;sum2=0;
        for j=1:i
            sum1=sum1+S1(i,j);
        end
        sum1=sum1/i;
        for j=1:i+1
            sum2=sum2+S1(i+1,j);
        end
        sum2=sum2/(i+1);
        if abs(sum2-sum1)>T&i>3
            break;
        elseif i==Sr-1
            i=i+1;
            break;
        else
        end
    end
    zu=[zu,i];
    S1=S1(i+1:Sr,i+1:Sc);
    [Sr,Sc]=size(S1);
    if Sc<=2|Sr<=2
        t=size(zu);
        zu(t(1))=zu(t(1))+Sc;
        break;
    end
end




    
    
    