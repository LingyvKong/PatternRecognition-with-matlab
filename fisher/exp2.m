load('../GIRLdata.mat');
load('../data.mat');
p1 = GIRLdatas(1:500,1:2)';
p2 = GIRLdatas(501:1000,1:2)';
f1 = [min(GIRLdatas(:,1)),max(GIRLdatas(:,1))];
f2 = [min(GIRLdatas(:,2)),max(GIRLdatas(:,2))];
fmin = floor(min(f1(1,1),f2(1,1)));
fmax = ceil(max(f1(1,2),f2(1,2)));
%%%%%%%%%%%%%%%%%%%--fisher线性判别--%%%%%%%%%%%%%%%
m1 = mean(p1,2);
m2 = mean(p2,2);
S1 = (p1-m1)*(p1-m1)';
S2 = (p2-m2)*(p2-m2)';
Sw = S1 + S2;
w_opt = inv(Sw)*(m1-m2);
b = w_opt'*(m1+m2)/2; %%%%%%%%%%%%%%%至此，求出最佳投影方向
y_dot = zeros(length(GIRLdatatest),1);
for i=1:length(GIRLdatatest)
    y_dot(i,1) = w_opt' * GIRLdatatest(i,1:2)';
    if(y_dot(i,1)>b)
        GIRLdatatest(i,3)=1;
    else
        GIRLdatatest(i,3)=0;
    end
end   %%%%%%%%%%%%%%%%%%%%%%%%%%完成分类
x1 = linspace(fmin,fmax,100)';
n = size(x1,1);
X1 = zeros(n,1);
tX1 = zeros(n,1);
syms x2 y1 y2;
for i=1:n
    x=[x1(i,1);x2];
    y1 = w_opt' * x - b;  %求决策面
    t_wopt = [w_opt(2);-w_opt(1)];
    y2 = t_wopt' * x;  %求投影到的直线
    a1 = solve(y1,x2);
    a2 = solve(y2,x2);
    if size(a1,1)~=0
        X1(i,1)=a1(1,1);
    end
    if size(a2,1)~=0
        tX1(i,1)=a2(1,1);
    end
end  %%%%%%%%%%%%%%%%%%%%%%%%%%%%求决策面和投影直线
% x11 = GIRLdatatest(:,1);
% n1 = size(x11,1);
% X11 = zeros(n1,1);
% syms x2 y;
% for i=1:n1
%     x=[x11(i,1);x2];
%     y11= t_wopt' * x ;
%     a11 = solve(y11,x2);
%     if size(a11,1)~=0
%         X11(i,1)=a11(1,1);
%     end
% end  %%%%%%%%%%%%%%%%%%%%%%%%%%%%求出投影点（求错了，不想改了）
figure(1)
plot(x1,X1);  % 画出决策面
axis equal;
set(gca,'XLim',[-2 12]);
set(gca,'YLim',[-2 12]);
hold on;
scatter(GIRLdatatest(:,1),GIRLdatatest(:,2),'filled','cdata',GIRLdatatest(:,3)+1);
hold on;
plot(x1,tX1);
% hold on;
% scatter(GIRLdatatest(:,1),X11,'+','cdata',GIRLdatatest(:,3)+1);