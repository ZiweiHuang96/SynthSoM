clear
clc


errorpath_TSTR = 'E:\Desktop\Code_PT\TSTR\Network_TSTR\error\';
errorpath_TRTR = 'E:\Desktop\Code_PT\TRTR\Network_TRTR\error\';
error_TSTR = zeros(1,176);
error_TRTR = zeros(1,176);
minTSTR = 100;
maxTSTR = 0;
minTRTR = 100;
maxTRTR = 0;


TRTR1 = 0;
TRTR2 = 0;
TRTR3 = 0;
TRTR4 = 0;
TRTR5 = 0;


TSTR1 = 0;
TSTR2 = 0;
TSTR3 = 0;
TSTR4 = 0;
TSTR5 = 0;



for i = 1:176
    filepath = [errorpath_TSTR,'error',num2str(i),'.mat'];
    load(filepath)
    if error<minTSTR
        minTSTR = error;
    end
    if error>maxTSTR
        maxTSTR = error;
    end
    if error>=0 && error<0.11
        TSTR1 = TSTR1 + 1;
    elseif error>=0.11 && error<0.14
        TSTR2 = TSTR2 + 1;
    elseif error>=0.14 && error<0.17
        TSTR3 = TSTR3 + 1;
    elseif error>=0.17 && error<0.20
        TSTR4 = TSTR4 + 1;
    elseif error>=0.20 && error<0.23
        TSTR5 = TSTR5 + 1;
    
    end
    
    error_TSTR(i) = error;
end
TSTR1 =TSTR1/176;
TSTR2 =TSTR2/176;
TSTR3 =TSTR3/176;
TSTR4 =TSTR4/176;
TSTR5 =TSTR5/176;



for i = 1:176
    filepath = [errorpath_TRTR,'error',num2str(i),'.mat'];
    load(filepath)
    if error<minTRTR
        minTRTR = error;
    end
    if error>maxTRTR
        maxTRTR = error;
    end
    if error>=0 && error<0.11
        TRTR1 = TRTR1 + 1;
    elseif error>=0.11 && error<0.14
        TRTR2 = TRTR2 + 1;
    elseif error>=0.14 && error<0.17
        TRTR3 = TRTR3 + 1;
    elseif error>=0.17 && error<0.20
        TRTR4 = TRTR4 + 1;
    elseif error>=0.20 && error<0.23
        TRTR5 = TRTR5 + 1;
    
    end
    error_TRTR(i) = error;
end
TRTR1 =TRTR1/176;
TRTR2 =TRTR2/176;
TRTR3 =TRTR3/176;
TRTR4 =TRTR4/176;
TRTR5 =TRTR5/176;

%% 汇总近似

TSTR = [TSTR1,TSTR2,TSTR3,TSTR4,TSTR5];
TSTR = round(TSTR, 2);
TSTR(1) = 1-TSTR(2)-TSTR(3)-TSTR(4)-TSTR(5);
TRTR = [TRTR1,TRTR2,TRTR3,TRTR4,TRTR5];
TRTR = round(TRTR, 2);
TRTR(3) = 1-TRTR(1)-TRTR(2)-TRTR(4)-TRTR(5);
%% Bar
b = bar(1:5,[TSTR',TRTR']);
hatchfill2(b(1),'cross','HatchAngle',45,'HatchDensity',40,'HatchColor','k');
hatchfill2(b(2),'single','HatchAngle',0,'HatchDensity',40,'HatchColor','k');
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')



set(gca,'xtick',[1:6]);
set(gca,'xticklabel',{'0~11%', '11%~14%','14%~17%','17%~20%','20%~23%'})
ylabel('Probability, $P_d$','FontSize',14,'FontName','Helvetica','Interpreter', 'latex');
xlabel('Prediction relative error, $P_e$','FontSize',14,'FontName','Helvetica','Interpreter', 'latex');
ylim([0 1])
grid on 
%legend('Train on Simulation Test on Real','Train on Real Test on Real','FontSize',16);

%leg = legend('Train on Simulation Test on Real','Train on Real Test on Real');
legendData = {'Train on synthetic, test on real (TSTR)','Train on real, test on real (TRTR)'};
[legend_h, object_h, plot_h, text_str] = legendflex(b, legendData, 'Padding', [2, 2, 10], 'FontSize', 12, 'Location', 'NorthEast');

% [legend_h, object_h, plot_h, text_str] = legendflex(b, legendData, 'Padding', [2, 2, 4], 'FontSize', 11, 'Location', 'NorthEast');
% object_h(1) is the first bar's text
% object_h(2) is the second bar's text
% object_h(3) is the first bar's patch
% object_h(4) is the second bar's patch
%
% Set the two patches within the legend
hatchfill2(object_h(3), 'cross','HatchAngle',45,'HatchDensity',10,'HatchColor','k');
hatchfill2(object_h(4), 'single','HatchAngle',0,'HatchDensity',10,'HatchColor','k');
