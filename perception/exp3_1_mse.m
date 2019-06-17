%--------------- ������--------------------
MAXNUM_train = 1000;  % ��������
r1 = 0.1;  % ����
b = 0.5*ones(1000,1);  % ����
%---------------��ȡ���� & Ԥ����------------
%ѵ����ǰ500Ϊ��������500Ϊ����
load('../GIRLdata.mat');
load('../data.mat');
t = ones(1,500);
p1 = GIRLdatas(1:500,1:2)';  % class 1 ����
p1 = [t; p1];
p2 = GIRLdatas(501:1000,1:2)';  % class 2 ���� 
p2 = -[t; p2];  % �淶��������������
p = [p1, p2]';
f1 = [min(GIRLdatas(:,1)),max(GIRLdatas(:,1))];
f2 = [min(GIRLdatas(:,2)),max(GIRLdatas(:,2))];
fmin = floor(min(f1(1,1),f2(1,1)));
fmax = ceil(max(f1(1,2),f2(1,2)));
%--------------ѵ��-----------------------
% ����һ���ù�ʽֱ����
die_dai = 0;
ak = pinv(p)*b;

%---------------�������------------------
theAxes=[-2 12 -2 12];
fmat=moviein(die_dai);
x = linspace(fmin,fmax,100)';
n = size(x,1);
for j=1:die_dai+1
    y = zeros(n,1);
    for i=1:n
        y(i,1) = -(ak(2,j)/ak(3,j))*x(i)-(ak(1,j)/ak(3,j)); 
    end
    plot(x,y);
    hold on;
    scatter(GIRLdatas(:,1),GIRLdatas(:,2),'filled','cdata',GIRLdatas(:,3)+1);
    hold off;
    axis(theAxes);
    title('ѵ�������');
    fmat(:,j)=getframe;
end

%------------���� & ��ͼ-------------------
y_dot = zeros(length(GIRLdatatest),1);
t = ones(1,length(GIRLdatatest));
zengguang_data = [t; GIRLdatatest'];
for i=1:length(GIRLdatatest)
    y_dot(i,1) = ak(:,end)' * zengguang_data(:,i);
    if(y_dot(i,1)>0)
        GIRLdatatest(i,3)=1;
    else
        GIRLdatatest(i,3)=0;
    end
end   % ��ɷ���
figure(2)
% axis equal;
set(gca,'XLim',[-2 12]);
set(gca,'YLim',[-2 12]);
scatter(GIRLdatatest(:,1),GIRLdatatest(:,2),'filled','cdata',GIRLdatatest(:,3)+1);
hold on;
plot(x,y);
title('���Լ����');

 