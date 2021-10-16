%f表示f表达式
%H0表示初始的海森矩阵
%x0表示初始的迭代点 为列向量
%m表示变量的个数
%k表示迭代次数
%X存储每次迭代的x,F为函数值，G为每次的梯度，H为海森阵，HN为海森矩阵的逆

function[X, H, F, G,HN] = BFGS(f,H0,x0,m,k)
    
    x1 = sym('x',[1,m]);  % 创建变量 [x1,x2]
    c = num2cell(x1);  % 设置存储变量的数组
    g = sym('x',[m,1]);  % 创建变量 [x1;x2]
    X = zeros(m, k+1);  % 每次迭代的x的值
    F = zeros(1, k+1);  % 每次迭代的函数值
    G = zeros(m, k+1);  % 每次迭代的梯度
    H = zeros( m, m, k+1);  % 每次迭代的海森矩阵
    HN = zeros( m, m, k+1);  % 每次迭代的海森矩阵的逆
    % 初始值要求出来带入
    H(:,:,1) = H0;  
    HN(:,:,1) = inv(H0);
    X(:,1) = x0;
    F(1,1) = subs(f,c,{X(:,1)'});
    h = hessian(f,x1);%求海森矩阵
    for n = 1:m
        g(n) = diff(f,x1(n));  % f函数对x1,x2求梯度函数
    end
     G(:,1) = subs(g,c,{X(:,1)'});  % x1，x2带入梯度函数
    % BFGS 要计算初始的x2
    i = 1;
    X(:,i+1) = X(:,i) - (H(:,:,i))\G(:,i);
    F(1,i+1) = subs(f,c,{X(:,i+1)'}); 
    G(:,i+1) = subs(g,c,{X(:,i+1)'});
    
    for n = 2:k+1
        qn = G(:,n) - G(:,n-1);  % 计算BFGS中的qk
        sn = X(:,n) - X(:,n-1);  % 计算BFGS中的qk
        H(:,:,n) = H(:,:,n-1) + (qn*qn')/(qn'*sn) - (H(:,:,n-1)'*sn*sn'*H(:,:,n-1))/(sn'*H(:,:,n-1)*sn);  % 从x2起的海森矩阵是通过迭代计算的
        HN(:,:,n) = inv(H(:,:,n));  % 存入x2起的海森矩阵的逆
        
        X(:,n+1) = X(:,n) - (H(:,:,n))\G(:,n);
        F(1,n+1) = subs(f,c,{X(:,n+1)'});   % 更新数值后记录函数值和梯度
        G(:,n+1) = subs(g,c,{X(:,n+1)'});
    end
end