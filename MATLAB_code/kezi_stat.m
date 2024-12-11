files = dir('*.txt'); % select wokring folder
VarNames = ["Tengely","Átalag","Medián","Szórás","Variancia","Minimum","Maximum","Tartomány","Egyenes A+bx","Egyenes a+Bx","R^2","R^2 korrigált"];
axis = ["X","Y","Z"];

t_ref=[0,23];
y_ref=[45,45];
y_lim_upper=[63.4,63.4]; %
y_lim_lower=[26.6,26.6]; %
y_war_upper=[60,60]; %
y_war_lower=[30,30]; %

for i = 1:27
    %data = readtable(files(i).name,'Delimiter',{',', ';'}); %read data from file to matlab variable
    [time,calib,acc,gyro,mag,euler,linacc,grav] = LoadData(files(i).name); % Load the data into meaningfull variable names
    time = systime2sec(time); %convert system time in ms to s and remove the time offset
    time = max(time,0);
    time(time == 0) = NaN;
    
    cim = files(i).name(1:end-4) + " normalized Euler angles";
    
    normalized_angles = normalizeEulerAngles([euler.x, euler.y, euler.z]);
    %[time, normalized_angles(:,1),normalized_angles(:,2),normalized_angles(:,3)] = removeNaNs(time, normalized_angles(:,1),normalized_angles(:,2),normalized_angles(:,3));
    for j = 1:3
        [stat.avg(i,j),stat.med(i,j),stat.standev(i,j),stat.vari(i,j),stat.mini(i,j),stat.maxi(i,j),stat.range(i,j)] = statistics(normalized_angles(:,j));
        mdl     = fitlm(time,normalized_angles(:,j)+45);
        stat.a(i,j)    = mdl.Coefficients.Estimate(1);
        stat.b(i,j)    = mdl.Coefficients.Estimate(2);
        stat.R2O(i,j)  = mdl.Rsquared.Ordinary;
        stat.R2A(i,j)  = mdl.Rsquared.Adjusted;
    end
    %stat = table(axis',avg',med',standev',vari',mini',maxi',range',a',b',R2O',R2A','VariableNames',VarNames);
    %writetable(stat,[pwd '\kezifigures\' files(i).name(1:end-4) '.xls'])
    %stat_tbl(i,:) = stat;
    cat(i) = categorical(cellstr(files(i).name(1:end-4)));
    VarNames2 = ["Gyro calib","Mag calib","Acc calib","Sys calib"];
    %table(mean(calib.mag),mean(calib.gyro),mean(calib.acc),mean(calib.sys),'VariableNames',VarNames2);
    
    %writetable(table,[pwd '\kezifigures\' files(i).name(1:end-4) '.xls'],'Range','A5');
    fig = figure('Name',files(i).name(1:end-4) ,'NumberTitle','off');
    plot(time,normalized_angles(:,1)+45)%,time,normalized_angles(:,2),time,normalized_angles(:,3));
    %title(cim,'Interpreter','none');
    hold on
    plot(t_ref,y_ref,...
         '--',...
         'LineWidth',1,...
         'Color','black');
    
     plot(t_ref,y_lim_lower,...
         '--',...
         'LineWidth',1,...
         'Color','red');
     
     plot(t_ref,y_lim_upper,...
         '--',...
         'LineWidth',1,...
         'Color','red');
     
     plot(t_ref,y_war_upper,...
         '--',...
         'LineWidth',1,...
         'Color','#EDB120');
     
     plot(t_ref,y_war_lower,...
         '--',...
         'LineWidth',1,...
         'Color','#EDB120');
     plot(time(1:end-1),diff(normalized_angles(:,1)));
    grid on;
    grid minor;
    xlabel("Time [s]");
    ylabel("Euler angle [deg]");
    legend("Measured X angle","model","OK limit","OK limit","Warning","Warning"); %,'Location','southwest');
    legend('boxoff');
    xlim([0 40]);
    ylim([0 90]);
    %savefig(fig,[pwd '\kezifigures\' files(i).name(1:end-4) '_normalized Euler angles']);% '.png']);
    savefig(fig,[pwd '\kezifigures\' files(i).name(1:end-4) 'X_with_limits']);% '.png']);
    saveas(fig,[pwd '\kezifigures\' files(i).name(1:end-4) 'X_with_limits.png']);
end