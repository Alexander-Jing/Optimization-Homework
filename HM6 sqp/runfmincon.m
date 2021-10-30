function [xsol,fval,history,searchdir] = runfmincon
 
% Set up shared variables with outfun
history.x = [];
history.fval = [];
searchdir = [];
 
% Call optimization
x0 = [0,0];  % set the initail point
options = optimoptions(@fmincon,'OutputFcn',@outfun,... 
    'Display','iter','Algorithm','sqp');  % active-set
[xsol,fval] = fmincon(@objfun,x0,[],[],[],[],[],[],@confun,options);
 
 function stop = outfun(x,optimValues,state)
     % draw the contour of the function with constrains
     xn1 = linspace(0,2);
     xn2 = linspace(0,6);
     [X1, X2] = meshgrid(xn1, xn2);
     X2((X1.^2-X2)>0) = NaN;
     X2((X1+X2)>6) = NaN;
     X2(X1<0) = NaN;
     X2(X2<0) = NaN;
     Z = (X1-9/4).^2 + (X2-2).^2;
     contour(X1,X2,Z,30,'ShowText','on');
     hold on
     
     stop = false;
     switch state
         case 'init'
             hold on
         case 'iter'
         % Concatenate current point and objective function
         % value with history. x must be a row vector.
           history.fval = [history.fval; optimValues.fval];
           history.x = [history.x; x];
         % Concatenate current search direction with 
         % searchdir.
           searchdir = [searchdir;... 
                        optimValues.searchdirection'];
           plot(x(1),x(2),'o');
         % Label points with iteration number and add title.
         % Add .15 to x(1) to separate label from plotted 'o'.
           text(x(1)+.01,x(2),... 
                num2str(optimValues.iteration));
           title('Sequence of Points Computed by fmincon');
         case 'done'
             hold off
         otherwise
     end
 end
 
 function f = objfun(x)
     f = (x(1)-9/4)^2 + (x(2)-2)^2;
 end
 
 function [c, ceq] = confun(x)
     % Nonlinear inequality constraints, according to the help center the funtion should be written as f(x)<=0, the f(x) 
     c = [x(1)^2-x(2);
         x(1)+x(2)-6;
         -x(1);
         -x(2);];
     % Nonlinear equality constraints
     ceq = [];
 end
% % draw the mesh image of the function 
% xn1 = linspace(0,2);
% xn2 = linspace(0,6);
% [X1, X2] = meshgrid(xn1, xn2);
% X2((X1.^2-X2)>0) = NaN;
% X2((X1+X2)>6) = NaN;
% X2(X1<0) = NaN;
% X2(X2<0) = NaN;
% Z = (X1-9/4).^2 + (X2-2).^2;
% mesh(X1,X2,Z);
 
searchdir
history.x

end