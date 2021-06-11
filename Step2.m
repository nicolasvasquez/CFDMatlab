L = 2;
nx = 41;
dx = L/(nx-1);

T = 0.625;
nt = 25;
dt = T/nt;

u = ones(1, nx);
u(fix(.5/dx):fix(1/dx+1)) = 2;
x = 0:dx:2.0;
plot(x,u)
set(gca,'nextplot','replacechildren','visible','off')
f=getframe;
[im,map] = rgb2ind(f.cdata,256,'nodither');
im(1,1,1,nt) = 0;

I = 2:nx;
for t=1:nt
    up = u;
    u(I) = up(I) - up(I)*dt/dx.*(up(I) - up(I-1));
    plot(x,u);
    f=getframe;
    im(:,:,1,t) = rgb2ind(f.cdata,map,'nodither');
end

imwrite(im,map,'wave2.gif','DelayTime',0.3,'LoopCount',1)