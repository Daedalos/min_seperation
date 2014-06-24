clear
T_total = 0:0.025:1000;
data_initial = [0.80; 0.95; 0.71; 0.24; 0.63];
[T,Y] = ode45(@lorenz_origin,T_total,data_initial);
Y = Y + 0.5.*randn(size(Y));
save('data.mat','Y')