clc
clear all
syms x nu t
filename="Wave4.gif"
phi = exp(-(x-4*t)^2/(4*nu*(t+1))) + exp(-(x-4*t-2*pi)^2/(4*nu*(t+1)));
phiprime=diff(phi,x); %symbolic diff
usym = -2*nu*(phiprime/phi)+4; 
ufunc=matlabFunction(usym); 
nx = 101;
nt = 100;
nu = 0.07;
dx = 2*pi/(nx-1);
dt = dx*nu;
x=linspace(0,2*pi,nx);
un=zeros(nx);
t=0;
u=ufunc(nu,t,x);


un = zeros(1,nx);
figure(4)
for n=1:1:nt;  
    un = u; 
    for i=2:1:nx-1 
        u(i)=un(i)- un(i) * dt/dx *(un(i)-un(i-1))+nu* dt/dx^2 * (un(i+1)-2*un(i) +un(i-1));
    end
    u(1) =un(1)- un(1) * dt/dx *(un(1)-un(nx-1))+nu* dt/dx^2 * (un(2)-2*un(1) +un(nx-1)) %Anfangswert 
    u(nx)=u(1) 
    plot(x,u)
    drawnow
    frame = getframe(4);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256,'nodither');
    if n == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    pause(0.001)
    hold on
    end
    u_analytical = ufunc(nu,n*dt,x);

    plot(x,u_analytical)
    pause(0.001)