function [xiangguanxing,fenzujieguo,jieguo,zu,total]=demo(pathname,filename1,filename2)


first=filename1;%起始图像位置
buchang=1;%步长
total=205;%读取图像总数
jietu=[1,1,100,100];%截取图像大小
T=0.02;%分组阈值

[XX,dim,Xr,Xc]=imageread(pathname,filename2,first,total,buchang,jietu);%读取整组图像
save va,XX;
clear XX;
[zu,xiangguanxing]=Grouping(T); %对整组图像进行分组
%zu=[36 70 46 8 7 54];

%%%%%%%分别对各组图像进行处理
qz=[];
Gailv=[];
fenzujieguo=zeros(Xr,Xc,length(zu));
for i=1:length(zu)
    num=zu(i);
    [X,dim,r,c]=imageread(pathname,filename2,first,num,buchang,jietu);%读取每组图
    
    oo=quanzhi(X);%求取该组图像的结果的权值
    qz=[qz,oo];
    
    [gailv,fenzujieguoi]=Segmentdemo(X,r,c);%求取该组图像的各像素对应于各类的概率
    fenzujieguo(:,:,i)=fenzujieguoi;
    if size(gailv,1)<size(Gailv,1)&i>1%统一类的数目
        gailv=[gailv;zeros(size(Gailv,1)-size(gailv,1),size(gailv,2))];
    elseif size(gailv,1)>size(Gailv,1)&i>1
        Gailv=[Gailv;zeros(size(gailv,1)-size(Gailv,1),size(Gailv,2),size(Gailv,3))];
    end
    Gailv(:,:,i)=gailv;
    
    first=first+num*buchang;
end
qz=qz/sum(qz)

%%%%%%融合分类结果
result=zeros(size(Gailv,1),size(Gailv,2));
for i=1:size(Gailv,2)
    for j=1:size(Gailv,1)
        xiangsu=Gailv(j,i,:);%提取单个像素的概率值
        xiangsu=xiangsu(:)';
        jifen1=[];
        for ii=1:length(xiangsu)
            xs=xiangsu(ii);ys=qz(ii);
            for jj=1:length(xiangsu)
                if xiangsu(jj)>xiangsu(ii)&jj~=ii
                    ys=ys+qz(jj);
                end               
            end
            jifen1=[jifen1,min(xs,ys)];
        end
        jifen=max(jifen1);
        result(j,i)=jifen(1,1);
    end
end


%%%%%%%%显示分割结果
[a,b]=max(result);
b=reshape(b,Xr,Xc);
%ba=quzao(b);
jieguo=mat2gray(b);
%figure,imshow(jieguo),  colormap('default')


