%Ruta Basijokaite

%Input: Simulated (qsyr) and observed (qoyr) stream flow values from one year
%Output: Slope of flow duration curve for medium flows (33th - 66th percentile)

function [SFDC] = SlopeFDC_loop(qoyr,qsyr)

N = length(qoyr);
Qob_sort = sort(qoyr,'descend');
Qsim_sort = sort(qsyr','descend');
rank = 1:N;
Ex_p = 100.*(rank/(1+N));

%Slope of flow duration curve - Medium flows
SFDC = (log(prctile(Qob_sort,66))-log(prctile(Qob_sort,33)))/(0.33-0.66);
