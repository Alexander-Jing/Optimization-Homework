function [x,fval] = GA

% draw the mesh image of the function 
% xn1 = linspace(-6,6,1200);
% xn2 = linspace(-6,6,1200);
% [X1, X2] = meshgrid(xn1, xn2);
% Z = (2186 - (X1.^2+X2-11).^2 - (X1+X2.^2 - 7).^2)/2186;
% %mesh(X1,X2,Z);
% contour(X1,X2,Z,100);

% the GA 
nvars = 2;
A = [1,0;
    0,1;
    -1,0;
    0,-1;];
b = [6;0;0;6];
options = optimoptions('ga','ConstraintTolerance',1e-6,'PlotFcn', @gaplotbestf);
[x,fval] = ga(@objfun,nvars,A,b,[],[],[],[],[],options)

% the object function
function f = objfun(x)
    f = -(2186 - (x(1).^2+x(2)-11)^2 - (x(1)+x(2).^2 - 7)^2)/2186;
end



end