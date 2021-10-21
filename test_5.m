syms x1 x2;
f = (x1 - 2)^2 + 4*(x2 - 3)^2;
x0 = [0, 0]';
m = 2;
k = 10;  % 迭代10次
lamda = 0.0001;  % lamda 应该是比较小的量
[X,F,G,G_norm] = Steepest_descent_method(f,x0,m,k);
X'
F'
G'
G_norm'


x_axis = 0:1:10;  % 创建x轴,用来画图
subplot(2,2,1)
plot(x_axis, X(1,:))
title("x1值迭代变化")

subplot(2,2,2)
plot(x_axis, X(2,:))
title("x2值迭代变化")

subplot(2,2,3)
xn1 = linspace(0,4);% 定义x1的点列，默认是100个，0 4代表上下界
xn2 = linspace(0,4);% 定义x2点列
[X1,X2] = meshgrid ( xn1 , xn2);% 生成坐标矩阵，
z = (X1-2).^2 + 4*(X2-3).^2; % 注意是 .^
surf(X1,X2,z) % 生成函数图像
title("函数surf")

subplot(2,2,4)
contour(X1,X2,z,100) % 生成等值线，最后一个参数表示显示的等值线的个数
hold on
plot(X(1,:),X(2,:))
title("锯齿现象的显现")
