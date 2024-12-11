[file,~] = uigetfile('*.txt'); % sellect the file to read
data = readtable(file,'Delimiter',{',', ';'}); %read data from file to matlab variable
[time,calib,acc,gyro,mag,euler,linacc,grav] = LoadData(file); % Load the data into meaningfull variable names
time = systime2sec(time); %convert system time in ms to s and remove the time offset
time = max(time,0);
time(time == 0) = NaN;
angle_horizontal = angleHorizontalGravity(grav.x, grav.y, grav.z);
figure;
%plot(time,angle_horizontal);

plot(time,euler.x,time,euler.y,time,euler.z);
grid on
grid minor
xlabel("Time [s]");
%ylabel("Euler angle [deg]");
ylabel("Euler angle [deg]");
legend("X","Y","Z");
title(file + " Gravity angle",'Interpreter','none');

%savefig(file(1:end-4)+"_Grav_angle")