clear
nx = 41;
ny = 41;
nt = 120;
c = 1;
dx = 2/(nx-1);
dy = 2/(ny-1);
sigma = .009;
nu=.01;
dt = sigma*dx*dy/nu;

x = linspace(0, 2, nx);
y = linspace(0, 2, ny);

% Initial conditions
u = ones(ny,nx);
v = ones(ny,nx);
comb=ones(ny,nx);

u( fix(.5/dy):fix(1/dy+1) , fix(.5/dx):fix(1/dx+1) ) = 2;
v( fix(.5/dy):fix(1/dy+1) , fix(.5/dx):fix(1/dx+1) ) = 2;

mesh(y, x, u)
%imagesc(u);axis('square')
set(gca,'nextplot','replacechildren','visible','off')
f=getframe;
[im,map] = rgb2ind(f.cdata,256,'nodither');
im(1,1,1,nt) = 0;

for t=1:nt
    un=u;
    vn=v;    
    for j=2:(ny-1)
        for i=2:(nx-1)
            u(j,i) = u(j,i)- (dt/dx) * u(j,i)*(u(j,i) -u(j-1,i)) - (dt/dy) * v(j,i)*(u(j,i)-u(j,i-1)) + ...
                             (nu*dt/dx^2) *(u(j+1,i)-2*u(j,i)+u(j-1,i)) + (nu*dt/dy^2) * (u(j,i+1)-2*u(j,i)+u(j,i-1));
                         
            v(j,i) = v(j,i)- (dt/dx) * u(j,i)*(v(j,i) -v(j-1,i)) - (dt/dy) * v(j,i)*(v(j,i)-v(j,i-1)) + ...
                             (nu*dt/dx^2) *(v(j+1,i)-2*v(j,i)+v(j-1,i)) + (nu*dt/dy^2) * (v(j,i+1)-2*v(j,i)+v(j,i-1));
        end
    end

    mesh(y, x, u)
    %imagesc(u, v); axis('square')
    f = getframe;
    im(:,:,1,t) = rgb2ind(f.cdata, map, 'nodither');
end
imwrite(im,map,'wave8.gif','DelayTime',0.1,'LoopCount',1)
