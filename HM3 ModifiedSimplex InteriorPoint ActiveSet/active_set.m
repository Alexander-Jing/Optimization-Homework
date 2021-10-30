% 测试有效集法
A = [-1,2;1,2;1,2;];
b = [2;6;2;];
lb = zeros(1,2);
x0 = [0.5,0.5];
fun = @(x)(x(1)-1)^2 + (x(2)-2.5)^2 - 7.25;
% options = optimoptions('fmincon','Algorithm','active-set','Display','iter','MaxIterations',5);
% x = fmincon(fun,x0,A,b,[],[],lb,[],[],options)
X_1 = [];
X_2 = [];
N = 10;
for n = 1:N
    options = optimoptions('fmincon','Algorithm','active-set','MaxIterations',n);
    x = fmincon(fun,x0,A,b,[],[],lb,[],[],options);
    X_1(n) = x(1,1);
    X_2(n) = x(1,2);
end
figure
t = 1:N;
scatter(t,X_1,"filled")
hold on
scatter(t,X_2,"filled")
hold off
legend("x1","x2")
title("有效集法迭代计算")
xlabel("迭代次数")
ylabel("变量值")
xticks(t)
grid on


