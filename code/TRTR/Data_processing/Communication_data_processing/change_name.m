% 指定文件夹路径
folder = '/Users/smr/Desktop/硬件im-pl/pl_0401/code/label';

% 获取文件夹中的所有.mat文件
fileList = dir(fullfile(folder, '*.mat'));

% 循环处理每个文件
for i = 1:numel(fileList)
    % 读取MAT文件
    filePath = fullfile(folder, fileList(i).name);
    data = load(filePath);
    
    % 获取MAT文件中的所有变量名
    varNames = fieldnames(data);
    
    % 循环处理每个变量
    for j = 1:numel(varNames)
        % 获取原始变量名
        oldVarName = varNames{j};
        
        % 根据需要修改变量名
        newVarName = ['label']; % 这里以添加前缀"new_"为例
        
        % 重命名变量
        data.(newVarName) = data.(oldVarName);
        data = rmfield(data, oldVarName);
    end
    
    % 保存修改后的MAT文件
    save(filePath, '-struct', 'data');
end