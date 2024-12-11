files = dir('*.txt'); % select wokring folder
close all
fig = figure;
hold on

for i = 1:22
    
    %data = readtable(files(i).name,'Delimiter',{',', ';'}); %read data from file to matlab variable
    [time,calib,acc,gyro,mag,euler,linacc,grav] = LoadData(files(i).name); % Load the data into meaningfull variable names
    
    time = adjustTimeVector(time);
    time = systime2sec(time); %convert system time in ms to s and remove the time offset
    
    time = max(time,0);
    time(time == 0) = NaN;
    time = adjustTimeVector(time);
    cim = files(i).name(1:end-4) + " normalized Euler angles X";
    
    normalized_angles = normalizeEulerAngles([euler.x, euler.y, euler.z]);
    
    ylim([0 90])
    t_ref=[0,23];
    y_ref=[45,45];
    y_lim_upper=[63.4,63.4]; %
    y_lim_lower=[26.6,26.6]; %
    y_war_upper=[60,60]; %
    y_war_lower=[30,30]; %
    
    plot(time,normalized_angles(:,1)+45);
   
    %save(file(1:end-4)+"_Grav_angle");
    %saveas('MySimulinkDiagram.jpg');
    %[pwd '/subFolderName/myFig.fig']);
end
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
%title(cim,'Interpreter','none');
grid on;
grid minor;
xlabel("Time [s]");
ylabel("Euler angle [deg]");
%legend("1","2","3","4","5");
saveas(fig,[pwd '\kezifigures\keziX_all.png']);
savefig(fig,[pwd '\kezifigures\keziX_all']);