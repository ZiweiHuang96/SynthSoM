%% data sanitization

train_folderpath = 'E:\Desktop\Code_PT\TRTR\Dataset_TRTR\train\';
val_folderpath = 'E:\Desktop\Code_PT\TRTR\Dataset_TRTR\val\';
test_folderpath = 'E:\Desktop\Code_PT\TRTR\Dataset_TRTR\test\';

for i = 1:530
    filepath = [train_folderpath,'time',num2str(i),'\','input_time',num2str(i),'.mat'];
    data = load(filepath);
    varname = ['input_time',num2str(i)];
    input = data.(varname);
    for j = 1:length(input)
        if isnan(input(1,j))
            input(1,j)=0;
            input(2,j)=0;
            input(3,j)=0;
        end
    end
    eval([varname,'=input'])
    save(filepath,varname);
end



for i = 531:706
    filepath = [val_folderpath,'time',num2str(i),'\','input_time',num2str(i),'.mat'];
    data = load(filepath);
    varname = ['input_time',num2str(i)];
    input = data.(varname);
    for j = 1:length(input)
        if isnan(input(1,j))
            input(1,j)=0;
            input(2,j)=0;
            input(3,j)=0;
        end
    end
    eval([varname,'=input'])
    save(filepath,varname);
end

for i = 707:882
    filepath = [test_folderpath,'time',num2str(i),'\','input_time',num2str(i),'.mat'];
    data = load(filepath);
    varname = ['input_time',num2str(i)];
    input = data.(varname);
    for j = 1:length(input)
        if isnan(input(1,j))
            input(1,j)=0;
            input(2,j)=0;
            input(3,j)=0;
        end
    end
    eval([varname,'=input'])
    save(filepath,varname);
end

