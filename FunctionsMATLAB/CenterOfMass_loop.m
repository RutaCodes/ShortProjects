%Ruta Basijokaite 
      
%Input: Vector of stream flow values from one year
%Output: Date, center of mass

function [CoM] = CenterOfMass_loop(qoyr)

centerofmass = cumsum(qoyr)./(sum(qoyr));
centerofmass_ed = unique(centerofmass);
perc = linspace(0,1,length(centerofmass_ed));
if (sum(qoyr) == 0);
    CoM = 0;
else
    CoM = interp1(centerofmass_ed,perc,0.5);
end
