clear
clc

dataset_folder = 'E:\\Desktop\\Code_PT\\TRTR\\Dataset_TRTR';
sourceFolder = 'E:\\Desktop\\Code_PT\\TRTR\\Data_processing\\Sensory_data_processing\\dataset_num'; 

mkdir([dataset_folder,'\\train']);
mkdir([dataset_folder,'\\val']);
mkdir([dataset_folder,'\\test']);

% Training set input
for i = 1:530
    folderName = sprintf([dataset_folder,'\\train\\time%d'], i);
    mkdir(folderName);
end


% Validation set input
for i = 531:706
    folderName = sprintf([dataset_folder,'\\val\\time%d'], i);
    mkdir(folderName);
end


% Testing set input
for i = 707:882
    folderName = sprintf([dataset_folder,'\\test\\time%d'], i);
    mkdir(folderName);
end


% move files
for i = 1:530
    sourceFile = fullfile(sourceFolder, sprintf('input_time%d.mat', i));
    targetFolder = fullfile([dataset_folder,'\\train\\'], sprintf('time%d', i)); 
    targetFile = fullfile(targetFolder, sprintf('input_time%d.mat', i));  
    movefile(sourceFile, targetFile);
end

for i = 531:706
    sourceFile = fullfile(sourceFolder, sprintf('input_time%d.mat', i)); 
    targetFolder = fullfile([dataset_folder,'\\val\\'], sprintf('time%d', i)); 
    targetFile = fullfile(targetFolder, sprintf('input_time%d.mat', i)); 
    movefile(sourceFile, targetFile);
end

for i = 707:882
    sourceFile = fullfile(sourceFolder, sprintf('input_time%d.mat', i)); 
    targetFolder = fullfile([dataset_folder,'\\test\\'], sprintf('time%d', i)); 
    targetFile = fullfile(targetFolder, sprintf('input_time%d.mat', i));
    movefile(sourceFile, targetFile);
end



