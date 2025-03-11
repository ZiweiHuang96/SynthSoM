clear
clc

load input_times.mat

dataset_folder = 'E:\\Desktop\\Code_PT\\TSTR\\Dataset_TSTR';
% train_path = 'E:\\Desktop\\Code_PT\\TSTR\\Dataset_TSTR\\train\\';
% val_path = 'E:\\Desktop\\Code_PT\\TSTR\\Dataset_TSTR\\val\\';
% test_path = 'E:\\Desktop\\Code_PT\\TSTR\\Dataset_TSTR\\test\\';
all_path = 'E:\\Desktop\\Code_PT\\TSTR\\Dataset_TSTR\\all\\';

% % Training set input
% for i = 1:530
%     folderName = sprintf([dataset_folder,'\\train\\time%d'], i);
%     mkdir(folderName);
% end
% 
% 
% % Validation set input
% for i = 531:706
%     folderName = sprintf([dataset_folder,'\\val\\time%d'], i);
%     mkdir(folderName);
% end
% 
% 
% % Testing set input
% for i = 707:882
%     folderName = sprintf([dataset_folder,'\\test\\time%d'], i);
%     mkdir(folderName);
% end


% for i = 1:530 
%     file_path = [train_path,'time',num2str(i),'\','input_time',num2str(i),'.mat'];
%     temp = input_times{1,i};
%     name = ['input_time',num2str(i)];
%     eval([name,'=temp']);
%     save(file_path,name)
% end
% 
% for i = 531:706
%     file_path = [val_path,'time',num2str(i),'\','input_time',num2str(i),'.mat'];
%     temp = input_times{1,i};
%     name = ['input_time',num2str(i)];
%     eval([name,'=temp']);
%     save(file_path,name);
% end
% 
% for i = 707:882
%     file_path = [test_path,'time',num2str(i),'\','input_time',num2str(i),'.mat'];
%     temp = input_times{1,i};
%     name = ['input_time',num2str(i)];
%     eval([name,'=temp']);
%     save(file_path,name);
% end

for i = 1:882 
    time_path = [all_path,'time',num2str(i)];
    mkdir(time_path)
    file_path = [all_path,'time',num2str(i),'\','input_time',num2str(i),'.mat'];
    temp = input_times{1,i};
    name = ['input_time',num2str(i)];
    eval([name,'=temp']);
    save(file_path,name);
end