%variable declarations
nx = 31;
ny = 31;
c = 1;
dx = 2 / (nx - 1);
dy = 2 / (ny - 1);

%initial conditions
p = zeros(ny, nx);  % create a XxY vector of 0's


%plotting aids
x = linspace(0, 2, nx);
y = linspace(0, 1, ny);

%boundary conditions
p(:, 1) = 0;  % p = 0 @ x = 0
p(:, end) = y;  % p = y @ x = 2
p(1, :) = p(2, :);  % dp/dy = 0 @ y = 0
p(end, :) = p(end-1, :);  % dp/dy = 0 @ y = 1


l1norm = 1;
l1norm_target = 1e-4;
while l1norm > l1norm_target
    pn = p;
    p(2:end-1, 2:end-1) = ((dy^2 * (pn(2:end-1, 3:end) + pn(2:end-1, 1:end-2)) + ...
        dx^2 * (pn(3:end, 2:end-1) + pn(1:end-2, 2:end-1))) / ...
        (2 * (dx^2 + dy^2)));
   p(:, 1) = 0;  % p = 0 @ x = 0
   p(:, end) = y;  % p = y @ x = 2
   p(1, :) = p(2, :);  % dp/dy = 0 @ y = 0
   p(end, :) = p(end-1, :);  % dp/dy = 0 @ y = 1
   l1norm = (sum(abs(p(:)) - abs(pn(:))) / sum(abs(pn(:))));
   surf(x, y, p)
   pause(0.001)
end
  

