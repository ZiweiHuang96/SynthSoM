clear
clc

load detect_results.mat

detect_results_real = cell(1,1500);
for i = 1:length(detect_results)
    for j = 1:size(detect_results{1,i},1)
        x_c = detect_results{1,i}(j,2);
        y_c = detect_results{1,i}(j,3);
        w = detect_results{1,i}(j,4);
        h = detect_results{1,i}(j,5);
        x1 = (x_c-w/2)*1920;
        x2 = (x_c+w/2)*1920;
        y1 = (y_c-h/2)*1080;
        y2 = (y_c+h/2)*1080;
        detect_results_real{1,i}(j,1) = x1;
        detect_results_real{1,i}(j,2) = y1;
        detect_results_real{1,i}(j,3) = x2;
        detect_results_real{1,i}(j,4) = y2;
    end
end

save detect_results_real.mat detect_results_real
