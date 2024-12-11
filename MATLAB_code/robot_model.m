files = dir('*.txt'); % select wokring folder
VarNames = ["Tengely","Átalag","Medián","Szórás","Variancia","Minimum","Maximum","Tartomány","Egyenes A+bx","Egyenes a+Bx","R^2","R^2 korrigált"];
axis = ["X","Y","Z"];

for i = 23:27
    %data = readtable(files(i).name,'Delimiter',{',', ';'}); %read data from file to matlab variable
    [time,calib,acc,gyro,mag,euler,linacc,grav] = LoadData(files(i).name); % Load the data into meaningfull variable names
    time = systime2sec(time); %convert system time in ms to s and remove the time offset
    time = max(time,0);
    time(time == 0) = NaN;
    cim = files(i).name(1:end-4) + " normalized Euler angles";
    
    normalized_angles = normalizeEulerAngles([euler.x, euler.y, euler.z]);
    
    for j = 1:3
        [avg(j),med(j),standev(j),vari(j),mini(j),maxi(j),range(j)] = statistics(normalized_angles(:,j));
        mdl = fitlm(time,normalized_angles(:,j));
        a(j) = mdl.Coefficients.Estimate(1);
        b(j) = mdl.Coefficients.Estimate(2);
        R2O(j)  = mdl.Rsquared.Ordinary;
        R2A(j)  = mdl.Rsquared.Adjusted;
    end
    stat = table(axis',avg',med',standev',vari',mini',maxi',range',a',b',R2O',R2A','VariableNames',VarNames);
    writetable(stat,[pwd '\robotfigures\' files(i).name(1:end-4) '.xls'])
    
    fig = figure;
    plot(time,normalized_angles(:,1),time,normalized_angles(:,2),time,normalized_angles(:,3));
    title(cim,'Interpreter','none');
    grid on;
    grid minor;
    xlabel("Time [s]");
    ylabel("Euler angle [deg]");
    legend("X","Y","Z");
    %saveas(fig,[pwd '\robotfigures\' files(i).name(1:end-4) '.png']);
    %save(file(1:end-4)+"_Grav_angle");
    %saveas('MySimulinkDiagram.jpg');
    %[pwd '/subFolderName/myFig.fig']);
end