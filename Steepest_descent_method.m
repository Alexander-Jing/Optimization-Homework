%根据助教的代码改的
%f表示f表达式
%x0表示初始的迭代点 为列向量
%m表示变量的个数
%k表示迭代次数
%X存储每次迭代的x,F为函数值，G为每次的梯度

function[X, F, G, G_norm] = Steepest_descent_method(f,x0,m,k)
    
    x1 = sym('x',[1,m]);  % 创建变量 [x1,x2]
    c = num2cell(x1);  % 设置存储变量的数组
    g = sym('x',[m,1]);  % 创建变量 [x1;x2]
    X = zeros(m, k+1);  % 每次迭代的x的值
    F = zeros(1, k+1);  % 每次迭代的函数值
    G = zeros(m, k+1);  % 每次迭代的梯度
    G_norm = zeros(1,k+1);  % 每次迭代的梯度的模值
    
    % 初始值要求出来带入
    X(:,1) = x0;
    F(1,1) = subs(f,c,{X(:,1)'});
    
    for n = 1:m
        g(n) = diff(f,x1(n));  % f函数对x1,x2求梯度函数
    end
     G(:,1) = subs(g,c,{X(:,1)'});  % x1，x2带入梯度函数
     G_norm(1,1) = norm(G(:,1));
     
    for n = 1:k
        X(:,n+1) = X(:,n) - G(:,n)/norm(G(:,n));  % 计算向量比上模长
        F(1,n+1) = subs(f,c,{X(:,n+1)'}); 
        G(:,n+1) = subs(g,c,{X(:,n+1)'});  % 存储函数值和梯度
        G_norm(1,n+1) = norm(G(:,n+1));  % 存储梯度的模值
    end
end