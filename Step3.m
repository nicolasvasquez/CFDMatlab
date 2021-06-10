nx = 41;
dx = 2 / (nx - 1);
nt = 20;    %the number of timesteps we want to calculate
nu = 0.3;   %the value of viscosity
sigma = .2;
dt = sigma * dx^2 / nu; %CFL = u * dt/dx < CFL_max

u = ones(1,nx);
u(1,0.5/dx : 1/dx+1) = 2;

un = ones(1,nx);

for n = 1:nt
    un = u;
    for i = 2:nx-1
        u(i) = un(i) + nu * dt / dx^2 * (un(i+1) - 2 * un(i) + un(i-1));
    end
    plot(linspace(0, 2, nx), u);
    pause(0.1);
end