function [r2] = Rsquare(a,b,fncx,fncy)
%calculates the r square value of the function defined by fncx (xvalues)
%fncy(y values) realtive to the line defined by aX+b=0 

%Create the vector with values according to the fited line at the points of
%the function
    fitted_val = a .* fncx + b;

    avg_y = mean(fncy);
    SS_tot = sum((fncy-avg_y).^2);

    SS_reg = sum((fitted_val-avg_y).^2);

    SS_res = sum((fncy-fitted_val).^2);

    r2 = 1 - (SS_res / SS_tot);

end

