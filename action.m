function [cost,g]=action(x, y, D, N, M, dt, beta)
x = reshape(x, N, D);
Rm = zeros(D);
Rf = beta*0.01.*eye(D);
for i = 1:M
    if (2*i-1)<=D
        Rm(2*i-1,2*i-1) = 4;
    else
        newi = (i-ceil(D/2));
        Rm(2*newi,2*newi) = 4;
    %Rf(2*i-1,2*i-1) = 20;
    end
end

cost = 0;%sum((x-y)*Rm*(x-y)');
% Uri
tmp = x-y;
for i = 1:N
    %    tmp = x(i,:) - y(i,:);
    cost = cost + tmp(i,:)*Rm*tmp(i,:)';
end

%%% Uri
tmp = x(2:end,:) - map(x,dt);

for i = 1:(N-1)
%    tmp = (x(i+1,:))' - (x(i,:))' - 0.5*dt.*(lorenz_origin(0,x(i+1,:))+lorenz_origin(0,x(i,:)));
    cost = cost + tmp(i,:)*Rf*tmp(i,:)';
end

if nargout > 1
    grad1 = 0.5*(x-y)*Rm;
    grad2 = 0.*grad1;
    tmp = (x(2:end,:)) - map(x,dt);
    allDF = lorenz_DF(x);
    for i=1:(N-1)        
        grad2(i,:) = (Rf*tmp(i,:)')'*(-eye(D)-0.5*dt.*allDF(:,:,i));
        grad2(i+1,:) = grad2(i+1,:) + (Rf*tmp(i,:)')'*(eye(D)-0.5*dt.*allDF(:,:,i+1));
    end
    g = reshape(grad1+grad2,N*D,1); 
end

end

function next = map(x,dt)
    
     next = (x(1:end-1,:)) + 0.5*dt.*(lorenz_origin(0,x(2:end,:))+lorenz_origin(0,x(1:end-1,:)));

end

% def action_grad(X):
%    
%     #dt = 0.025
%     x = X.reshape((N,D))
%     Rmtmp = np.zeros(D)
%     Rftmp = 10*np.ones(D)
%     for i in range(M):
%         Rmtmp[2*i] = 1
%         Rftmp[2*i] = 20
%     Rm = np.diag(Rmtmp)
%     Rf = np.diag(Rftmp)
%     grad1 = np.dot(Rm, (x-Y).T).T
%     grad2 = grad1*0
%     for i in range(1,N-1):
%         tmpf = x[i+1,:]-x[i,:]-dt*lorenz(x[i,:])
%         grad2[i,:] = np.dot(np.dot(Rf, tmpf.T), (-np.identity(D)- dt*DF(x[i,:]))).T
%         tmpf = x[i,:]-x[i-1,:]-dt*lorenz(x[i-1,:])
%         grad2[i,:] += np.dot(Rf, tmpf.T).T
%     tmpf = x[1,:]-x[0,:]-dt*lorenz(x[0,:])
%     grad2[0,:] = np.dot(np.dot(Rf, tmpf.T), (-np.identity(D)- dt*DF(x[0,:]))).T
%     tmpf = x[N-1,:]-x[N-2,:]-dt*lorenz(x[N-2,:])
%     grad2[N-1,:] = np.dot(Rf, tmpf.T).T
%     grad = grad1 + grad2
%     return grad.reshape(N*D)


% def action(X):
%     #M = 2
%     
%     x = X.reshape((N,D))
%     Rmtmp = np.zeros(D)
%     Rftmp = 10*np.ones(D)
%     for i in range(M):
%         Rmtmp[2*i] = 1
%         Rftmp[2*i] = 20
%     Rm = np.diag(Rmtmp)
%     Rf = np.diag(Rftmp)
%     Cost = 0.5*np.sum(np.dot(np.dot((x-Y), Rm),(x-Y).T))
%     for i in range(N-1):
%         tmpf = x[i+1,:]-x[i,:]-dt*lorenz(x[i,:])
%         Cost += 0.5*np.dot(np.dot(tmpf,Rf),tmpf.T)
%     return Cost