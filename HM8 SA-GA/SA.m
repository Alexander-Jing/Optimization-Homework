options = saoptimset('Display', 'iter', 'PlotFcns ', {@saplotbestf , @saplotf , @saplotbestx ,@saplotx ,@saplottemperature});
t = 0 : 0.02 : 1;
plot(t,myfun(t))
ylabel('f(x)')
xlabel('x')
lb = 0;
lu = 1;
x0 = 1;
[x,fval] = simulannealbnd(@myfun,x0,lb,lu,options);
% @obj是要写一个函数的 .m 文件



