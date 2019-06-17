% 8:2分出训练集和测试集
train_x = [];
train_y = [];
for i=0:39
    for j=1:8
        train_x = [train_x; X_norl(i*10+j,:)];
        train_y = [train_y; Y(i*10+j,:)];
    end
end
test_x = [];
test_y = [];
for i=0:39
    for j=9:10
        test_x = [test_x; X_norl(i*10+j,:)];
        test_y = [test_y; Y(i*10+j,:)];
    end
end
new_axis_train = []; % 降维后的训练集
train_num = size(train_x,1);
for i = 1 : train_num
    new_axis_data = train_yM(:,1:PCA_num(3))' * train_x(i,:)';
    new_axis_train(i,:) =new_axis_data'; 
end
new_axis_test = []; % 降维后的测试集
test_num = size(test_x,1);
for i = 1 : test_num
    new_axis_data = train_yM(:,1:PCA_num(3))' * test_x(i,:)';
    new_axis_test(i,:) =new_axis_data'; 
end
test_result = zeros(size(test_y,1),1);
jvli = zeros(size(test_y,1),size(train_y,1));
for i=1:size(test_y,1)
    for j=1:size(train_y,1)
        jvli(i,j) = norm(new_axis_train(j,:) - new_axis_test(i,:))^2;        
    end
    [value ,index] = min(jvli(i,:)); 
    test_result(i) = train_y(index);
end
wrong_num = length(find((test_y-test_result) ~=0));
acc = (size(test_y,1)-wrong_num)/size(test_y,1);
fprintf('正确率为：%f\n',acc);