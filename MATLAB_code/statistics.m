function [avg,med,standev,vari,minimum,maximum,range] = statistics(signal)

%avg
avg = mean(signal);
%MEdian
med = median(signal);
%Standard Deviation
standev = std(signal);
%Variance
vari = var(signal);
%min max
minimum = min(signal);
maximum = max(signal);
%Range
range = maximum-minimum;

