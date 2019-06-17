pic_path = 'att_faces/s';
pic_shape = [112,92]; % 图片的像素尺寸
PCA_num = 400;  %选取主成分的个数
% 构造标准形式数据集
dataset = zeros([400,pic_shape(1)*pic_shape(2)+1]);
for i=1:40
    temp_path = [pic_path,num2str(i),'/'];
    for j=1:10
        pic = imread([temp_path,num2str(j),'.pgm']);
        temp_data = reshape(pic,1,pic_shape(1)*pic_shape(2));
        dataset((i-1)*10+j,:)=[temp_data,i];
    end
end
train_x = dataset(1:400,1:end-1);
train_y = dataset(1:400,end);
%求协方差矩阵
feature_mean = mean(train_x,1);
train_x_norl = train_x - feature_mean;
big_Fai = train_x_norl'*train_x_norl;
big_Fai = big_Fai * 1/400.0;

[bigvec,bigval] = eig(big_Fai); % vec的列向量是特征向量
bigval = diag(bigval);
[sort_val,index] = sort(bigval,'descend');
sort_big_vec = bigvec(:,index);

% % 显示前PCA_num个特征脸
% for p=1:PCA_num
%     PCA_pic = 1/sqrt(sort_val(p))* reshape(sort_big_vec(:,p),pic_shape(1),pic_shape(2));
%     subplot(5,5,p);
%     imshow(PCA_pic,[]);
% end
% 显示PCA降维后的人脸图像-重建
new_axis_data = train_x_norl * sort_big_vec(:,1:PCA_num); 
fuyuan = zeros(size(train_x,2),1);
for f=1:size(new_axis_data,2)
    fuyuan = fuyuan + 1/sqrt(sort_val(f)) * new_axis_data(1,f)*sort_big_vec(:,f);
end
pic_fuyuan = reshape(fuyuan,pic_shape(1),pic_shape(2));
figure
subplot(1,2,1);imshow(reshape(train_x(1,:),pic_shape(1),pic_shape(2)),[]);
subplot(1,2,2);imshow(pic_fuyuan,[]);
