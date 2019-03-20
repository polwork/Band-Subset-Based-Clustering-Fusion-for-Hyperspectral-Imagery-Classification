%此函数为高光谱图像分割
function [U_new, Modes,New_image] = ...
   Color_segment_svd_Msp (Input_image, Wind, Min_group_size)
% Now first tries to find "the most valuable components" of the image by
% using svd decomposition, which gives 3 matrices - U, having the same number
% of rows as the original vector, and 2 matrices - diagonal which indicates
% weights of the columns, and V which is disregarded at the moment.  Then the
% original meanshift algorithm is applied to either first or two first columns
% of U, both done sufficiently quickly and more or less reliably

% Min_group_size : need at least that many pixels to qualify for a color
Rows = size(Input_image, 1);
Cols = size(Input_image, 2);
Height = size(Input_image,3);
Min_image_size = 0.005*Rows*Cols;		                            % to stop when image is small终止条件

Temp_Input_image = shiftdim(Input_image, 2);               %对图像立方体进行转换   %把所有第i列中的元素付值到第i高里面，进而实现转换%
Input_vect = reshape(Temp_Input_image, [Height, Rows*Cols]); %将图像立方体拉直     %保持Temp行数不变，把高里面的所有第i行合并成一行%
%以上两行实际是无用功，只是将YY矩阵又变回到Y的形式，即input_vect为dim*N，即height*(rows*cols)的矩阵 


[U, S, V] = svd(double(Input_vect'), 0);                           
%对转换后的图像的转置进行奇异值分解,u(N*N),s(P*P),v(P*P)


% now segmenting based on the first and second columns of U only 
%仅仅基于第一、第二个特征向量构造特征
U_col = U(:, 1:2);
%对第二个特征向量进行缩放
U_col(:, 2) = U_col(:, 2)*S(2, 2)/S(1, 1);		% scaling it
Max = max(max(U_col));
Min = min(min(U_col));
Max_axis = 255;
%对第一、第二个特征向量
U_new = round((U_col-Min*ones(size(U_col)))/(Max-Min)*Max_axis)';%将U_new(2*N)的值变换为0-255；
%%%%%显示特征分解图
% U=U_new(1,:);
% U=reshape(U,512,614);
% U=mat2gray(U);
% figure,imshow(U)

% creating a new matrix - color based
%创建一个Max_axis+1行Max_axis+1列的稀疏新矩阵Cumulative
Cumulative = sparse(Max_axis+1, Max_axis+1);
for i=1:size(U_new, 2)
	Cumulative(U_new(1, i)+1, U_new(2, i)+1) = Cumulative(U_new(1, i)+1, U_new(2, i)+1) + 1;  
%统计灰度值的数目 cumulative(i,j)表示U_new的第1行中的灰度值为i-1和第二行中的灰度值为j-1的个数和
%因此cumulative(i,j)的值的总合为N
end

% for background detection only
%进行背景检测
Cumulative(1, 1) = 0;

%wk%显示灰度对应的概率密度
 Cumulative1=zeros(256,256);
 size(Cumulative1);
for o=1:256
    for oo=1:256
        if Cumulative(o,oo)==0
           Cumulative1(o,oo)=0;
        else   
           Cumulative1(o,oo)=round(log2(Cumulative(o,oo)));
        end
    end
end
%  figure
%  mesh(Cumulative1)

%模态选择
k = 0; 
L = Max_axis+1;  
Max_iterats = 1000;

while sum(sum(Cumulative)) > Min_image_size
   Non_zero_pos = find(Cumulative > 0);
   %Non_zero_pos为列向量，其值为Cumulative(:)>0的位置号
   if length(Non_zero_pos) == 0
      break;
   end
   
   [Init(1), Init(2)] = ind2sub(size(Cumulative), Non_zero_pos(1));
   %此句还原cumulative矩阵中第一个非0元素的位置的坐标
   
   [Mode, Number_values] = M_shift2(Cumulative, Wind, Init, Min_group_size/5);
   Mode = full(round(Mode));
   if Number_values > Min_group_size	% good group
		k = k+1;
      Modes(:, k) = Mode';
		Cumulative( max(1, Mode(1)-Wind):min(L, Mode(1)+Wind), max(1, Mode(2)-Wind):min(L, Mode(2)+Wind)) = ...
         zeros(size(Cumulative(max(1, Mode(1)-Wind):min(L, Mode(1)+Wind),max(1, Mode(2)-Wind):min(L, Mode(2)+Wind))));
   else
		Cumulative(...
         max(1, Mode(1)-Wind):min(L, Mode(1)+Wind), ...
         max(1, Mode(2)-Wind):min(L, Mode(2)+Wind)) = ...
         zeros(size(Cumulative(...
         max(1, Mode(1)-Wind):min(L, Mode(1)+Wind), ...
         max(1, Mode(2)-Wind):min(L, Mode(2)+Wind))));
   end
	Max_iterats = Max_iterats-1;
	if Max_iterats < 0
		break;
	end
end

%重构分割结果图(方法：第一模态赋值1，第二模态赋值2，...。    [原图中第一行中为0的仍然赋值0])
Ones = ones(1, size(Input_vect, 2));
New_image = zeros(1, size(Input_vect, 2));
for i=1:size(Modes, 2)
   Center = Modes(:, i) * Ones;
   Norms = max(abs(Center - U_new));%？
   To_take = find(Norms <= Wind);
   New_image(To_take) = i;
end
% detecting background
To_zero = find(Input_vect(1, :) == 0);
New_image(To_zero) = 0;
New_image = reshape(New_image, [size(Input_image, 1), size(Input_image, 2)]);
