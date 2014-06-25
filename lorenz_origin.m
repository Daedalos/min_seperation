function dxdt = lorenz_origin(t,x)

dxdt = zeros(size(x));
v = 8.17;
dxdt(:,1) = x(:,5).*(x(:,2)-x(:,4))-x(:,1)+v;
dxdt(:,2) = x(:,1).*(x(:,3)-x(:,5))-x(:,2)+v;
dxdt(:,3) = x(:,2).*(x(:,4)-x(:,1))-x(:,3)+v;
dxdt(:,4) = x(:,3).*(x(:,5)-x(:,2))-x(:,4)+v;
dxdt(:,5) = x(:,4).*(x(:,1)-x(:,3))-x(:,5)+v;
end