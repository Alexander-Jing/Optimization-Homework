function [x,fval,history] = SA_temp
    
history.fval = [];
history.x = [];
history.temp = [];
history.iter = [];

% 设置迭代将使用输出函数
options = saoptimset('OutputFcn',@outfun);
t = 0 : 0.02 : 1;
plot(t,objfun(t))
ylabel('f(x)')
xlabel('x')
lb = 0;
lu = 1;
x0 = 1;

% 迭代
[x,fval] = simulannealbnd(@objfun,x0,lb,lu,options);


% 输出函数，感谢群里的倪嵩浩同学给出的解决方案
function [stop,optnew,changed] = outfun(optold,optimValues,flag)
        stop = false;
        changed = false;
        optnew = optold;
        history.fval = [history.fval;optimValues.fval];
        history.x = [history.x;optimValues.x];
        history.temp = [history.temp;optimValues.temperature];
        history.iter = [history.iter;optimValues.iteration];
end

% 目标函数
function f = objfun(x)
f = (-1).*exp(-2.*log(2).*((x-0.008)/0.854)).* (sin(5.*pi.*(x.^0.75-0.05))).^6;
end

% 绘制题目要求的部分
history.fval;
history.x;
history.temp;
history.iter;
subplot(3,1,1)
plot(history.iter,history.x)
xlabel('iter')
ylabel('iteration point')

subplot(3,1,2)
plot(history.iter,history.fval)
xlabel('iter')
ylabel('function value')

subplot(3,1,3)
plot(history.iter,history.temp)
xlabel('iter')
ylabel('temperature function')

end




