clear
load CIR_measurement_cell_zhilian.mat

sum = 0;
for i = 1:length(CIR_measurement_zhilian)
    sum = sum + abs(CIR_measurement_zhilian{i})^2;
end
pl_tx = 10 * log10(sum / length(CIR_measurement_zhilian))
