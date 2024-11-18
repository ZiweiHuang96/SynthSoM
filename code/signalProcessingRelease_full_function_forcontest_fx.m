%%
% Project Name: ChatBot System
%     File Name: signalProcessing
%     Author: Weibo(Weber) Wen, Peking University
%     Contact: iweber.wen@gmail.com
%     Created: 2023-05-13
%     Last Modified: 2024-06-15
%       
%     Copyright Notice:
%     This code is licensed under the MIT License.
% 
%     Description:
%     
% 
%     Notes:
%     - 
%     - For academic research purposes only.
% 
%     Version History:
%     1.0 
%     1.1
%     1.2:updated by zhangruide增添了绘制rpm的功能，同时也可以对IQ波形进行重命名
%     1.3:更新了文件名的存储方法，可存储设备类型和名称
%%    
clear;
clc;
close all;
clear all;
set(groot,'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');

%
IF_PLOT = "off";        % "off" or "on"
IF_EXPORT = 1;
%输入设备的类型和编号
equip_type="Car";%%RSF或Car
equip_num="5";
folder_export = equip_type+"_"+equip_num+"_data";
%mkdir(folder_export);

% Folder including a group of IQwaveform.csv
abs_folder="C:\Data\WF\fenchaIQ\IQ_CAR5\"%%绝对路径,就是IQWAVE的存放位置，记得加一个反斜杠，像这个这样
folder = abs_folder;%%确认是哪个设备的
file_list_all = dir(fullfile(folder,'*.csv'));
disp(struct2table(file_list_all));

for i = 1:numel(file_list_all)
    file_list_all(i).tag = cell2mat(textscan(file_list_all(i).name,"IQWaveform_Time%f",'Delimiter','_'));
end



%%

nTx = 4;                % Number of Tx
nRx = 3;                % Number of Rx
fs = 1/0.000000005;     % Sampling rate of baseband
Nr = 1000;              % Samples per chirp
Nd = 101;               % Chirps per sweep

M = nTx*nRx;            % Number of Element array

file_list_all = reshape(file_list_all,M,[]).'; % classify by group

mkdir(folder+ folder_export +"\rangeDopplerMapFigure");
mkdir(folder+ folder_export +"\rangeAngleMapFigure");
mkdir(folder+ folder_export +"\CFAR");
mkdir(folder + folder_export + "\radarPoint");
mkdir(folder + folder_export + "\radarPointFigure");
mkdir(folder + folder_export + "\rangeDopplerMap");
mkdir(folder + folder_export + "\rangePowerMap");
mkdir(folder + folder_export + "\formatted_IQwave");
mkdir(folder + folder_export + "\rangeAngleMap");
%%
for frame = 1:size(file_list_all,1)

fprintf("Processing: %d of %d\n",frame,size(file_list_all,1));

file_list = file_list_all(frame,:);
time=file_list(1).tag;%%读取时间
snapshot=20*time+1;%%确定帧数,比赛场景为0.05s为一帧,起始是第一帧，要加一
%% 更改输出图片的文件名为Car/RSF_xx_snapshot_x.png
%fig_name= equip_type+ "_" + equip_num +"_snapshot_" +num2str(snapshot);
fig_name= "snapshot_" +num2str(snapshot);
%rdm_figname="snapshot_"+num2str(snapshot)+"_time_" + num2str(time,'%.2f');
I = zeros(M,Nr,Nd);     % 
Q = zeros(M,Nr,Nd);     %


for i = 1:nTx
    for j = 1:nRx

        idx = (i-1)*nRx+j;
        % 获取当前文件的完整路径
        file_path = [file_list(idx).folder '\' file_list(idx).name];
        %读取原文件名
        file_name=file_list(idx).name;
        %% 更改.csv的文件名为Car/RSF_xx_snapshot_xxx_time_xxx_tx_x_Rx_x.csv
        % 构建新的文件名
       pattern = 'Tx(\d+)_Rx(\d+)\.csv';
        tokens = regexp(file_path, pattern, 'tokens');
   
        tokens = tokens{1}; % 提取出第一个匹配
        txNumber = tokens{1};
        rxNumber = tokens{2};
%         newFileName = equip_type+"_"+equip_num+"_snapshot_"+num2str(snapshot)+"_time_" + num2str(time,'%.2f')...
%         +"_Tx_"+num2str(txNumber)+"_Rx_"+num2str(rxNumber)+".csv";
        newFileName = equip_type+"_"+equip_num+"_"+"snapshot_"+num2str(snapshot)+"_time_" + num2str(time,'%.2f')...
        +"_Tx_"+num2str(txNumber)+"_Rx_"+num2str(rxNumber)+".csv";
        % 构建目标文件的完整路径
        destDir=folder + folder_export + "\formatted_IQwave";
        destFile = fullfile(destDir, newFileName);
        % 复制文件到目标目录，并重命名
        copyfile(file_path, destFile);
        % 显示复制成功的消息
        %fprintf('文件 %s 已复制到 %s 并重命名为 %s\n', file_path, destDir, newFileName);

        temp = readmatrix(file_path,"Range",[5 3 Nr*Nd+4 3]);
        I(idx,:,:) = reshape(temp,[1,Nr,Nd]);
        
        temp = readmatrix(file_path,"Range",[5 4 Nr*Nd+4 4]);
        Q(idx,:,:) = reshape(temp,[1,Nr,Nd]);
    
    end
end

Z = I + 1j*Q;

%% Range-Dopper Map Processing

rdm = zeros(M,Nr/2,Nd);
pvr = zeros(M,Nr/2,1);

for i = 1:M
    sig_fft_rd = fft2(squeeze(Z(i,:,:)),Nr,Nd);
    sig_fft_rd = sig_fft_rd(1:Nr/2,:);
    
    rdm(i,:,:) = abs(sig_fft_rd);
    pvr(i,:,:) = sum(abs(sig_fft_rd),2);

end

rdm_db = 10*log10(rdm);
pvr_db = 10*log10(pvr);

max_range = 74.9;
max_doppler = 23.71; 
doppler_axis = linspace(max_doppler,-max_doppler,Nd);
range_axis = linspace(0,max_range,Nr/2);

f = figure('visible',IF_PLOT);
% figure('visible','off');%%不弹窗
rdm_disp = zeros(Nr/2,Nd);
for i = 1:M
    rdm_disp = rdm_disp + squeeze(rdm_db(i,:,:));
end
rdm_disp = fftshift(rdm_disp/M,2);

imagesc([max(doppler_axis) min(doppler_axis) ], ...
    [min(range_axis) max(range_axis)], ...
    rdm_disp);
%imagesc(RDM);
%xlim([0,max(freqParams)+1000]); % Frequenvy Domain
%ylim([0 9]);
xlabel('Doppler Velocity (m/s)','FontSize',12);
ylabel('Range (m)','FontSize',12);
title('Range-Doppler Map','FontSize',14,'FontWeight','bold');
view(0,-90);
clim([-85 -25]);
cb = colorbar;
cb.Label.String = "PSD";
cb.Label.Interpreter = 'latex';
cb.TickLabelInterpreter = 'latex';
colormap hot;
if IF_EXPORT
    set(f, 'PaperUnits', 'inches');
    %     x_width=16*1920/2400;y_width=9*1920/2400;
    %     set(f, 'PaperPosition', [0 0 x_width y_width]); %num2str(frame)
    path = folder+ folder_export +"\rangeDopplerMapFigure\"+equip_type+"_"+equip_num+"_"+"rdm" +"_"+ fig_name + ".png";
    %path = folder+ folder_export +"\rangeDopplerMapFigure\" + rdm_figname + ".png";
    saveas(gcf,path);
end
%%二维的power图
f = figure('visible',IF_PLOT);
%%figure('visible','off');%%不弹窗
pvr_disp = zeros(1,Nr/2);
for i = 1:M
    pvr_disp = pvr_disp + squeeze(pvr_db(i,:));
end
pvr_disp= pvr_disp/M-100;
%pvr_disp= squeeze(pvr_db(1,:));
%%pvr_disp = fftshift(pvr_disp/M,2);
max_power = max(pvr_disp); 
min_power = min(pvr_disp);
% power_axis = linspace(0,max_power,Nd);
plot(range_axis,pvr_disp,'LineWidth',1.5);
% ylim([min_power max_power]);
ylim([-160 -120]);
%imagesc(RDM);
%xlim([0,max(freqParams)+1000]); % Frequenvy Domain
%ylim([0 9]);
xlabel('Range, $\Delta_{r}$ (m)','Interpreter','latex','FontSize',12);
ylabel('Power spectral density, $\Phi_{p}$ (dBm/MHz)','Interpreter','latex','FontSize',12);
%title('Range-Power Map','FontSize',14,'FontWeight','bold');
% view(0,-90);
% clim([-85 -25]);
% cb = colorbar;
% cb.Label.String = "PSD";
% cb.Label.Interpreter = 'latex';
% cb.TickLabelInterpreter = 'latex';
% colormap hot;
if IF_EXPORT
    set(f, 'PaperUnits', 'inches');
    %     x_width=16*1920/2400;y_width=9*1920/2400;
    %     set(f, 'PaperPosition', [0 0 x_width y_width]); %num2str(frame)
    %path = folder+ folder_export +"\rangePowerMap\rdm" + fig_name + ".png";
    path = folder+ folder_export +"\rangePowerMap\"+equip_type+"_"+equip_num +"_"+"rpm"+"_"+ fig_name + ".png";
    saveas(gcf,path);
end

%% Range-Angle Map Processing
nfft = M*8;
sig_fft_ra = zeros(nfft,Nr); 
for i = 1
    ra = squeeze(Z(:,:,i));
    sig_fft_ra(:,:) = sig_fft_ra(:,:) + fft2(ra,nfft,Nr);
end

sig_fft_ra = rot90(sig_fft_ra,3);
sig_fft_ra = sig_fft_ra(1:Nr/2,:);
sig_fft_ra = fftshift(sig_fft_ra,2);

ram = 10*log10(abs(sig_fft_ra));

f = figure('visible',IF_PLOT);
imagesc([-90 90], ...
    [min(range_axis) max(range_axis)], ...
    ram);
%imagesc(10*log10(abs(sig_fft_ra)));
xlabel('Phase (deg)','FontSize',14);
ylabel('Range (m)','FontSize',14);
title('Range-Angle Map','FontSize',14,'FontWeight','bold');
cb = colorbar;
cb.Label.String = "PSD";
cb.Label.Interpreter = 'latex';
cb.TickLabelInterpreter = 'latex';
colormap hot;
clim([-95 -20]);
view(180,90);
if IF_EXPORT
    set(f, 'PaperUnits', 'inches');
%     x_width=16*1920/2400;y_width=9*1920/2400;
%     set(f, 'PaperPosition', [0 0 x_width y_width]); %num2str(frame)
    path = folder+ folder_export +"\rangeAngleMapFigure\" +equip_type+"_"+equip_num+"_"+"ram"+"_"+ fig_name + ".png";
    saveas(gcf,path);
end


%% CFAR Processing

% Slide Window through the complete Range Doppler Map

% Select the number of Training Cells in both the dimensions.
Tr = 8; %8
Td = 4; %4

% Select the number of Guard Cells in both dimensions around the Cell
% under test (CUT) for accurate estimation
Gr = 8; %8
Gd = 8; %8

% Offset the threshold by SNR value in dB
offset = 15;

%Create a vector to store noise_level for each iteration on training cells
radius_doppler   = Td + Gd;  % no. of doppler cells on either side of CUT
radius_range     = Tr + Gr;  % no. of range cells on either side of CUT

Nrange_cells     = Nr/2 - 2*radius_doppler; % no. of range dimension cells
Ndoppler_cells   = Nd   - 2*radius_range;   % no. of doppler dim. cells

grid_size        = (2*Tr + 2*Gr + 1) * (2*Td + 2*Gd + 1);
Nguard_cut_cells = (2*Gr+1) * (2*Gd+1);     % no. guards + cell-under-test
Ntrain_cells     = grid_size - Nguard_cut_cells;  % no. of training cells

noise_level      = zeros(Nrange_cells, Ndoppler_cells);

cfar_in = rdm_disp;

cfar_signal = zeros(size(cfar_in));

r_min = radius_range + 1;
r_max = Nrange_cells - radius_range;

d_min = radius_doppler + 1;
d_max = Ndoppler_cells - radius_doppler;

for r = r_min : r_max
    for d = d_min : d_max
        cell_under_test = cfar_in(r, d);
        
        cell_count = 0;
        for delta_r = -radius_range : radius_range
            for delta_d = -radius_doppler : radius_doppler
                
                cr = r + delta_r;
                cd = d + delta_d;
                
                in_valid_range = (cr >= 1) && (cd >= 1) && (cr < Nrange_cells) && (cd < Ndoppler_cells);
                in_train_cell = abs(delta_r) > Gr || abs(delta_d) > Gd;
                
                if in_valid_range && in_train_cell
                    noise = db2pow(cfar_in(cr, cd));
                    noise_level(r, d) = noise_level(r, d) + noise;
                    cell_count = cell_count + 1;
                end
               
            end
        end

        % If the signal in the cell under test (CUT) exceeds the
        % threshold, we mark the cell as hot by setting it to 1.
        % We don't need to set it to zero, since the array
        % is already zeroed out.
        threshold = pow2db(noise_level(r, d) / cell_count) + offset;

        if (cell_under_test >= threshold)
            cfar_signal(r, d) = rdm_disp(r,d); % ... or set to 1
        end
        
    end
end

f = figure('visible',IF_PLOT);
imagesc([max(doppler_axis) min(doppler_axis)], ...
    [min(range_axis) max(range_axis)], ...
    cfar_signal);
%imagesc(cfar_signal);
xlabel('Doppler Velocity','FontSize',12);
ylabel('Range','FontSize',12);
title('CFAR Filtered RDM','FontSize',14,'FontWeight','bold');
cb = colorbar;
cb.Label.String = "PSD";
cb.Label.Interpreter = 'latex';
cb.TickLabelInterpreter = 'latex';
colormap hot;
clim([-60,0]);
view(0,-90);
if IF_EXPORT
    set(f, 'PaperUnits', 'inches');
%     x_width=16*1920/2400;y_width=9*1920/2400;
%     set(f, 'PaperPosition', [0 0 x_width y_width]); %num2str(frame)
    path = folder+ folder_export +"\CFAR\" +equip_type+"_"+equip_num+"_"+"CFAR"+"_"+ fig_name + ".png";
    saveas(gcf,path);
end


%% Point Cloud Processing
[p.Row,p.Col] = find(cfar_signal ~= 0); % in RDM
p.Val = diag(cfar_signal(p.Row,p.Col)); % indexing
p.Num = length(p.Val);

% pAngle = zeros(pNum,1);
% pAngle = deg2rad(pAngle);

p.Range = p.Row/(Nr/2)*max_range;
% pAngle_DBF
[R,I] = max(ram(p.Row,:)');
p.Phase_DBF = I/nfft*2*pi - pi; % Phase in -pi~pi
thes = -60;
p.Phase_DBF = p.Phase_DBF(find(p.Val>thes));
p.Range = p.Range(find(p.Val>thes));
p.Val = p.Val(find(p.Val>thes));
p.Angle = asin(p.Phase_DBF/pi); % Angle in -pi/2~pi/2


f = figure('visible',IF_PLOT);
ps = polarscatter(p.Angle + pi/2,p.Range,20,'filled');
ps.SizeData = 10;
ps.MarkerFaceColor = "r";%"#A32CC4";
ps.MarkerFaceAlpha = .5;
rlim([0,max_range])
rticklabels([]);
thetaticklabels([]);
grid off;

% mkdir(".\"+ folder_export +"\rangeDopplerMapFigure");
% mkdir(".\"+ folder_export +"\rangeAngleMapFigure");
% mkdir(".\"+ folder_export +"\CFAR");
if IF_EXPORT
    set(f, 'PaperUnits', 'inches');
%     x_width=16*1920/2400;y_width=9*1920/2400;
%     set(f, 'PaperPosition', [0 0 x_width y_width]); %num2str(frame)
    path = folder+ folder_export +"\radarPointFigure\" +equip_type+"_"+equip_num+"_"+"radarpoint"+"_"+ fig_name + ".png";
    saveas(gcf,path);
end
if IF_EXPORT
    % IQtensor = Z;
    % save(".\" + folder_export + "\IQtensor" + fig_name + ".mat","IQtensor");
    radarPoint = p;
    %save(folder + folder_export + "\radarPoint\radarPoint" + fig_name + ".mat","radarPoint");
    %save(folder + folder_export + "\radarPoint\" + fig_name + ".mat","radarPoint");
    save(folder + folder_export + "\radarPoint\" +equip_type+"_"+equip_num+"_"+"radarpoint"+"_"+ fig_name + ".mat","radarPoint");

    rangeDopplerMap = rdm_disp;
    save(folder + folder_export + "\rangeDopplerMap\" +equip_type+"_"+equip_num+"_"+"rdm"+"_"+ fig_name + ".mat","rangeDopplerMap");
    
    rangeAngleMap = ram;
    save(folder + folder_export + "\rangeAngleMap\" +equip_type+"_"+equip_num+"_"+"ram"+"_"+ fig_name + ".mat","rangeAngleMap");
end
end

fprintf("Complete");











