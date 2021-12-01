function [xsol,fval,history] = interior_point_method
 
% Set up shared variables with outfun
history.x1 = [];
history.fval1 = [];
history.x2 = [];
history.fval2 = [];


x0 = [0.1,0.1];  % set the initail point
options = optimoptions(@fmincon,'OutputFcn',@outfun1,... 
    'Display','iter','Algorithm','interior-point');  % active-set
[xsol,fval] = fmincon(@objfun,x0,[],[],[],[],[],[],@confun,options);

x0 = [-0.1,-0.1];  % set the initail point again, to test the other initail point
options = optimoptions(@fmincon,'OutputFcn',@outfun2,... 
    'Display','iter','Algorithm','interior-point');  % active-set
[xsol,fval] = fmincon(@objfun,x0,[],[],[],[],[],[],@confun,options);

% record the x value during the iterations, initial x [0.1,0.1]
 function stop = outfun1(x,optimValues,state)
     stop = false;
     switch state
         case 'init'
         case 'iter'
         % Concatenate current point and objective function
         % value with history. x must be a row vector.
           history.fval1 = [history.fval1; optimValues.fval];
           history.x1 = [history.x1; x];
         case 'done'
         otherwise
     end
 end

% record the x value during the iterations, initial x [-0.1,-0.1]
function stop = outfun2(x,optimValues,state)
     stop = false;
     switch state
         case 'init'
         case 'iter'
         % Concatenate current point and objective function
         % value with history. x must be a row vector.
           history.fval2 = [history.fval2; optimValues.fval];
           history.x2 = [history.x2; x];
         case 'done'
         otherwise
     end
end

 function f = objfun(x)
     f = -x(1)*x(2);
 end
 
 function [c, ceq] = confun(x)
     % Nonlinear inequality constraints, according to the help center the funtion should be written as f(x)<=0, the f(x) 
     c = -1+x(1)^2+x(2)^2;
     % Nonlinear equality constraints
     ceq = [];
 end
% draw the mesh image of the function 
% xn1 = linspace(-1,1,2001);
% xn2 = linspace(-1,1,2001);
% [X1, X2] = meshgrid(xn1, xn2);
% X1((1-X1.^2-X2.^2)<0) = NaN;
% X2((1-X1.^2-X2.^2)<0) = NaN;
% Z = -X1.*X2;
% % mesh(X1,X2,Z);

% %draw the contour of the function with constrains
% xn1 = linspace(-1,1,2001);
% xn2 = linspace(-1,1,2001);
% [X1, X2] = meshgrid(xn1, xn2);
% X1((1-X1.^2-X2.^2)<0) = NaN;
% X2((1-X1.^2-X2.^2)<0) = NaN;
% Z = -X1.*X2;
% contour(X1,X2,Z,50,'ShowText','on');

history.fval1
history.x1

history.fval2
history.x2

x_axis = 0:1:8;  % 创建x轴,用来画图
subplot(2,2,1)
plot(x_axis, history.x1(:,1))
hold on
plot(x_axis, history.x2(:,1))
legend('(0.1,0.1)','(-0.1,-0.1)')
title("两种情况下x1值迭代结果")

subplot(2,2,2)
plot(x_axis, history.x1(:,2))
hold on
plot(x_axis, history.x2(:,2))
legend('(0.1,0.1)','(-0.1,-0.1)')
title("两种情况下x2值迭代结果")

subplot(2,2,3)
plot(x_axis, history.fval1,'-o')
hold on
plot(x_axis, history.fval2)
legend('(0.1,0.1)','(-0.1,-0.1)')
title("两种情况下fval值迭代结果")

subplot(2,2,4)
%draw the contour of the function with constrains
xn1 = linspace(-1,1,2001);
xn2 = linspace(-1,1,2001);
[X1, X2] = meshgrid(xn1, xn2);
X1((1-X1.^2-X2.^2)<0) = NaN;
X2((1-X1.^2-X2.^2)<0) = NaN;
Z = -X1.*X2;
contour(X1,X2,Z,50);
hold on
plot(history.x1(:,1), history.x1(:,2),'-o')
hold on
plot(history.x2(:,1), history.x2(:,2),'-*')
legend('等值线','(0.1,0.1)','(-0.1,-0.1)')
title("等值线下的两种情况的x的迭代情况")
end