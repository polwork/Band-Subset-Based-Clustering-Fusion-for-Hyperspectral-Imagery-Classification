function jieguo=quzao(jieguo)
[r,c]=size(jieguo);
for i=2:r-1
    for j=2:c-1
        dangqian=jieguo((i-1):(i+1),(j-1):(j+1));
        dangqian1=dangqian(:);
        l=length(find(dangqian1==dangqian1(5)));
        [a,b]=hist(dangqian1,min(dangqian1):max(dangqian1));
        num=find(a==max(a));
        if l<=4
            jieguo(i,j)=b(num(1,1));
        end
    end
end