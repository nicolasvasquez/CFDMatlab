clear all
nx=100; ny=100; nt=100;
xmin=0; xmax=2; 
ymin=0; ymax=1;
dx = (xmax-xmin)/(nx-1); 
dy=(ymax-ymin)/(ny-1);
filename="surface10.gif"
p=zeros(nx,ny);
pd=zeros(nx,ny);
b=zeros(nx,ny);
x=xmin:dx:xmax; 
y=ymin:dy:ymax;

b(floor(nx/4),floor(ny/4))=100;
b(floor(3*nx/4),floor(3*ny/4))=-100;

figure(10)
for nt = 1:nt
    pd=p;
    for i=2:nx-1
        for j=2:ny-1
            p(i,j) = ((pd(i+1,j)+pd(i-1,j))*dy^2+ (pd(i,j-1)+pd(i,j+1))*dx^2 -b(i,j)*dx^2*dy^2 )/(dx^2+dy^2)/2;
        end
    end
    p(2:nx-1,1)=p(2:nx-1,2);
    p(2:nx-1,ny)=p(2:nx-1,ny-1);

    surf(x,y,p) %Gráfico de superficie
    drawnow
    frame = getframe(10);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if nt == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    
end


