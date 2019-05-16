%Example usage: EbolaFit([800; 125; 0])
function SEIRdatafit(IC)
in = xlsread('eboladata.xlsx','A14:A32');  %liberia
%in = xlsread('eboladata.xlsx','B2:B22'); %sierra leone
%in = xlsread('eboladata.xlsx','C2:C22'); %guinea
len = length(in);
out = cumsum(in);

interval = [0 len*7];
n = len*70;

h = (interval(2)-interval(1))/n;
t(1) = interval(1);
y = zeros(5,n+1);
y(:,1) = IC;

%amount of iterations
[m,n] = size(y(2,:));
dis = (n-1)/length(out);

r(1,:) = [0, 0, 0];
c = 0;

for i = 1:size(out)
    figure(1);plot(i*7,out(i),'bo','LineWidth',2)
    hold on 
end

    for b = 0.29%0.2:0.02:0.3
        for m = 0.16%0.1:0.02:0.25
            c = c + 1;
            sum = 0;
            for k=1:n
                t(k+1) = t(k) + h;
                y(:,k+1) = RK4step(t(k),y(:,k),h,k,b,m);
            end
            for a = 1:length(out)
                sum = sum + (out(a)-y(5,dis*a))^2;
            end
            r(c,:) = [sqrt((sum/length(out))), b, m]; %assign RMSE,b,& m      
            figure(1);
            pl = plot(t,y(5,:),'r');
            %xlabel(sprintf('Beta = %d, Mu = %d',b,m))
            pause(.2);delete(pl);
        end
    end
    
[Rmin, i] = min(r(:,1));
Rmin
beta = r(i,2)
mu = r(i,3)


for k=1:n
    t(k+1) = t(k) + h;
    y(:,k+1) = RK4step(t(k),y(:,k),h,k,beta,mu);
end
figure(1);plot(t,y(5,:),'r','LineWidth',2)
set(gca,'FontSize',18)
ylabel('cumulative number of cases','FontSize',21)
%xlabel(sprintf('Beta = %d, Mu = %d',beta,mu))
%xlabel( sprintf('time(days) \n beta = 0.29, mu = 0.16'),'FontSize',15)
xlabel( 'time(days)','FontSize',21)
legend('Liberia',21)
hold off;




function y = RK4step(t,x,h,k,beta,mu)
k1 = SIR(t,x,beta,mu);
k2 = SIR(t + h/2,x + h*k1/2,beta,mu);
k3 = SIR(t + h/2,x + h*k2/2,beta,mu);
k4 = SIR(t + h,x + h*k3,beta,mu);
y = x + h*(k1+2*k2+2*k3+k4)/6;


function system = SIR(~,X,beta,mu)
%beta = .000318;
%mu = .0175;
sigma = 0.2;
S = X(1); E = X(2); I = X(3); R = X(4);
N = S+E+I+R;
r1 = -beta*S*I/N;
r2 = beta*S*I/N - sigma*E;
r3 = sigma*E - mu*I;
r4 = mu*I;
r5 = sigma*E;
system = [r1;r2;r3;r4;r5];