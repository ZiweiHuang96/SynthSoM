clear
clc

folderpath = 'E:\Desktop\Code_PT\TSTR\Dataset_TSTR\all\';
for i = 1:882
    filepath = [folderpath, 'time',num2str(i),'\input_time',num2str(i),'.mat'];
    load(filepath);
    
    
    name = 'value';
    eval([name,'=input_time',num2str(i)]);
    
    temp = zeros(3,18);
    for j = 1:size(value,1)
        for k = 1:size(value,2)
            temp(j,k) = value(j,k);
        end
    end
    name = ['input_time',num2str(i)];
    eval([name,'=temp']);
    save(filepath, name);
    
end
    