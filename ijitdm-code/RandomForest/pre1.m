%% �������ɭ�ֽ���ѵ����Ԥ��
%% ��ʼ��
clc
clear all;
close all;
addpath('./src')
addpath('./other')
format shortg

%% ����mex�ļ�
if strcmpi(computer,'PCWIN') || strcmpi(computer,'PCWIN64')
    compile_windows
else
    compile_linux
end

%% ���ݵ���
% X�� NxD 
% Y�� Nx1, N=������, D=����ά��

[data, ~, ~] = xlsread('��ý.xlsx'); % ��ȡ����

X = data(:,4:12); % ��������
Y = data(:,13);     % �������
[N,D] =size(X);

% ѵ������5/6*N�����Լ���1/6*N
num_train = ceil(5/6*N);
randvector = randperm(N);

X_trn = X(randvector(1:num_train),:);
Y_trn = Y(randvector(1:num_train));
X_tst = X(randvector(num_train+1:end),:);
Y_tst = Y(randvector(num_train+1:end));
nb_test = length(Y_tst);

%% ѵ��
num_trees = 100; % ��ľ����
model = regRF_train(X_trn,Y_trn,num_trees);
Y_hat = regRF_predict(X_tst,model);



%% Ԥ��
[pre_data, ~, ~] = xlsread('��ýpre.xlsx'); % ��ȡ����
X_pre = pre_data(:,4:12); % ��������
Y_hat_pre = regRF_predict(X_pre,model);

csvwrite('./prediction11.csv',Y_hat_pre ) 
