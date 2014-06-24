clear
load('data.mat');
D=5;
N=160;
M=3;
dt=0.025;
start=1000;
beta = 1;
data = Y(start:(N+start-1),:);

options=optimset('fminunc');
options.GradObj = 'on';
options.LargeScale='off'; options.HessUpdate='bfgs';
%options.Display = 'iter';
options.MaxIter = 3000;
%beta_set = 2.^(1:29);
M=3;    
%load('simple_start.mat');
NMin = 100;
solution = 20.*rand(NMin,D*N)-10;
for i=0:23
    beta = 2^i;
    myfun = @(x) action(x, data, D, N, M, dt, beta);
    minima = zeros(NMin,1);
    counter = 0;
    %x0 = 20.*rand(D*N,1)-10;
    
    while counter<NMin
        x0 = solution(counter+1,:);%2.*rand(D*N,1)-1;
        [x,fval,exitflag] = fminunc(myfun,x0,options);
        fprintf('beta=%d i=%d fval=%e %d\n', i, counter, fval, exitflag);
        if exitflag
            counter = counter+1;
            solution(counter,:)=x;
            minima(counter) = fval;
        end
    end
    %save('start_solution.mat','solution')
    sol_filename=sprintf('data/solution_D%d_B%d.dat',D,i);
    min_filename=sprintf('data/minima_D%d_B%d.dat',D,i);
    dlmwrite(sol_filename,solution,'delimiter',' ','precision','%e');
    dlmwrite(min_filename,minima,'delimiter',' ','precision','%e');
end
