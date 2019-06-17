pic_path = 'att_faces/s';
pic_shape = [112,92]; % ͼƬ�����سߴ�
PCA_num = [10,50,400];  %ѡȡ���ɷֵĸ���
% �����׼��ʽ���ݼ�
dataset = zeros([400,pic_shape(1)*pic_shape(2)+1]);
for i=1:40
    temp_path = [pic_path,num2str(i),'/'];
    for j=1:10
        pic = imread([temp_path,num2str(j),'.pgm']);
        temp_data = reshape(pic,1,pic_shape(1)*pic_shape(2));
        dataset((i-1)*10+j,:)=[temp_data,i];
    end
end
X = dataset(1:400,1:end-1);
Y = dataset(1:400,end);

%��Э�������
feature_mean = mean(X,1);
X_norl = X - feature_mean;
Fai = X_norl*X_norl';
Fai = Fai * 1/400.0;

[vec,val] = eig(Fai); % vec������������������
val = diag(val);
[sort_val,index] = sort(val,'descend');
sort_vec = vec(:,index);
train_yM = X_norl'* sort_vec; % ÿһ��Ϊһ������
for p=1:400
    train_yM(:,p) = 1/sqrt(sort_val(p)) * train_yM(:,p);
end
% ��ʾǰPCA_num��������
for p=1:25
    PCA_pic = reshape(train_yM(:,p),pic_shape(1),pic_shape(2));
    subplot(5,5,p);
    imshow(PCA_pic,[]);
end
figure
for n=1:3
    new_axis_data = train_yM(:,1:PCA_num(n))' * X_norl(11,:)';
    fuyuan = zeros(size(train_yM,1),1);
    for f=1:size(new_axis_data,1)
        fuyuan = fuyuan + 1/sqrt(sort_val(f)) * new_axis_data(f)*train_yM(:,f);
    end
    pic_fuyuan = reshape(fuyuan,pic_shape(1),pic_shape(2));
    subplot(2,2,n+1);imshow(pic_fuyuan,[]);title(PCA_num(n))
end
subplot(2,2,1);imshow(reshape(X(11,:),pic_shape(1),pic_shape(2)),[]);













