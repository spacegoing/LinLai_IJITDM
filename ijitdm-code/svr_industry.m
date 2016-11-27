function [ no_sent_Y_hat, sent_Y_hat ] = svr_industry(industry_name)
%SVR_INDUSTRY Calculate one industry's stats
% Data processing

train_num = 309;

% read xlsx data
raw_data = xlsread(industry_name);

%%%%%%%%%%%%%%%%%% Train Data %%%%%%%%%%%%%%%%%%%
raw_sent_X = raw_data(1:train_num,2:11)';
raw_no_sent_X = raw_data(1:train_num,3:11)';
raw_Y = raw_data(1:train_num,12)';

% normalization
% the result is m by n (number of instances) matrix
[sent_X,sent_input_attrs] = mapminmax(raw_sent_X);
[no_sent_X,no_sent_input_attrs] = mapminmax(raw_no_sent_X);
[Y,output_attrs] = mapminmax(raw_Y);

sent_X = sent_X';
no_sent_X = no_sent_X';
Y=Y';

%%%%%%%%%%%%%%%%%% Test Data %%%%%%%%%%%%%%%%%%%
% read xlsx data
raw_sent_X_t = raw_data(train_num+1:end,2:11)';
raw_no_sent_X_t = raw_data(train_num+1:end,3:11)';
raw_Y_t = raw_data(train_num+1:end,12)';

% normalization
% the result is m by n (number of instances) matrix
[sent_X_t,sent_input_attrs_t] = mapminmax(raw_sent_X_t);
[no_sent_X_t,no_sent_input_attrs_t] = mapminmax(raw_no_sent_X_t);
[Y_t,output_attrs] = mapminmax(raw_Y_t);

sent_X_t = sent_X';
no_sent_X_t = no_sent_X';
Y_t=Y_t';

%% SVR

sent_Mdl = fitrlinear(sent_X,Y);
no_sent_Mdl = fitrlinear(no_sent_X,Y);

sent_Y_hat = predict(sent_Mdl,sent_X_t);
no_sent_Y_hat = predict(no_sent_Mdl,no_sent_X_t);


end

