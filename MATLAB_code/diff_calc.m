files = dir('*.txt'); % select wokring folder
VarNames = ["Tengely","Átalag","Medián","Szórás","Variancia","Minimum","Maximum","Tartomány","Egyenes A+bx","Egyenes a+Bx","R^2","R^2 korrigált"];
axis = ["X","Y","Z"];


t_ref=[0,23];
y_ref=[45,45];
y_lim_upper=[71.6,71.6]; %
y_lim_lower=[18.4,18.4]; %
y_war_upper=[61.6,61.6]; %
y_war_lower=[28.4,28.4];

for i = 1:27
    %data = readtable(files(i).name,'Delimiter',{',', ';'}); %read data from file to matlab variable
    [time,calib,acc,gyro,mag,euler,linacc,grav] = LoadData(files(i).name); % Load the data into meaningfull variable names
    time = systime2sec(time); %convert system time in ms to s and remove the time offset
    time = max(time,0);
    time(time == 0) = NaN;
    
    cim = files(i).name(1:end-4) + " Acceeration derivate";
    
    normalized_angles = normalizeEulerAngles([euler.x, euler.y, euler.z]);
    
    cat(i) = categorical(cellstr(files(i).name(1:end-4)));
    VarNames2 = ["Gyro calib","Mag calib","Acc calib","Sys calib"];
   
    fig = figure('Name',files(i).name(1:end-4) ,'NumberTitle','off');
    yyaxis left
    
    
    
    plot(time(1:end-1),diff(normalized_angles(:,1)));
    ylabel("Euler angular speed [deg/s]");
    ylim([-2 2]);
    
    yyaxis right;
    
    plot(time,normalized_angles(:,1)+45, 'LineWidth',1.5)
    ylabel("Euler angle [deg]");
    ylim([0 90]);
    %plot(time,cumsum(normalized_angles(:,1)));
    
   
    grid on;
    grid minor;
    xlabel("Time [s]");
    
    %legend("Measured X angle","model","OK limit","OK limit","Warning","Warning"); %,'Location','southwest');
    %legend('boxoff');
    %xlim([0 40]);
    %ylim([0 90]);
    savefig(fig,[pwd '\kezifigures\diff\' files(i).name(1:end-4) '_angles_and_diff']);% '.png']);
    %savefig(fig,[pwd '\kezifigures\' files(i).name(1:end-4) 'X_with_limits']);% '.png']);
    %saveas(fig,[pwd '\kezifigures\' files(i).name(1:end-4) 'X_with_limits.png']);
end