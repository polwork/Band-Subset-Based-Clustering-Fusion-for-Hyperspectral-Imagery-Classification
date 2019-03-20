%均值漂移函数
function [Mode, Number_values] = M_shift2 (Values, Window_radius, Initial, Mv)
% assumes that Values contains cumulative information, i.e.
% the number of elements of the particular value in each Values cell

%当前位置
Current_val = round(Initial+2);
%下一步的位置
Next_val = round(Initial);
L1 = size(Values, 1);  
L2 = size(Values, 2);

% global plot_number plot_xmin plot_xmax plot_ymin plot_ymax
% if plot_number == 1
% 	figure;
% end
% [II, JJ] = find(Values > 0);
% if plot_number == 1
% 	plot_xmin = min(II)-Window_radius/2;
% 	plot_xmax = max(II)+Window_radius/2;
% 	plot_ymin = min(JJ)-Window_radius/2;
% 	plot_ymax = max(JJ)+Window_radius/2;
% end
% 
% subplot(2, 2, plot_number);
% plot(II, JJ, '.');
% xlabel('first principal component');
% ylabel('second prrincipal component');
% axis([plot_xmin plot_xmax plot_ymin plot_ymax])
% text(Next_val(1)+Window_radius/1.8, Next_val(2)-Window_radius/4, 'Initial');

while norm(Next_val-Current_val) > 2

%	Draw_rect(Window_radius, Window_radius, Next_val, 'magenta');

	Current_val = Next_val;
	clear x;
%读取选定的窗口    
    Window = Values(...
		     max(1, Current_val(1)-Window_radius): ...
             min(L1, Current_val(1)+Window_radius), ...
		     max(1, Current_val(2)-Window_radius): ...
		     min(L2, Current_val(2)+Window_radius));
%[X1,X2,X3,...] = ndgrid(x1,x2,x3,...) transforms the domain specified by
%vectors x1,x2,x3... into arrays X1,X2,X3... that can be used for the
%evaluation of functions of multiple variables and multidimensional interpolation. 
%The ith dimension of the output array Xi are copies of elements of the vector xi
	[x(1, :, :), x(2, :, :)] = ...
             ndgrid(...
             [max(1, Current_val(1)-Window_radius): ...
              min(L1, Current_val(1)+Window_radius)], ...
              [max(1, Current_val(2)-Window_radius): ...
              min(L2, Current_val(2)+Window_radius)]);
%计算x的累加和


	for i=1:2
        AA = sum(sum(squeeze(x(i, :, :)) .* Window));
%         Sum_values(1, i) = sum(sum(squeeze(x(i, :, :)) .* Window));
        Sum_values(1, i) = AA(1,1);
    end
%计算窗口内像素的累加和   
   Number_values = sum(sum(Window));
	
	if Number_values < Mv
		Mode = Initial;
		Number_values = 0;
		return;
	end
%计算下一个位置
   Next_val = round(Sum_values/Number_values);
end
Mode = Next_val;

% text(Next_val(1)+Window_radius/1.8, Next_val(2)+Window_radius/4, 'Final');
% plot_number = plot_number+1;
