%% 利用随机森林进行训练和预测
%% 初始化
clc
clear all;
close all;
addpath('./src')
addpath('./other')
format shortg

%% 编译mex文件
if strcmpi(computer,'PCWIN') || strcmpi(computer,'PCWIN64')
    compile_windows
else
    compile_linux
end

%% 数据导入
% X： NxD 
% Y： Nx1, N=样本数, D=特征维数

[data, ~, ~] = xlsread('传媒.xlsx'); % 读取数据

X = data(:,4:12); % 特征数据
Y = data(:,13);     % 输出数据
[N,D] =size(X);

% 训练集：5/6*N；测试集：1/6*N
num_train = ceil(5/6*N);
randvector = randperm(N);

X_trn = X(randvector(1:num_train),:);
Y_trn = Y(randvector(1:num_train));
X_tst = X(randvector(num_train+1:end),:);
Y_tst = Y(randvector(num_train+1:end));
nb_test = length(Y_tst);

%% 训练
num_trees = 100; % 树木个数
model = regRF_train(X_trn,Y_trn,num_trees);
Y_hat = regRF_predict(X_tst,model);



%% 预测
[pre_data, ~, ~] = xlsread('传媒pre.xlsx'); % 读取数据
X_pre = pre_data(:,4:12); % 特征数据
Y_hat_pre = regRF_predict(X_pre,model);

csvwrite('./prediction11.csv',Y_hat_pre ) 
