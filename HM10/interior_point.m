% 内点法,使用quadprog函数，其默认是使用的内点法，还可以选择其他方法
h =0.000000000001*[
   116230728,    58115364,   -14741590,   -14741590,   -29483180,           0,     5484111;
    58115364,    58115364,           0,           0,   -14741590,           0,           0;
   -14741590,           0,     7572778,     3786389,     3786389,    -1378625,    -2757250;
   -14741590,           0,     3786389,     3786389,     3786389,           0,    -1378625;
   -29483180,   -14741590,     3786389,     3786389,     7572778,           0,           0;
           0,           0,    -1378625,           0,           0,      521317,      521317;
     5484111,           0,    -2757250,    -1378625,           0,      521317,     1042634;
     ];
 
H = 2*h;
f =  0.000000000001*[-62073116.68, -37933172.68, -3647192.66, -1175478.66, 8383432.64, 15489.25, -2250088.75]';

A = [1,1,0,0,0,0,0;
     0,0,1,1,1,0,0;
     0,0,0,0,0,1,1;];
b = [  0.30+0.05;
       0.46+0.15;
       0.11+0.11;];

lb = [0.01; 0.25; 0.01; 0.35; 0.01; 0.20; 0.01];
ub = ones(7,1);
x0 = [];
X = [];
N = 10;

for n = 1:N
    options = optimoptions(@fmincon,'Algorithm','interior-point','MaxIterations',n);  %active-set  interior-point sqp
    x = quadprog(H,f,A,b,[],[],lb,[],[],options);
    X(:,n) = x;
end
X'

figure
t = 1:N;
plot(t,X(1,:))
hold on
plot(t,X(2,:))
hold on
plot(t,X(3,:))
hold on
plot(t,X(4,:))
hold on
plot(t,X(5,:))
hold on
plot(t,X(6,:))
hold on
plot(t,X(7,:))
hold off
legend("a1","a2","b1","b2","b4","c2","c4")
title("内点法迭代计算")
xlabel("迭代次数")
ylabel("变量值")
xticks(t)
grid on

