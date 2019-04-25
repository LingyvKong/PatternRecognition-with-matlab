function [f,a]=Parzen(x,h,fmin,fmax,nd,kernal)  
%input: 数据 窗宽 最小值 最大值 数据维度 核函数
%output：横坐标 纵坐标
nn = 20;
if nd==1  %一维数据（二维图像）
    f = linspace(fmin,fmax,nn);
    b=0;
    a = zeros(nn,1);
    N = length(x);
    for i=1:nn
        for j=1:N
            if strcmpi(kernal,'Gaosi')==1
                q= exp(((f(i)-x(j))/h).^2/(-2))/sqrt(2*pi);
            elseif strcmpi(kernal,'Junyun')==1
                if abs((x(j)-f(i))/h) <= 1/2   %方窗
                    q=1;
                else
                    q=0;
                end
            end
            b= q+ b;
        end
        a(i)=b;
        b=0;
    end
    a(i)=a(i)./(N*h);
elseif nd==2
    N = length(x);
    f = linspace(fmin,fmax,nn);
    b=0;
    a = zeros(nn,nn);
    for i=1:nn
        for k=1:nn
            for j=1:N
                if strcmpi(kernal,'Junyun')==1
                    if (abs(x(j,1)-f(i))/h <= 1/2) && (abs(x(j,2)-f(k))/h <= 1/2)  %方窗
                        q=1;
                    else
                        q=0;
                    end
                elseif strcmpi(kernal,'Gaosi')==1
                    q= exp( (((x(j,1)-f(i))/h).^2 + ((x(j,2)-f(k))/h).^2)/(-2))/sqrt(2*pi);
                end
                b= q+ b;
            end
            a(i,k)=b;
            b=0;
        end
    end
    a(i)=a(i)./(N*h*h);
end
end


