clear all
nx = 41;
dx = 2./(nx-1);
nt = 200;
dt = .025;  %delta t
c=1;
filename="Wave1.gif";

u = ones(1,nx);
u(1,0.5/dx : 1/dx+1)=2; 

un = ones(1,nx);

figure(1)
for n=1:1:nt
    un = u;
    for i=2:1:nx
    u(i)=un(i)-c*dt/dx*(un(i)-un(i-1));
    end
    plot(linspace(0,2,nx),u)
    drawnow
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256, 'nodither');
    if n == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    
    
    pause(0.01)
end