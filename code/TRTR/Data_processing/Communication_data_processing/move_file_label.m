dataset_folder = 'E:\Desktop\Code_PT\TRTR\Dataset_TRTR';
sourceFolder = 'E:\Desktop\Code_PT\TRTR\Data_processing\Communication_data_processing\label'; 

% move files
for i = 1:530
    sourceFile = fullfile(sourceFolder, sprintf('label_time%d.mat', i));
    targetFolder = fullfile([dataset_folder,'/train/'], sprintf('time%d', i)); 
    targetFile = fullfile(targetFolder, sprintf('label_time%d.mat', i));  
    movefile(sourceFile, targetFile);
end

for i = 531:706
    sourceFile = fullfile(sourceFolder, sprintf('label_time%d.mat', i)); 
    targetFolder = fullfile([dataset_folder,'/val/'], sprintf('time%d', i)); 
    targetFile = fullfile(targetFolder, sprintf('label_time%d.mat', i)); 
    movefile(sourceFile, targetFile);
end

for i = 707:882
    sourceFile = fullfile(sourceFolder, sprintf('label_time%d.mat', i)); 
    targetFolder = fullfile([dataset_folder,'/test/'], sprintf('time%d', i)); 
    targetFile = fullfile(targetFolder, sprintf('label_time%d.mat', i));
    movefile(sourceFile, targetFile);
end

% 更改变量名
train_foldername = 'E:\Desktop\Code_PT\TRTR\Dataset_TRTR\train\';
for i = 1:530
    filepath = [train_foldername,'time',num2str(i),'/','label_time',num2str(i),'.mat'];
    load(filepath)
    name = ['label_time',num2str(i)];
    eval([name,'=pl']) 
    save(filepath, name)
end

val_foldername = 'E:\Desktop\Code_PT\TRTR\Dataset_TRTR\val\';
for i = 531:706
    filepath = [val_foldername,'time',num2str(i),'/','label_time',num2str(i),'.mat'];
    load(filepath)
    name = ['label_time',num2str(i)];
    eval([name,'=pl']) 
    save(filepath, name)
end

test_foldername = 'E:\Desktop\Code_PT\TRTR\Dataset_TRTR\test\';
for i = 707:882
    filepath = [test_foldername,'time',num2str(i),'/','label_time',num2str(i),'.mat'];
    load(filepath)
    name = ['label_time',num2str(i)];
    eval([name,'=pl']) 
    save(filepath, name)
end



