files = dir('*.txt'); % select wokring folder

fig = figure;
hold on

for i = 23:27
    %data = readtable(files(i).name,'Delimiter',{',', ';'}); %read data from file to matlab variable
    [time,calib,acc,gyro,mag,euler,linacc,grav] = LoadData(files(i).name); % Load the data into meaningfull variable names
    time = systime2sec(time); %convert system time in ms to s and remove the time offset
    time = max(time,0);
    time(time == 0) = NaN;
    cim = files(i).name(1:end-4) + " normalized Euler angles Z";
    
    normalized_angles = normalizeEulerAngles([euler.x, euler.y, euler.z]);
    
    
    plot(time,normalized_angles(:,1)+45);

    %save(file(1:end-4)+"_Grav_angle");
    %saveas('MySimulinkDiagram.jpg');
    %[pwd '/subFolderName/myFig.fig']);
end
ylim([44 46]);
%title(cim,'Interpreter','none');
grid on;
grid minor;
xlabel("Time [s]");
ylabel("Euler angle [deg]");
legend("1","2","3","4","5");
saveas(fig,[pwd '\robotfigures\robotX44-46.png']);