clear
clc

load detect_results.mat
load height_results.mat

% 确定一张图片中最大楼房数目
building_num_max = 0;
for i = 1:length(height_results)
    a = size(height_results{1,i},1);
    if a > building_num_max
        building_num_max = a;
    end
end

input_times = cell(1,1500);
for i = 1:length(input_times)
    input_times{1,i} = zeros(3,building_num_max);
end
for i = 1:length(height_results)
    for j = 1:length(height_results{1,i})
        input_times{1,i}(1,j) = height_results{1,i}(j,1); % 楼房高度
        input_times{1,i}(2,j) = detect_results{1,i}(j,2);% 识别框中心x0
        input_times{1,i}(3,j) = detect_results{1,i}(j,3);% 识别框中心y0
    end
end
save input_times.mat input_times