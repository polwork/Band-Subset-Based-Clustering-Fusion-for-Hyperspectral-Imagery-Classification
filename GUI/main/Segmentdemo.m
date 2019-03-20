%分割处入口
function [gailv,fenzujieguo]=Segmentdemo(X,r,c)
 %Y=PCA(X,0.995); 
 Y=PCA1(X,0.999);
 [dimm,N]=size(Y)
 
YY=ones(r,c,dimm);
s=1;
for i=1:dimm
    Yi=Y(i,:);
    for j=1:N
        YY(s)=Yi(j);
        s=s+1;
    end
end

Input_image=YY;
Wind=30;
Min_group_size=100;
[U_new, Modes,New_image] = Color_segment_svd_Msp (Input_image, Wind, Min_group_size);
 fenzujieguo=mat2gray(New_image);
 %figure,imshow(New_image),colormap('default')

for i=size(Modes,2):-1:2
    for j=1:(i-1)
        if Modes(1,j)<Modes(1,j+1)
            t=Modes(:,j); Modes(:,j)=Modes(:,j+1); Modes(:,j+1)=t;  
        end
    end
end
Modes

fenmu=60*60+60*60;
gailv=zeros(size(Modes,2),size(U_new,2));
for i=1:size(U_new,2)
    x=U_new(:,i);
    for j=1:size(Modes,2)
         y=Modes(:,j);
         fenzi=abs(x-y);
         fenzi=fenzi'*fenzi;
         gl=1-(fenzi/fenmu);
         if gl<=0
             gl=0;
         end
         gailv(j,i)=gl;
    end
end





