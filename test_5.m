syms x1 x2;
f = (x1 - 2)^2 + 4*(x2 - 3)^2;
x0 = [0, 0]';
m = 2;
k = 10;  % ����10��
lamda = 0.0001;  % lamda Ӧ���ǱȽ�С����
[X,F,G,G_norm] = Steepest_descent_method(f,x0,m,k);
X'
F'
G'
G_norm'


x_axis = 0:1:10;  % ����x��,������ͼ
subplot(2,2,1)
plot(x_axis, X(1,:))
title("x1ֵ�����仯")

subplot(2,2,2)
plot(x_axis, X(2,:))
title("x2ֵ�����仯")

subplot(2,2,3)
xn1 = linspace(0,4);% ����x1�ĵ��У�Ĭ����100����0 4�������½�
xn2 = linspace(0,4);% ����x2����
[X1,X2] = meshgrid ( xn1 , xn2);% �����������
z = (X1-2).^2 + 4*(X2-3).^2; % ע���� .^
surf(X1,X2,z) % ���ɺ���ͼ��
title("����surf")

subplot(2,2,4)
contour(X1,X2,z,100) % ���ɵ�ֵ�ߣ����һ��������ʾ��ʾ�ĵ�ֵ�ߵĸ���
hold on
plot(X(1,:),X(2,:))
title("������������")
