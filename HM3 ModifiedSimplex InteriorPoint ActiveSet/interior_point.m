% �ڵ㷨,ʹ��quadprog��������Ĭ����ʹ�õ��ڵ㷨��������ѡ����������
H = [2,0;0,2];
f = [-2;-5];
A = [-1,2;1,2;1,2;];
b = [2;6;2;];
lb = zeros(2,1);
x0 = [0.5;0.5];
X_1 = [];
X_2 = [];
N = 10;
% options = optimoptions(@fmincon,'Algorithm','interior-point','Display','iter-detailed')
% x = quadprog(H,f,A,b,[],[],lb,[],x0,options)
for n = 1:N
    options = optimoptions(@fmincon,'Algorithm','interior-point','MaxIterations',n);
    x = quadprog(H,f,A,b,[],[],lb,[],[],options);
    X_1(n) = x(1,1);
    X_2(n) = x(2,1);
end
figure
t = 1:N;
scatter(t,X_1,"filled")
hold on
scatter(t,X_2,"filled")
hold off
legend("x1","x2")
title("�ڵ㷨��������")
xlabel("��������")
ylabel("����ֵ")
xticks(t)
grid on

