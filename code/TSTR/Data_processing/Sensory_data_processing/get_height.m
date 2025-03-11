clear
clc

load detect_results_real.mat

% Processing vertex coordinates
for i = 1:length(detect_results_real)
    for j = 1:size(detect_results_real{1,i},1)
        for k = 1:size(detect_results_real{1,i},2)
            detect_results_real{1,i}(j,k) = round(detect_results_real{1,i}(j,k));
            if detect_results_real{1,i}(j,k)==0
                detect_results_real{1,i}(j,k) = 1;
            elseif detect_results_real{1,i}(j,k)>1920
                detect_results_real{1,i}(j,k)=1920;
            end
        end
    end
end


path = 'D:\sensing_simu_hard\Trolley2\distancetxt\';
fileFolder=fullfile('D:\sensing_simu_hard\Trolley2\distancetxt\');
dirOutput=dir(fullfile(fileFolder,'*'));
fileNames={dirOutput.name};
fileNames_distance = cell(1,1500);
fileNames_distance = fileNames(3:1502);

% Create an empty cell to store building height result
height_results = cell(1,1500);

for i = 1 : length(fileNames_distance)
    i
    distance_filename = fileNames_distance{1,i};
    % Gets the txt file label for distance
    file_num = split(distance_filename,'_');
    file_num = file_num{1,1};
    file_num = str2num(file_num);
    
    filepath = [path,distance_filename];
    % Read the distance file data
    data_distance = importdata(filepath);
    % Gets the height of the building in the distance file
    height_single = get_height_single(data_distance,detect_results_real{1,file_num});
    height_results{1,file_num} = height_single;
end
save height_results.mat height_results

function height_single = get_height_single(data_distance,detect_results)

    % detect_results: n*4，n is the number of targets,x1,y1,x2,y2
    for i = 1 : size(detect_results,1)
        x1 = detect_results(i,1);
        y1 = detect_results(i,2);
        x2 = detect_results(i,3);
        y2 = detect_results(i,4);
        building_array = data_distance([y1:y2],[x1:x2]);
        height = min(min(building_array));
        height_single(i,1) = height;
    end
     
end