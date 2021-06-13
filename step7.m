%%%variable declarations
clear all
nx = 31;
ny = 31;
nt = 170;
dx = 2.0/(nx-1);
dy = 2.0/(ny-1);
sigma = .25;
nu=.05
dt = sigma*dx*dy/nu;
filename="surface7.gif"

x = linspace(0,2,nx);
y = linspace(0,2,ny);

u = ones(ny,nx);
un=ones(ny,nx);

u(.5/dy:1/dy+1,.5/dx:1/dx+1)=2;
figure(7)
for n=1:nt+1
    un=u;
    for i=2:(ny-1)
        for j=2:(nx-1)
        u(i,j)=un(i,j)+nu*dt/dx^2*(un(i+1,j)-2*un(i,j)+un(i-1,j))+nu*dt/dy^2*(un(i,j+1)-2*un(i,j)+un(i,j-1));
        end
    end
   surf(x,y,u) % Gráfico de superficie.
   drawnow
   frame = getframe(7);
   im = frame2im(frame);
   [imind,cm] = rgb2ind(im,256);
   if n == 1
       imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
   else
       imwrite(imind,cm,filename,'gif','WriteMode','append');
   end
   pause(0.1)
end

