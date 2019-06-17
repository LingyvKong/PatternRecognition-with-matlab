ni = zeros(256,1); % 灰度为i的像素数 0-255
% I1=imread('pic2.png');
% grayI1 = I1;
I1=imread('pic1.png');
grayI1 = rgb2gray(I1);

imagesc(grayI1,[0,255])
outI = uint8(zeros(size(grayI1,1),size(grayI1,2)));
N = size(grayI1,1)*size(grayI1,2);
for i=1: size(grayI1,1)
    for j=1:size(grayI1,2)
        ni(grayI1(i,j))=ni(grayI1(i,j))+1;
    end
end
pi=ni/N;
deltaB = zeros(256,1);
for k=0:255
   mu1=0;
   mu2=0;
   w1=0;
   for t=0:k
       mu1 = mu1 + t*pi(t+1,1); %mu1 = mu1 + t*pi(t,1);
       w1 = w1+pi(t+1,1);
   end
   for t2=k+1:255
       mu2 = mu2 + t*pi(t2+1,1); %mu2 = mu2 + t2*pi(t2,1);
   end
   mu = mu1+mu2;
   w2 = 1-w1;
   mu1 = mu1/w1;
   mu2 = mu2/w2;
   deltaB(k+1,1)=w1*(mu1-mu)^2+w2*(mu2-mu)^2;
end
[value,index] = max(deltaB);
for i=1: size(grayI1,1)
    for j=1:size(grayI1,2)
        if(grayI1(i,j)>index)
            outI(i,j)=255;
        end
    end
end

subplot(2,2,1);imshow(uint8(grayI1));title('原始图片')
subplot(2,2,3);imshow(outI);title('Otsu分割后的二进制图片')
subplot(2,2,2);stem(0:255,ni);title('灰度分布')
filter=[1 1 1 1 1 %对高斯躁声算术均值滤波
1 1 1 1 1
1 1 1 1 1 
1 1 1 1 1];
filter=filter/25;
h=conv2(double(outI),filter);
subplot(2,2,4);imshow(h);title('5*5均值滤波后的结果')