% get height of buildings from detection result txt file by matching
% distance txt file

clear
clc
% Read the file name of all test results
fileFolder=fullfile('E:\Desktop\Code_PT\TSTR\Data_processing\Sensory_data_processing\yolov5-master\runs\detect\exp\labels\');
dirOutput=dir(fullfile(fileFolder,'*'));
fileNames={dirOutput.name}';
filenames = cell(1500,1);
filenames = fileNames(3:1502);

% Create an empty cell to save the detection result
detect_results = cell(1,1500);

% Read each txt file
for i = 1:length(filenames)
    filename_txt = filenames(i);
    filename_txt = filename_txt{1,1};
    filename_path = [fileFolder,filename_txt];
    file_num = split(filename_txt,'.');
    file_num = file_num{1,1};
    file_num = str2num(file_num);
    label = importdata(filename_path);
    detect_results{1,file_num} = label;
end
save detect_results.mat detect_results