function allDF = lorenz_DF(x)
    tmp = size(x);
    len = tmp(1); dim = tmp(2);
    unos = ones(len,1);
    zip = zeros(len,1);
    % URI - write each time-steps as a row, resize later to 3D array
    JJ = [-1*unos, x(:,5), zip, -x(:,5), x(:,2)-x(:,4), ...
	x(:,3)-x(:,5), -unos, x(:,1), zip, -x(:,1), ...
	-x(:,2), x(:,4)-x(:,1), -unos, x(:,2), zip, ...
	zip, -x(:,3), x(:,5)-x(:,2), -unos, x(:,3), ...
	x(:,4), zip, -x(:,4), x(:,1)-x(:,3), -unos];

   allDF = zeros(dim, dim, len);
   
   for i = 1:len
        allDF(:,:, i) = reshape(JJ(i,:), dim, dim)';
   end
end