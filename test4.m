%测试函数，用于测试算法
syms x1 x2;
f = (x1 - 3)^4 + (x1 - 3*x2)^2;
H = hessian(f,[x1,x2]);
x0 = [0, 0]';
H0 = subs(H,{x1,x2},{x0'});
m = 2;
k = 3;
lamda = 0.0001;  % lamda 应该是比较小的量
%[X, H, F, G,HN] = Newton(f,H0,x0,m,k)
%[X, H, F, G,HN] = LM(f,H0,x0,m,k,lamda)
%[X, H, F, G,HN] = BFGS(f,H0,x0,m,k)
[X, H, F, G,HN] = DFP(f,H0,x0,m,k)
