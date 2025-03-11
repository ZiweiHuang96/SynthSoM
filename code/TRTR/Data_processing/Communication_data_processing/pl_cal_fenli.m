clear
clc


label_path = 'E:\Desktop\Code_PT\TRTR\Data_processing\Communication_data_processing\label';
pl_tx = 26.7945;
%%
load time1-10_CIR.mat

% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:10
    len = length(CIR);
    sub_len = len / 10;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i)];
    save(filename,"pl")
end

%%
load time11-20_CIR.mat
% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:10
    len = length(CIR);
    sub_len = len / 10;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+10)];
    save(filename,"pl")
end

%%
load time21-30_CIR.mat

% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:10
    len = length(CIR);
    sub_len = len / 10;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+20)];
    save(filename,"pl")
end

%%
load time31-40_CIR.mat



% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:10
    len = length(CIR);
    sub_len = len / 10;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+30)];
    save(filename,"pl")
end

%%
load time41-50_CIR.mat

% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:10
    len = length(CIR);
    sub_len = len / 10;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+40)];
    save(filename,"pl")
end

%%
load time51-60_CIR.mat


% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:10
    len = length(CIR);
    sub_len = len / 10;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+50)];
    save(filename,"pl")
end

%%
load time61-70_CIR.mat


% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:10
    len = length(CIR);
    sub_len = len / 10;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+60)];
    save(filename,"pl")
end

%%
load time71-80_CIR.mat
% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:10
    len = length(CIR);
    sub_len = len / 10;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+70)];
    save(filename,"pl")
end

%%
load time81-90_CIR.mat

% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:10
    len = length(CIR);
    sub_len = len / 10;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+80)];
    save(filename,"pl")
end

%%
load time91-139_CIR.mat

% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:49
    len = length(CIR);
    sub_len = len / 49;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+90)];
    save(filename,"pl")
end

%%
load time140-188_CIR.mat


% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:49
    len = length(CIR);
    sub_len = len / 49;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+139)];
    save(filename,"pl")
end

%%
load time189-237_CIR.mat

% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:49
    len = length(CIR);
    sub_len = len / 49;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+188)];
    save(filename,"pl")
end

%%
load time238-287_CIR.mat


% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:50
    len = length(CIR);
    sub_len = len / 50;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+237)];
    save(filename,"pl")
end

%%
load time288-337_CIR.mat



% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:50
    len = length(CIR);
    sub_len = len / 50;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+287)];
    save(filename,"pl")
end

%%
load time338-387_CIR.mat


% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:50
    len = length(CIR);
    sub_len = len / 50;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+337)];
    save(filename,"pl")
end

%%
load time388-882_CIR.mat


% The pl data over a period of time is averaged over time, with the mean as the pl for the moment
for i = 1:495
    len = length(CIR);
    sub_len = len / 495;
    sum = 0;
    for j = fix(sub_len*(i-1) + 1)  : fix(sub_len*i)
        sum = sum + abs(CIR{j})^2;
    end
    pl_rx = 10 * log10 (sum / length(CIR));
    pl = pl_tx + 40 - pl_rx;
    filename = [label_path,'/label_time',num2str(i+387)];
    save(filename,"pl")
end


