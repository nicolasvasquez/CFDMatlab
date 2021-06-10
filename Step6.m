%variable declarations
nx = 101;
ny = 101;
nt = 80;
c = 1;
dx = 2 / (nx - 1);
dy = 2 / (ny - 1);
sigma = .2;
dt = sigma * dx;

x = linspace(0, 2, nx);
y = linspace(0, 2, ny);

u = ones(ny, nx); %create a 1xn vector of 1's
v = ones(ny, nx);
un = ones(ny, nx);
vn = ones(ny, nx);

%Assign initial conditions
%set hat function I.C. : u(.5<=x<=1 && .5<=y<=1 ) is 2
u(.5 / dy:1 / dy + 1, .5 / dx:1 / dx + 1) = 2;
%set hat function I.C. : v(.5<=x<=1 && .5<=y<=1 ) is 2
v(.5 / dy:1 / dy + 1, .5 / dx:1 / dx + 1) = 2;


%Second cell
[X, Y] = meshgrid(x, y);

%Third cell
ds = 1;
for n = 1:nt + 1
    un = u;
    vn = v;
    
    u(2:end, 2:end) = ((un(2:end, 2:end)) - ...
                 (un(2:end, 2:end) .* (c * (dt / dx) * (un(2:end, 2:end) - un(2:end, 1:end-1)))) - ...
                  vn(2:end, 2:end) .* (c * (dt / dy) * (un(2:end, 2:end) - un(1:end-1, 2:end))));
                  
    v(2:end, 2:end) = (vn(2:end, 2:end) - ...
                 (un(2:end, 2:end) .* (c * (dt / dx) * (vn(2:end, 2:end) - vn(2:end, 1:end-1)))) - ...
                 vn(2:end, 2:end) .* (c * (dt / dy) * (vn(2:end, 2:end) - vn(1:end-1, 2:end))));
                 
    u(1, :) = 1;
    u(end, :) = 1;
    u(:, 1) = 1;
    u(:, end) = 1;
    
    v(1, :) = 1;
    v(end, :) = 1;
    v(:, 1) = 1;
    v(:, end) = 1;
    
    surf(x, y, u)
    pause(0.001)
end 