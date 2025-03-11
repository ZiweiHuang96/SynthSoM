clear
clc

TSTR = zeros(1,176);
TRTR = zeros(1,176);
label = zeros(1,176);
x = [1:176];

accuracy_TSTR = zeros(1,176);
accuracy_TRTR = zeros(1,176);

label_filepath = 'E:\Desktop\Code_PT\TSTR\Network_TSTR\label_test\';
TRTR_output_filepath = 'E:\Desktop\Code_PT\TRTR\Network_TRTR\test_output\';
TSTR_output_filepath = 'E:\Desktop\Code_PT\TSTR\Network_TSTR\output_test\';

for i = 1:176
    filename_TRTR = [TRTR_output_filepath,'output_test',num2str(i),'.mat'];
    filename_TSTR = [TSTR_output_filepath,'output_test',num2str(i),'.mat'];
    filename_label = [label_filepath,'label_test',num2str(i),'.mat'];
    load(filename_TRTR)
    TRTR(i) = output_test;
    load(filename_TSTR)
    TSTR(i) = output_test;
    load(filename_label)
    label(i) = label_test;

    accuracy_TRTR(i) = 1 - abs(TRTR(i)-label(i))/label(i);
    accuracy_TSTR(i) = 1 - abs(TSTR(i)-label(i))/label(i);
end

values1 = spcrv([[x(1) x x(176)];[accuracy_TSTR(1) accuracy_TSTR accuracy_TSTR(176)]],4);
values2 = spcrv([[x(1) x x(176)];[accuracy_TRTR(1) accuracy_TRTR accuracy_TRTR(176)]],4);

plot(values1(1,:),values1(2,:),'o-','LineWidth',1,'MarkerSize',3)
hold on
plot(values2(1,:),values2(2,:),'d-','LineWidth',1,'MarkerSize',3)
grid on 
ylim([0.7,1])
xlim([0,176])
xlabel('Snapshot, $n$','FontSize',14,'FontName','Helvetica','Interpreter', 'latex');
ylabel('Prediction accuracy, $A$','FontSize',14,'FontName','Helvetica','Interpreter', 'latex');

lgd = legend('Train on synthetic, test on real (TSTR)','Train on real, test on real (TRTR)','FontSize', 14)
legend('Location', 'noutheast'); 

