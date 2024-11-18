clc
clear
%% load data
load('CIR_Tx_Car7_sub6_MIMO.mat') % CSI sub-6 GHz
load('CIR_Tx_Car7_28_MIMO.mat') % CSI 28 GHz
load('CIR_Tx_Car7_sub6_massiveMIMO.mat')
load('CIR_Tx_Car7_28_massiveMIMO.mat')


%% parameter setting
Mt=1; % Number of antennas at Tx
Mr=4; % Number of antennas at Rx
time_index=13; % Time sequence number
refrence_antenna=1;
tx_antenna=1;
s_start=1;
s_end=Mr;
s_step=1;
%% Compute1
CIR=cell(1,40);
for i=1:50
    CIR{i}=CIR_Tx_Car7_sub6_MIMO{i}(1,:);
end
cir=CIR;
h_start=cir{1,time_index}(1,refrence_antenna)*ones(Mr,1)'; % CSI between the antenna at Tx and the refrence antenna at Rx
h_start_end=zeros(1,Mr);
for i=1:Mr
    h_start_end(i)=cir{1,time_index}(tx_antenna,i); % CSI between the antenna at Tx and antennas at Rx
end
SCCF=abs(real(conj(h_start).*h_start_end./(sqrt(abs(h_start).^2.*abs(h_start_end).^2)))); % Spatial cross-correlation function
n=1;
x_axis=(0:s_end-s_start)*s_step;
sim_x_axis=x_axis(1:n:end);
sim_SCCF=SCCF(1:n:end);
RT_SCCF = spcrv([[sim_x_axis(1) sim_x_axis sim_x_axis(end)];[sim_SCCF(1) sim_SCCF sim_SCCF(end)]],3,2000);
plot(RT_SCCF(1,:),RT_SCCF(2,:),'-ro','MarkerIndices',1:40:length(RT_SCCF),'LineWidth',1.5);
hold on

%% Compute2
for i=1:50
    CIR{i}=CIR_Tx_Car7_28_MIMO{i}(1,:);
end
cir=CIR;
h_start=cir{1,time_index}(1,refrence_antenna)*ones(Mr,1)'; % CSI between the antenna at Tx and the refrence antenna at Rx
h_start_end=zeros(1,Mr);
for i=1:Mr
    h_start_end(i)=cir{1,time_index}(tx_antenna,i); % CSI between the antenna at Tx and antennas at Rx
end
SCCF=abs(real(conj(h_start).*h_start_end./(sqrt(abs(h_start).^2.*abs(h_start_end).^2)))); % Spatial cross-correlation function
% Simulate
n=1;
x_axis=(0:s_end-s_start)*s_step;
sim_x_axis=x_axis(1:n:end);
sim_SCCF=SCCF(1:n:end);
RT_SCCF = spcrv([[sim_x_axis(1) sim_x_axis sim_x_axis(end)];[sim_SCCF(1) sim_SCCF sim_SCCF(end)]],3,2000);
plot(RT_SCCF(1,:),RT_SCCF(2,:),'-bs','MarkerIndices',1:40:length(RT_SCCF),'LineWidth',1.5);
grid on
hold on

%% Compute3
for i=1:50
    CIR{i}=CIR_Tx_Car7_sub6_massiveMIMO{i}(1,:);
end
cir=CIR;
h_start=cir{1,time_index}(1,refrence_antenna)*ones(Mr,1)'; % CSI between the antenna at Tx and the refrence antenna at Rx
h_start_end=zeros(1,Mr);
for i=1:Mr
    h_start_end(i)=cir{1,time_index}(tx_antenna,i); % CSI between the antenna at Tx and antennas at Rx
end
SCCF=abs(real(conj(h_start).*h_start_end./(sqrt(abs(h_start).^2.*abs(h_start_end).^2)))); % Spatial cross-correlation function
% Simulate
n=1;
x_axis=(0:s_end-s_start)*s_step;
sim_x_axis=x_axis(1:n:end);
sim_SCCF=SCCF(1:n:end);
RT_SCCF = spcrv([[sim_x_axis(1) sim_x_axis sim_x_axis(end)];[sim_SCCF(1) sim_SCCF sim_SCCF(end)]],3,2000);
plot(RT_SCCF(1,:),RT_SCCF(2,:),'-m^','MarkerIndices',1:40:length(RT_SCCF),'LineWidth',1.5);
grid on
hold on

%% Compute4
for i=1:50
    CIR{i}=CIR_Tx_Car7_28_massiveMIMO{i}(1,:);
end
cir=CIR;
h_start=cir{1,time_index}(1,refrence_antenna)*ones(Mr,1)'; % CSI between the antenna at Tx and the refrence antenna at Rx
h_start_end=zeros(1,Mr);
for i=1:Mr
    h_start_end(i)=cir{1,time_index}(tx_antenna,i); % CSI between the antenna at Tx and antennas at Rx
end
SCCF=abs(real(conj(h_start).*h_start_end./(sqrt(abs(h_start).^2.*abs(h_start_end).^2)))); % Spatial cross-correlation function
% Simulate
n=1;
x_axis=(0:s_end-s_start)*s_step;
sim_x_axis=x_axis(1:n:end);
sim_SCCF=SCCF(1:n:end);
RT_SCCF = spcrv([[sim_x_axis(1) sim_x_axis sim_x_axis(end)];[sim_SCCF(1) sim_SCCF sim_SCCF(end)]],3,2000);
plot(RT_SCCF(1,:),RT_SCCF(2,:),'-g>','MarkerIndices',1:40:length(RT_SCCF),'LineWidth',1.5);
grid on
hold on

legend('Sub-6 GHz, MIMO','mmWave, MIMO','Sub-6 GHz, massive MIMO','mmWave, massive MIMO','Fontsize',13,'location','SouthWest');
xlabel('Normalized antenna spacing, \delta_R/\lambda','Interpreter','tex');
ylabel('SCCF, \it{R}', 'Interpreter', 'tex');
xlim([0 2]);
ylim([0.3 1]);