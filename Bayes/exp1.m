%%%%%%%%%%%%--��ȡ����--%%%%%%%%%%%%%%%%%
clc;clear;
H = 20;%�ֳ�10��С����
load('GIRLdata.mat');
f1 = [min(GIRLdatas(:,1)),max(GIRLdatas(:,1))];
f2 = [min(GIRLdatas(:,2)),max(GIRLdatas(:,2))];
fmin = floor(min(f1(1,1),f2(1,1)));
fmax = ceil(max(f1(1,2),f2(1,2)));
n = (fmax-fmin)/H;%���
p1 = GIRLdatas(1:500,1:2);
p2 = GIRLdatas(501:1000,1:2);
% %%%%%%%%%%%%%--Ƶ�ʷֲ�ֱ��ͼ--%%%%%%%%%%%%%%%%%%%%
static1 = zeros(H,H);
static2 = zeros(H,H);
for i=1:500
    hang1 = ceil((p1(i,1)-fmin)/n);
    hang2 = ceil((p2(i,1)-fmin)/n);
    lie1 = ceil((p1(i,2)-fmin)/n);
    lie2 = ceil((p2(i,2)-fmin)/n);
    static1(hang1,lie1) = static1(hang1,lie1)+1;
    static2(hang2,lie2) = static2(hang2,lie2)+1;
end
static1 = static1./(500*H*H);
static2 = static2./(500*H*H);
figure(1)
subplot(2,3,1)
bar3(static1,0.4);
hold on
bar3(static2,0.4);
title('Ƶ�ʷֲ�ֱ��ͼ');
% %%%%%%%%%%%%%%%---һάparzon��----%%%%%%%%%%%%%%%%%%%%
% figure(2)
% [f,p3] = Parzen(p1(:,1),1,fmin,fmax,1,'Gaosi');% ���� ���� ά��
% plot(f,p3)
% %%%%%%%%%%%%%%%---��άparzon��----%%%%%%%%%%%%
subplot(2,3,2)
[f1,p31] = Parzen(p1,3,fmin,fmax,2,'Junyun');% ���� ����  ά��
bar3(p31,0.4);
hold on;
[f2,p32] = Parzen(p2,3,fmin,fmax,2,'Junyun');% ���� ����  ά��
bar3(p32,0.4);
title('parzon��-���ȴ�');

subplot(2,3,3)
[f1,p33] = Parzen(p1,1,fmin,fmax,2,'Gaosi');% ���� ����  ά��
bar3(p33,0.4);
hold on;
[f2,p34] = Parzen(p2,1,fmin,fmax,2,'Gaosi');% ���� ����  ά��
bar3(p34,0.4);
title('parzon��-��˹��');
% %%%%%%%%%%%%%%---�����Ȼ����+���Լ�����---%%%%%%%%%%%%%%%%%%%%%%%%%%
u1 = mean(p1);
u2 = mean(p2);
delt1 = 1/(length(p1)-1)* ((p1-u1)'*(p1-u1));
delt2 = 1/(length(p2)-1)* ((p2-u2)'*(p2-u2));
p_class1 = length(p1)/(length(p1)+length(p2));%����������
test_result = zeros(length(GIRLdatatest),1);
for i=1:length(GIRLdatatest)
    pc1 = mvnpdf(GIRLdatatest(i,1:2),u1,delt1) * p_class1;
    pc2 = mvnpdf(GIRLdatatest(i,1:2),u2,delt2) * (1-p_class1);
    if(pc1>pc2)
        GIRLdatatest(i,3)=1;
    else
        GIRLdatatest(i,3)=0;
    end
end
subplot(2,3,5)
scatter(GIRLdatatest(:,1),GIRLdatatest(:,2),'filled','cdata',GIRLdatatest(:,3)+1);
%%%%%%%%%%%%%%%%%%-----����ƽ��-------%%%%%%%%%%%%%%%%%%%
x1 = [fmin:0.1:fmax]';
n = size(x1,1);
X =zeros(n,1);
d1 = det(delt1);
d2 = det(delt2);
syms x2 y;
for i=1:n
    x=[x1(i,1),x2];
    y = (x-u1)*delt1*(x-u1)'-(x-u2)*delt2*(x-u2)'+log(d1/d2);
    a = solve(y,x2);
    if size(a,1)~=0
        X(i,1)=a(2,1);
    end
end
hold on;
plot(x1,X);
%%%%%%%%%%%%%%ֻ��ͼ�������¼���%%%%%%%%%%%%%%%%%%%%%%
% figure(1)
% subplot(2,3,1)
% bar3(static1,0.4);
% hold on
% bar3(static2,0.4);
% title('Ƶ�ʷֲ�ֱ��ͼ');%%%%%%%1
% subplot(2,3,2)
% bar3(p31,0.4);
% hold on;
% bar3(p32,0.4);
% title('parzon��-���ȴ�');
% 
% subplot(2,3,3)
% bar3(p33,0.4);
% hold on;
% bar3(p34,0.4);
% title('parzon��-��˹��');%%%%%%%%%%%%%23
% subplot(2,3,5)
% scatter(GIRLdatatest(:,1),GIRLdatatest(:,2),10,'filled','cdata',GIRLdatatest(:,3)+1);
% hold on;
% plot(x1,X);%%%%%%%%%%%%%4
% set(gca,'YLim',[0 13]);%y���������ʾ��Χ