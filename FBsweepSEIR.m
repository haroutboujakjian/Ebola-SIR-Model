%Example usage: FBsweepSEIR([4850;1;1;0])
function FBsweepSEIR(IC)
set(0,'defaultaxesfontsize',17,'defaultaxeslinewidth',1.5,...
    'defaultlinelinewidth',2);
interval = [0 300];
n = 1500;
h = (interval(2)-interval(1))/n;
t(1) = interval(1);
y = zeros(4,n+1);
y(:,1) = IC;
L = zeros(4,n+1);
v = zeros(1,n+1);q = zeros(1,n+1);

N = IC(1)+IC(2)+IC(3)+IC(4);
global beta mu sigma
beta = 0.29; mu = .16; sigma = 0.2;

%Optimality condition variables
val = [4000,8000,16000,32000,64000];
vals = [1000,2000,4000,5000,7000,15000,30000];
colorspec = {[0,.5,0],[0,1,0],[0,.98,0.61],[.27,.51,.71],[0,0,1]};

rgb = 1;
for z = val;
   A1v = 100^10; B1q = z;

fin = 2000;
for i = 1:fin
    oldv = v;oldq = q;
    
    %forward RK4
    for k=1:n
        t(k+1) = t(k) + h;
        y(:,k+1) = RK4step(t(k),y(:,k),h,v,q,k);
    end
    
    %Backward RK4
    for k=1:n
        j = n + 2 - k;
        L(:,j-1) = BackRK4step(t(j),L(:,j),h,y,v,q,j);
    end
    
    %optimality condition
    tempv = (y(1,:).*(L(1,:) - L(4,:)))/A1v;
    v1 = min(max(0,tempv),.9);
    v = 0.5*(v1 + oldv);
    
    tempq = (y(3,:).*(L(3,:) - L(4,:)))/B1q;
    q1 = min(max(0,tempq),.9);
    q = 0.5*(q1 + oldq);
    
    if i == fin
        figure(1);plot(t,q,'Color',colorspec{rgb});hold on;
        xlabel('Days');ylabel('Quarantine rate');
        %ylim([0 0.2]);
        rgb = rgb + 1;
    end
        
end
end
legend('2000','4000','8000','16000','32000')




function y = RK4step(t,x,h,v,q,k)
v = fcomb(v,k); q = fcomb(q,k);
k1 = SIR(t,x,v(1),q(1));
k2 = SIR(t + h/2,x + h*k1/2,v(2),q(2));
k3 = SIR(t + h/2,x + h*k2/2,v(2),q(2));
k4 = SIR(t + h,x + h*k3,v(3),q(3));
y = x + h*(k1+2*k2+2*k3+k4)/6;

%Forward convex combination
function a = fcomb(u,k)
left = u(k);
mid = 0.5*(u(k)+u(k+1));
right = u(k+1);
a = [left mid right];


function z = BackRK4step(t,x,h,y,v,q,k)
v = rcomb(v,k); q = rcomb(q,k);
sir = [rcomb(y(1,:),k);rcomb(y(2,:),k);rcomb(y(3,:),k);rcomb(y(4,:),k)]';
k1 = Adjoint(t,x,sir(1,:),v(1),q(1));
k2 = Adjoint(t - h/2,x - h.*k1/2,sir(2,:),v(2),q(2));
k3 = Adjoint(t - h/2,x - h.*k2/2,sir(2,:),v(2),q(2));
k4 = Adjoint(t - h,x - h.*k3,sir(3,:),v(3),q(3));
z = x - h.*(k1+2*k2+2*k3+k4)/6;

%Backward convex combination
function b = rcomb(u,k)
left = u(k);
mid = 0.5*(u(k)+ u(k-1));
right = u(k-1);
b = [left mid right];




function system = SIR(~,X,v,q)
global beta mu sigma
S = X(1); E = X(2); I = X(3); R = X(4);
N = S+E+I+R;

r1 = -beta*S*I/N - v*S;
r2 = beta*S*I/N - sigma*E;
r3 = sigma*E - mu*I - q*I;
r4 = mu*I + v*S + q*I;
system = [r1;r2;r3;r4];

function Asystem = Adjoint(~,X,Y,v,q)
global beta mu sigma
LS = X(1);LE = X(2); LI = X(3);LR = X(4);
S = Y(1); E = Y(2); I = Y(3); R = Y(4);
N = S+E+I+R;

r1 = LS*(beta*I/N + v) - LE*(beta*I/N) - LR*v;
r2 = LE*sigma - LI*sigma;
r3 = -1+LS*(beta*S/N)-LE*(beta*S/N)+LI*(mu + q)-LR*(mu + q);
r4 = 0;
Asystem = [r1;r2;r3;r4];