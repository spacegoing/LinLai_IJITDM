%% Data processing

%%%%%%%%%%%%%%%%%% Train Data %%%%%%%%%%%%%%%%%%
% read xlsx data
raw_data = xlsread('train.xlsx');
raw_X = raw_data(:,2:11)';
raw_Y = raw_data(:,12)';

% normalization
% the result is m by n (number of instances) matrix
[X,input_attrs] = mapminmax(raw_X);
[Y,output_attrs] = mapminmax(raw_Y);

%%%%%%%%%%%%%%%%%% Test Data %%%%%%%%%%%%%%%%%%%
% read xlsx data
raw_data_t = xlsread('train.xlsx');
raw_X_t = raw_data_t(:,2:11)';
raw_Y_t = raw_data_t(:,12)';

% normalization
% the result is m by n (number of instances) matrix
[X_t,input_attrs] = mapminmax(raw_X_t);
[Y_t,output_attrs] = mapminmax(raw_Y_t);


%% code for FNN (only available after release r2015a)

net = feedforwardnet([3,7,2]);
net.trainParam.showWindow = false;
net = train(net,X,Y);
Y_hat_fnn = net(X_t);
perf = perform(net,Y_hat_fnn,Y_t);


%% code for SVR (only available after release r2016a)

X_svm = X';
Y_svm = Y';

X_t_svm = X_t';
Y_t_svm = Y_t';

svm_Mdl = fitrlinear(X_svm,Y_svm);
Y_hat_svm = predict(svm_Mdl,X_t_svm);


%% code for RandomForest (only available after release r2016b)
X_rf = array2table(X_svm);
Y_rf = Y_svm;

X_t_rf = X_t_svm;
Y_t_rf = Y_t_svm;

rf_Mdl = fitrensemble(X_rf,Y,'CrossVal','on');
Y_hat_rf = predict(rf_Mdl,X_t_rf);

%% Save Results
Y_hat_fnn = Y_hat_fnn';
Y_t = Y_t';
save results Y_hat_fnn Y_hat_rf Y_hat_svm Y_t






