function [x,fval,history] = SA_temp
    
history.fval = [];
history.x = [];
history.temp = [];
history.iter = [];

% ���õ�����ʹ���������
options = saoptimset('OutputFcn',@outfun);
t = 0 : 0.02 : 1;
plot(t,objfun(t))
ylabel('f(x)')
xlabel('x')
lb = 0;
lu = 1;
x0 = 1;

% ����
[x,fval] = simulannealbnd(@objfun,x0,lb,lu,options);


% �����������лȺ������Ժ�ͬѧ�����Ľ������
function [stop,optnew,changed] = outfun(optold,optimValues,flag)
        stop = false;
        changed = false;
        optnew = optold;
        history.fval = [history.fval;optimValues.fval];
        history.x = [history.x;optimValues.x];
        history.temp = [history.temp;optimValues.temperature];
        history.iter = [history.iter;optimValues.iteration];
end

% Ŀ�꺯��
function f = objfun(x)
f = (-1).*exp(-2.*log(2).*((x-0.008)/0.854)).* (sin(5.*pi.*(x.^0.75-0.05))).^6;
end

% ������ĿҪ��Ĳ���
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




