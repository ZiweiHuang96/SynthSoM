dataset_folder = 'E:\Desktop\Code_PT\TSTR\Dataset_TSTR';
sourceFolder = 'E:\Desktop\Code_PT\TSTR\Data_processing\Communication_data_processing\pathloss_PKU'; 

% move files
for i = 1:530
    sourceFile = fullfile(sourceFolder, sprintf('label_time%d.mat', i));
    targetFolder = fullfile([dataset_folder,'/train/'], sprintf('time%d', i)); 
    targetFile = fullfile(targetFolder, sprintf('label_time%d.mat', i));  
    copyfile(sourceFile, targetFile);
end

for i = 531:706
    sourceFile = fullfile(sourceFolder, sprintf('label_time%d.mat', i)); 
    targetFolder = fullfile([dataset_folder,'/val/'], sprintf('time%d', i)); 
    targetFile = fullfile(targetFolder, sprintf('label_time%d.mat', i)); 
    copyfile(sourceFile, targetFile);
end

for i = 707:882
    sourceFile = fullfile(sourceFolder, sprintf('label_time%d.mat', i)); 
    targetFolder = fullfile([dataset_folder,'/test/'], sprintf('time%d', i)); 
    targetFile = fullfile(targetFolder, sprintf('label_time%d.mat', i));
    copyfile(sourceFile, targetFile);
end




