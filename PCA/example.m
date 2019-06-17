train_x = [1 1;2 2;-1 -1;-2 -2];
PCA_num = 1;
%求协方差矩阵
feature_mean = mean(train_x,1);
train_x_norl = train_x - feature_mean;
Fai = zeros([size(train_x,2),size(train_x,2)]);
for k=1:size(train_x,1)
    Fai = Fai + train_x_norl(k,:)'* train_x_norl(k,:);
end
Fai = Fai * 1/size(train_x,1);
[vec,val] = eig(Fai);
val = diag(val);
[sort_val,index] = sort(val,'descend');
sort_vec = vec(index,:);
train_yM = sort_vec(1:PCA_num,:)*train_x' % 每一列为一个样本












