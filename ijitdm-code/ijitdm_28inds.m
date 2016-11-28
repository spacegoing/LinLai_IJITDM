% Fix Random Seed
rng(0);

filenames={'交通运输.xlsx',
           '休闲服务.xlsx',
           '传媒.xlsx',
           '公用事业.xlsx',
           '农林牧渔.xlsx',
           '化工.xlsx',
           '医药生物.xlsx',
           '商业贸易.xlsx',
           '国防军工.xlsx',
           '家用电器.xlsx',
           '建筑材料.xlsx',
           '建筑装饰.xlsx',
           '房地产.xlsx',
           '有色金属.xlsx',
           '机械设备.xlsx',
           '汽车.xlsx',
           '电子.xlsx',
           '电气设备.xlsx',
           '纺织服装.xlsx',
           '综合.xlsx',
           '计算机.xlsx',
           '轻工制造.xlsx',
           '通信.xlsx',
           '采掘.xlsx',
           '钢铁.xlsx',
           '银行.xlsx',
           '非银金融.xlsx',
           '食品饮料.xlsx'};
num_files = length(filenames);

results = cell(num_files,3);
results = filenames(:,1);

for i=1:num_files
  [no_sent_Y_hat, sent_Y_hat] = svr_industry(['28_Industs/' filenames{i}]);
  results(i,2:3) = {no_sent_Y_hat, sent_Y_hat};
end

save filenames_results results
%%

for i=1:num_files
    raw_data = xlsread(['28_Industs/' filenames{i}]);
    A = isnan(raw_data);
    if any(A)
        disp(filenames{i});
    end
end






