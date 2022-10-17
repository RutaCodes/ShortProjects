clear all; 
global Data
%Directory
% my_dir = '/Desktop/RA modeling';
% cd(my_dir);
% addpath(genpath(my_dir));

% Dates to run model for
d1 = [1981 10 1]; %[1980 1 1]
d2 = [2014 9 30]; %[2014 12 31]

% Specify first:
lat = 37.33939; % latitude at outlet
W_size = 142.19; % basin size in km2

% Load data
load Data_Bear_Lake.mat; %data nldas
load Data_Qflow_Bear_Lake.mat; %streamflow
dataset = Data_Bear_Lake; %for nldas
Streamflow = ((Data_Qflow_Bear_Lake(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day                                                        

%Observation data
Data.All.Period = (1:length(dataset))';
Data.All.Flow = Streamflow;
Data.All.Yr = dataset(:,1);
Data.All.Mo = dataset(:,2);
Data.All.Day = dataset(:,3);

%Using nldas
precip=dataset(:,6);
tempaver=(dataset(:,9)+dataset(:,10))/2;

%Met data
Data.All.Precip = precip;%from inches to mm
Data.All.AT = tempaver;
Data.All.ATMax = dataset(:,9);
Data.All.ATMin = dataset(:,10);

% Julian Date
[Data.All.JD] = juliandate(dataset(:,1));

% Oudin ET
[PE] = oudinET(Data.All.JD,Data.All.AT,lat);
Data.All.Evap = PE*1000;

[loc1,~] = find(dataset(:,1) == d1(1)&dataset(:,2) == d1(2)&dataset(:,3)==d1(3));
[loc2,~] = find(dataset(:,1) == d2(1)&dataset(:,2) == d2(2)&dataset(:,3)==d2(3));

n1 = loc1; n2 = loc2;
Data.Calib.Period = Data.All.Period(n1:n2);
Data.Calib.Flow = Data.All.Flow(n1:n2);
Data.Calib.Precip = Data.All.Precip(n1:n2);
Data.Calib.AT = Data.All.AT(n1:n2);
Data.Calib.ATMax = Data.All.ATMax(n1:n2);
Data.Calib.ATMin = Data.All.ATMin(n1:n2);
Data.Calib.Evap = Data.All.Evap(n1:n2);

load bear_lake_SA_5000pars_test4.mat %XALL
load bear_lake_SA_5000sim_val_test4.mat %Top KGE and NSE values and indices
Pars_val=XALL(KGEtop_index(1),:);
Pars.Nq = 3;     %Number of quickflow routing tanks
    
% Run model once
Model = Hymod01opt10par(Data,Pars_val);

% Specify sim & obs - need to be same size
qobs = Data.Calib.Flow;
qsim = Model.Q;

AT = Data.Calib.AT;
P = Data.Calib.Precip;

figure;
set(gcf,'color','w');
plot(qobs); hold on;
plot(qsim); legend('Observed','Simulated');
xlim([0 12053]); ylim([0 50]); title('Best KGE value');
xticks([1 32 62 93 124 152 183 213 244 274 305 336]);
xticklabels({'Oct 1','Nov 1','Dec 1','Jan 1','Feb 1','March 1','Apr 1','May 1','June 1','July 1','Aug 1','Sep 1'});

% figure;
% set(gcf,'color','w');
% plot(qobs,'LineWidth',3);
% hold on;
% plot(qs(1,:),'k');
% % for i=1:10
% %     plot(qs(i,:));
% %     hold on;
% % end
% legend('Observed','Simulated');
% %legend('Observed');
% axis([93 12875 0 140]);
% ylabel('\bf Q (mm/day)');
% xticks([1554 3380 5206 7032 8859 10685 12511]);
% xticklabels({'\bf 1985','\bf 1990','\bf 1995','\bf 2000','\bf 2005','\bf 2010','\bf 2015'});
% title('Ward');

