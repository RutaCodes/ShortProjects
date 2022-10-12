function [jdall] = juliandate(in)

% in = year

minyear = min(in);
maxyear = max(in);

for i = minyear:maxyear;
    [~,b] = find(in == i);
    jdc = (1:length(b))';
   
    if length(b) < 365;
        jdc = ((365 - length(b) + 1): 365)';
        if i == minyear;
            jdall = jdc;
        elseif i == maxyear;
            jdc = (1:length(b))';
            jdall = vertcat(jdall,jdc);
        else
            jdall = vertcat(jdall,jdc);
        end;
        
    else
        if i == minyear;
            jdall = jdc;
        else
            jdall = vertcat(jdall,jdc);
        end;
    end;
end;