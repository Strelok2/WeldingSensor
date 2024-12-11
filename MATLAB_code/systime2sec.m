function [time_s] = systime2sec(sys_time_ms)
%calculates the time vector in seconds from the system tíme in ms

    t = sys_time_ms(1);         %
    time_s = sys_time_ms - t;   % set the start of the measurement to be 0 sec
    time_s = time_s/1000;        % from ms 2 sec 
end

