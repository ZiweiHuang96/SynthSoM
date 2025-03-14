clear
clc

%% read txt file in batches
% get all the txt file names in the folder
filepath_name = 'E:\Desktop\Code_PT\TRTR\Data_processing\Sensory_data_processing\dataset_num';
fileFolder = fullfile(filepath_name);
diroutput = dir(fileFolder);
fileName = {diroutput.name}';
filenames = cell(882,1);
filenames = fileName(3:884); % All txt file names

% Read and store as mat file
for i = 1:length(filenames)
    file = [filepath_name,'/time_',num2str(i),'.txt'];
    data = importdata(file);
    input = zeros(3,18);
    k = 1;
    for j = 1:length(data)
        % The resolution is 1280*720, which is used for normalization
        % get distance
        distance = extractBefore(data{j},'m');
        distance = str2num(distance);
        % get center point
        nums = extractBetween(data{j}, '(', ')');
        parts = strsplit(nums{1}, ',');
        x1 = str2double(parts{1});
        y1 = str2double(parts{2});
        x2 = str2double(parts{3});
        y2 = str2double(parts{4});
        % normalize the center point position
        input(1,k) = distance;
        input(2,k) = (x1+x2)/2/1280;
        input(3,k) = (y1+y2)/2/720;
        k = k+1;
    end
    if k<19
        for m = k:18
            input(1,m) = 0;
            input(2,m) = 0;
            input(3,m) = 0;
        end
    end
    filepath = [filepath_name,'/input_time',num2str(i),'.mat'];
    save(filepath,"input")
end

% Modify variable name
rootname = [filepath_name,'/input_time'];
extension = '.mat'; 
for i = 1:882
    variable = ['input_time',int2str(i)]; 
    filename = [rootname,int2str(i),extension]; 
    load(filename); 
    eval(['input_time',num2str(i),'=','input',';']); 
    save(filename,variable); 
    clear input variable filename; 
end 

 
