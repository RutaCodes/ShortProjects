%Ruta Basijokaite

%Variables:
%N - length of yearly flows
%Q_sort - sorted streamflow
%rank - ranked streamflows
%Ex_p - exceedance probability
%i1 - rank (integer) of specified percentile
%theta - estimator
%Q_f - streamflow at specified percentiles

function [Q_f] = FDC_loop(flow,percentiles)

N=length(flow);
Q_sort=sort(flow,'descend');
rank=1:N;
Ex_p=(rank/(1+N));

i1=floor((N+1)*percentiles);
theta=((N+1)*percentiles-i1);

for b=1:length(percentiles)
    Q_f(b)=(1-theta(b))*Q_sort(i1(b))+theta(b)*Q_sort((i1(b))+1);
end
