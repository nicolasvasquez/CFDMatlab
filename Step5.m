nx = 81;
ny = 81;
nt = 100;
c = 1;
dx = 2/(nx-1);
dy = 2/(ny-1);
sigma = .2;
dt = sigma*dx;

x = linspace(0, 2, nx);
y = linspace(0, 2, ny);

% Initial conditions
u = ones(ny, nx);
u(fix(.5/dy):fix(1/dy+1), fix(.5/dx):fix(1/dx+1)) = 2;
[nx, ny] = size(u);
mesh(y, x, u)
%imagesc(u);axis('square')
set(gca,'nextplot','replacechildren','visible','off')
f=getframe;
[im,map] = rgb2ind(f.cdata,256,'nodither');
im(1,1,1,nt) = 0;

for t=1:nt
    un = u;
    for j=1:ny
        for i=1:nx
            u(j,i) = (un(j,i) - (c*dt / dx * (un(j,i) - un(j, mod((i-1)-1, ny)+1))) - ...
                                (c*dt / dy * (un(j,i) - un(mod((j-1)-1, nx)+1, i))));
            u(1 , :) = 1;
            u(ny, :) = 1;
            u(: , 1) = 1;
            u(: ,nx) = 1;
        end
    end
    mesh(y, x, u);
    %imagesc(u); axis('square')
    f = getframe;
    im(:,:,1,t) = rgb2ind(f.cdata,map,'nodither');
end
imwrite(im,map,'wave5.gif','DelayTime',0.1,'LoopCount',1)
