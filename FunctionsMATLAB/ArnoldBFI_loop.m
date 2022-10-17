%Ruta Basijokaite

%Input: Vector with stream flow values from one year
%Output: Arnold's baseflow index

function [ArnoldBFI] = ArnoldBFI_loop(qoyr)

y = qoyr;
qdt = zeros(1,length(qoyr));
qbt = zeros(1,length(qoyr));
pval = 0.925;
for k = 2:length(qoyr)
    qbt(k) = pval.* qbt(k-1)+((1-pval)/2).*(y(k)+y(k-1));
            
    if qbt(k) >= y(k)
       qbt(k) = y(k);
    end
    
end
ArnoldBFI = sum(qbt)./sum(y);
        
