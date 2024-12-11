function [time,calib,acc,gyro,mag,euler,linacc,grav] = LoadData(filename)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    data = readtable(filename,'Delimiter',{',', ';'});
    
    time  = data.Var1;
    
    %Get calibration data
    calib.gyro  = data.Var2;
    calib.mag   = data.Var3;
    calib.acc   = data.Var4;
    calib.sys   = data.Var5;

    %Get acceration
    acc.x   = data.Var6;
    acc.y   = data.Var7;
    acc.z   = data.Var8;

    %Get gyroscope data
    gyro.x  = data.Var9;
    gyro.y  = data.Var10;
    gyro.z  = data.Var11;

    %Get magnetometer data
    mag.x   = data.Var12;
    mag.y   = data.Var13;
    mag.z   = data.Var14;

    %Get euler angles
    euler.x = data.Var15;
    euler.y = data.Var16;
    euler.z = data.Var17;
    
    %Get calculated linear acceleration
    linacc.x = data.Var18;
    linacc.y = data.Var19;
    linacc.z = data.Var20;

    %Get gravity orientation
    grav.x  = data.Var21;
    grav.y  = data.Var22;
    grav.z  = data.Var23;

    %Get system time
    
end