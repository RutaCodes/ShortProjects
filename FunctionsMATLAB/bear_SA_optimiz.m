%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATA STRUCTURE
%   Data.Period = Period of observation data (1:length of observations)
%   Data.Precip = Precipitation flux (mm/day)
%   Data.Evap = Potential Evapo-Transpiration flux (mm/day)
%   Data.Flow = Streamflow flux (mm/day)
% PARAMETER STRUCTURE
%   Pars.Huz = Max height of soil moisture accounting tank - Range [0, 500]
%   Pars.B   = Distribution function shape parameter       - Range [0, 2]
%   Pars.Alp = Quick-slow split parameter                  - Range [0, 1];
%   Pars.Nq  = Number of quickflow routing tanks           - Range [1, 10]
%   Pars.Kq  = Quickflow routing tanks rate parameter      - Range [0.1, 1]
%   Pars.Ks  = Slowflow routing tanks rate parameter       - Range [0, 0.1]
% Initialize state variables
%   InState.XCuz = Soil moisture accounting tank state contents - Dim(1 x 1)
%   InState.Xq   = Quickflow routing tanks state contents - Dim(1 x Pars.nq)
%   InState.Xs   = Slowflow routing tank state contents - Dim (1 x 1)
% MODEL STRUCTURE (The output uses a structure array, in which different
% matrixes/vectores are stored under one 'header', i.e. 'Model')
%   Model.XHuz = Model computed upper zone soil moisture tank state contents
%   Model.XCuz = Model computed upper zone soil moisture tank state contents
%   Model.Xq   = Model computed quickflow tank states contents
%   Model.Xs   = Model computed slowflow tank state contents
%   Model.ET   = Model computed evapotranspiration flux
%   Model.OV   = Model computed precipitation excess flux
%   Model.Qq   = Model computed quickflow flux
%   Model.Qs   = Model computed slowflow flux
%   Model.Q    = Model computed total streamflow flux
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; 
global Data

my_dir = pwd ; % use the 'pwd' command if you have already setup the Matlab
% Set current directory to 'my_dir' and add path to sub-folders:
cd(my_dir)
addpath(genpath(my_dir))

% Latitude and WS size
lat = 37.33939; % latitude at outlet
W_size = 142.19; % basin size in km2

% Load the data files
load Data_Bear_Lake.mat; %nldas data
dataset = Data_Bear_Lake(1:12692,:);
load Data_Qflow_Bear_Lake.mat; %streamflow
Streamflow = ((Data_Qflow_Bear_Lake(:,4)*0.0283168)/(W_size*10^6))*1000*3600*24; %from ft3/s to mm/day              
                                           %m3/s         m/s         mm/day      
Data_Qflow=Data_Qflow_Bear_Lake;
Data_Qflow(:,4)=Streamflow;  
save bear_Streamflow2.mat Data_Qflow
                                           
%Observation data
Data.Calib.Flow     = Streamflow;
Data.Calib.Period   = (1:length(dataset));
year = dataset(:,1);
month = dataset(:,2);
day = dataset(:,3);

%Using nldas
precip=dataset(:,6);
tempaver=(dataset(:,9)+ dataset(:,10))/2;%calculating average

%Met data
Data.Calib.Precip = precip;%in mm/day
Data.Calib.AT = tempaver;%in C

% % Calculate potential evapotranspiration (mm/day)
% Julian Date
[JD] = juliandate(year);
% Oudin ET
PE_value = oudinET(JD,Data.Calib.AT,lat);%m/day
Data.Calib.Evap = PE_value*1000; %mm/day

% %OPTIMIZATION
% [KGE_opt, Opt_vals, Fvals] = SCE_optimiz(Data);

% Define input distribution and ranges:
M  = 10 ; % number of uncertain parameters 
DistrFun  = 'unif'  ; % Parameter distribution
% Assign feasible ranges to 12 parameters
%DistrPar  = { [ 0.1 1 ]; [ 0 0.2 ]; [ 0 1 ]; [ 5 500]; [ 0 2 ]; [ 1 10 ]; [ 1 3 ]; [ -3 1 ]; [-3 3]; [0 0.1]; [0.9 1.1]; [0.9 1.1] } ; % Parameter ranges
%Old parameter ranges
%DistrPar  = { [ 0.1 1 ]; [ 0 0.2 ]; [ 0 1 ]; [ 5 500]; [ 0 2 ]; [ 1 10 ]; [ 1 3 ]; [ -3 1 ]; [-3 3]; [0 0.1] } ; 
%New parameter ranges
%DistrPar  = { [ 0.1 0.8 ]; [ 0 0.2 ]; [ 0 0.8 ]; [ 5 500 ]; [ 0 2 ]; [ 1 8 ]; [ 1 3 ]; [ -3 1 ]; [-2 2]; [0 0.05] } ;

%New snow routine 
DistrPar  = {  [ 0.1 0.8 ]; [ 0 0.2 ]; [ 0 0.8 ]; [ 5 500 ]; [ 0 2 ]; [ 1 8 ]; [ -3, 3 ]; [ 0, 1]; [-2 2]; [0, 0.8] } ;

% Sample parameter space using the resampling strategy proposed by 
% (Saltelli, 2008; for reference and more details, see help of functions
% vbsa_resampling and vbsa_indices) 
SampStrategy = 'lhs' ;
N = 5000; % Base sample size.
% Comment: the base sample size N is not the actual number of input 
% samples that will be evaluated. In fact, because of the resampling
% strategy, the total number of model evaluations to compute the two
% variance-based indices is equal to N*(M+2) 
X = AAT_sampling(SampStrategy,M,DistrFun,DistrPar,2*N);
[ XA, XB, XC ] = vbsa_resampling(X) ;
XALL = vertcat(XA,XB,XC);
Pars.Nq = 3;     %Number of quickflow routing tanks

qsyr_all=zeros(60000,366,33); 
qoyr_all=zeros(33,366);
months=[10 11 12 1 2 3 4 5 6 7 8 9];
mo_cnt=0;

for a=1:size(XALL,1) % for loop to cycle through random sampling parameter sets
    
    % Run model once
    Model = Hymod10par_edit_v1_rb(Data,XALL(a,:));%new snow routine
    %Model = Hymod01opt10par(Data,XALL(a,:));%old snow routine
    
    % Specify sim & obs - need to be same size
    qobs = Data.Calib.Flow;
    qsim = Model.Q;
    c = 0; mo_cnt=0;
    da = 0;
    qs(a,:) = qsim;

    NSE_whole(a,1)= 1 - (sum((qobs-qsim').^2)/(sum((qobs - mean(qobs)).^2)));
    KGE_whole(a,1)= kge(qsim',qobs);
    
    for j=1981:2013 %1980:2014
        [x, xx]=find(year==j & month == 10 & day == 1);
        [y, yy]=find(year==(j+1) & month == 9 & day == 30);
        
        da = da+1;
        qoyr = Data.Calib.Flow(x:y);
        qsyr = Model.Q(x:y);
        leng=length(qsyr);
        qsyr_all(a,1:length(qoyr),da) = qsyr';
        
        NSEyear(a,da) = 1 - (sum((qoyr-qsyr').^2)/(sum((qoyr - mean(qoyr)).^2)));
        WByear(a,da) = sum(abs(qoyr-qsyr'))/sum(qoyr);
        KGEyear(a,da) = kge(qsyr',qoyr);
        %RREyear(a,da) = 100*[(sum(qsim)/sum(Data.Calib.Precip)) - (sum(qobs)/sum(Data.Calib.Precip))]./(sum(qobs)/sum(Data.Calib.Precip));
        RSMEyear(a,da)=sqrt((1/leng)*sum((qoyr-qsyr').^2));
        
        P_year=sum(precip(x:y));
        RRyear(1,da) = sum(qoyr)/P_year;%all runs will be the same
        RRyear_sim(a,da) = sum(qsyr')/P_year;
        
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
        ArnoldBFI(1,da) = sum(qbt)./sum(y);
        
        y = qsyr;
        qdt = zeros(1,length(qsyr));
        qbt = zeros(1,length(qsyr));
        pval = 0.925;
        for k = 2:length(qsyr)
            qbt(k) = pval.* qbt(k-1)+((1-pval)/2).*(y(k)+y(k-1));
            
            if qbt(k) >= y(k)
                qbt(k) = y(k);
            end
            
        end
        ArnoldBFI_sim(a,da) = sum(qbt)./sum(y);
        
        %Slope of flow duration curve
        N=length(qoyr);
        Qob_sort=sort(qoyr,'descend');
        Qsim_sort=sort(qsyr','descend');
        rank=1:N;
        Ex_p=100.*(rank/(1+N));
        % Medium flows
        SFDC(1,da) = (log(prctile(Qob_sort,66))-log(prctile(Qob_sort,33)))/(0.33-0.66);
        SFDC_sim(a,da) = (log(prctile(Qsim_sort,66))-log(prctile(Qsim_sort,33)))/(0.33-0.66);
      
        % Date, center of mass
        centerofmass = cumsum(qoyr)./(sum(qoyr));
        centerofmass_ed=unique(centerofmass);
        perc = linspace(0,1,length(centerofmass_ed));
        if (sum(qoyr)==0);
            CoM(1,da) = 0;
        else
            CoM(1,da) = interp1(centerofmass_ed,perc,0.5);
        end
        
        centerofmass = cumsum(qsyr)./(sum(qsyr));
        centerofmass_ed=unique(centerofmass);
        perc = linspace(0,1,length(centerofmass_ed));
        if (sum(qsyr)==0);
            CoM_sim(a,da) = 0;
        else
            CoM_sim(a,da) = interp1(centerofmass_ed,perc,0.5);
        end

        %Hydrologic signatures
        qoyr_down_loop=sort(qoyr,'descend');
        qsyr_down_loop=sort(qsyr,'descend');
        qfdcobs_loop = prctile(qoyr_down_loop,(1:100));
        qfdcsim_loop = prctile(qsyr_down_loop,(1:100));
        qfdcobs_loop_EP=sort(qfdcobs_loop,'descend');
        qfdcsim_loop_EP=sort(qfdcsim_loop,'descend');
        
        SFDC_low_obs_yr_loop=((qfdcobs_loop_EP(90))-(qfdcobs_loop_EP(70)))/(90-70);
        SFDC_low_sim_yr_loop=((qfdcsim_loop_EP(90))-(qfdcsim_loop_EP(70)))/(90-70);
        SFDC_mid_obs_yr_loop=((qfdcobs_loop_EP(60))-(qfdcobs_loop_EP(30)))/(60-30);
        SFDC_mid_sim_yr_loop=((qfdcsim_loop_EP(60))-(qfdcsim_loop_EP(30)))/(60-30);
        SFDC_high_obs_yr_loop=((qfdcobs_loop_EP(10))-(qfdcobs_loop_EP(5)))/(10-5);
        SFDC_high_sim_yr_loop=((qfdcsim_loop_EP(10))-(qfdcsim_loop_EP(5)))/(10-5);
        
        SFDCE.high_yr_loop(a,da)=SFDC_high_obs_yr_loop-SFDC_high_sim_yr_loop;
        SFDCE.mid_yr_loop(a,da)=SFDC_mid_obs_yr_loop-SFDC_mid_sim_yr_loop;
        SFDCE.low_yr_loop(a,da)=SFDC_low_obs_yr_loop-SFDC_low_sim_yr_loop;
        
        SFDCEP.high_yr_loop(a,da)=100*(SFDC_high_obs_yr_loop-SFDC_high_sim_yr_loop)./SFDC_high_obs_yr_loop;
        SFDCEP.mid_yr_loop(a,da)=100*(SFDC_mid_obs_yr_loop-SFDC_mid_sim_yr_loop)./SFDC_mid_obs_yr_loop;
        SFDCEP.low_yr_loop(a,da)=100*(SFDC_low_obs_yr_loop-SFDC_low_sim_yr_loop)./SFDC_low_obs_yr_loop;
        
    end

end

[NSEtop_val,NSEtop_index]=sort(NSE_whole,'descend'); %a values, b index
[KGEtop_val,KGEtop_index]=sort(KGE_whole,'descend');
Best_KGE_run=qs(KGEtop_index(1),:);
Best_NSE_run=qs(NSEtop_index(1),:);

Top_1perc(1,1)=mean(KGEtop_val(1:600));
Top_1perc(1,2)=max(KGEtop_val(1:600));
Top_1perc(1,3)=median(KGEtop_val(1:600));
Top_1perc(1,4)=min(KGEtop_val(1:600));

All_stats(1,1)=mean(KGEtop_val);
All_stats(1,2)=max(KGEtop_val);
All_stats(1,3)=median(KGEtop_val);
All_stats(1,4)=min(KGEtop_val);

AT = Data.Calib.AT;
P = Data.Calib.Precip;

%looking for best KGE value run
KGE_sorted_val=zeros(length(KGEyear),da);
KGE_sorted_ind=zeros(length(KGEyear),da);
for i=1:size(KGEyear,2)
[a1,b1]=sort(KGEyear(:,i),'descend'); %a values, b index
KGE_sorted_val(:,i)=a1;
KGE_sorted_ind(:,i)=b1;
end
%recording best yearly qsim runs
qsim_best=zeros(da,366);
for i=1:da %qsyr_all(da,:,a)
    qsim_best(i,:)=qsyr_all(KGE_sorted_ind(1,i),:,i);
end
% sorting q values
qoyr_down=zeros(da,366); obs_ind=zeros(da,366); 
qsyr_down=zeros(da,366); sim_ind=zeros(da,366);
for i=1:da
    [qoyr_down(i,:),obs_ind(i,:)]=sort(qoyr_all(i,:),'descend');
    [qsyr_down(i,:),sim_ind(i,:)]=sort(qsim_best(i,:),'descend');
end
% calculating EP
for i=1:length(qsyr_down)
    for j=1:da
        EP_obs_yr(j,i)=100*(i/(length(qoyr_down)+1));
        EP_sim_yr(j,i)=100*(i/(length(qsyr_down)+1));
    end
end

%Hydrologic signatures (whole)
for i=1:da
    qfdcobs( i,:) = prctile(qoyr_down(i,:),(1:100));
    qfdcobs_EP(i,:)=sort(qfdcobs(i,:),'descend');
    qfdcsim( i,:) = prctile(qsyr_down(i,:),(1:100));
    qfdcsim_EP(i,:)=sort(qfdcsim(i,:),'descend');
    
    SFDC_low_obs_yr(i,1)=((qfdcobs_EP(i,90))-(qfdcobs_EP(i,70)))/(90-70);
    SFDC_low_sim_yr(i,1)=((qfdcsim_EP(i,90))-(qfdcsim_EP(i,70)))/(90-70);
    SFDC_mid_obs_yr(i,1)=((qfdcobs_EP(i,60))-(qfdcobs_EP(i,30)))/(60-30);
    SFDC_mid_sim_yr(i,1)=((qfdcsim_EP(i,60))-(qfdcsim_EP(i,30)))/(60-30);
    SFDC_high_obs_yr(i,1)=((qfdcobs_EP(i,10))-(qfdcobs_EP(i,5)))/(10-5);
    SFDC_high_sim_yr(i,1)=((qfdcsim_EP(i,10))-(qfdcsim_EP(i,5)))/(10-5);
    
    SFDCE_high_yr(i,1)=SFDC_high_obs_yr(i,1)-SFDC_high_sim_yr(i,1);
    SFDCE_mid_yr(i,1)=SFDC_mid_obs_yr(i,1)-SFDC_mid_sim_yr(i,1);
    SFDCE_low_yr(i,1)=SFDC_low_obs_yr(i,1)-SFDC_low_sim_yr(i,1);
    
    SFDCEP_high_yr(i,1)=SFDC_high_obs_yr(i,1)-SFDC_high_sim_yr(i,1);
    SFDCEP_mid_yr(i,1)=SFDC_mid_obs_yr(i,1)-SFDC_mid_sim_yr(i,1);
    SFDCEP_low_yr(i,1)=SFDC_low_obs_yr(i,1)-SFDC_low_sim_yr(i,1);
end

for a=1:size(XALL,1)
    for j=1:33
        RR_PDif(a,j)=(abs(RRyear_sim(a,j)-RRyear(1,j)))/((RRyear_sim(a,j)+RRyear(1,j))/2)*100;
        ArnoldBFI_PDif(a,j)=(abs(ArnoldBFI_sim(a,j)-ArnoldBFI(1,j)))/((ArnoldBFI_sim(a,j)+ArnoldBFI(1,j))/2)*100;
        SFDC_PDif(a,j)=(abs(SFDC_sim(a,j)-SFDC(1,j)))/((SFDC_sim(a,j)+SFDC(1,j))/2)*100;
        CoM_PDif(a,j)=(abs(CoM_sim(a,j)-CoM(1,j)))/((CoM_sim(a,j)+CoM(1,j))/2)*100;
    end
end

qs1=qs(1:20000,:);
qs2=qs(20001:40000,:);
qs3=qs(40001:60000,:);
save bear_hymod_5000hyd_Qsim_HydSigRun2.mat qs1 qs2 qs3

save bear_hymod_5000hyd_hydr_sig_HydSigRun2.mat RR_PDif ArnoldBFI_PDif SFDC_PDif CoM_PDif
save bear_hymod_5000hyd_q_EP_snow_HydSigRun2.mat EP_obs_yr qoyr_down EP_sim_yr qsyr_down
save bear_hymod_5000hyd_ofs_best_snow_HydSigRun2.mat SFDCE_high_yr SFDCE_mid_yr SFDCE_low_yr SFDCEP_high_yr SFDCEP_mid_yr SFDCEP_low_yr %SFDCE_high_whole SFDCE_mid_whole SFDCE_low_whole %EP_obs EP_obs_yr EP_sim_yr EP_sim
save bear_hymod_5000hyd_ofs_loop_snow_HydSigRun2.mat SFDCE SFDCEP %SFDCE.high_yr_loop SFDCE.mid_yr_loop SFDCE.low_yr_loop SFDCEP.high_yr_loop SFDCEP.mid_yr_loop SFDCEP.low_yr_loop
save bear_hymod_5000hyd_objFun_snow_HydSigRun2.mat NSEyear KGEyear WByear NSE_whole KGE_whole RSMEyear %RREyear
save bear_SA_5000sim_val_snow_HydSigRun2.mat NSEtop_val NSEtop_index KGEtop_val KGEtop_index Best_KGE_run Best_NSE_run
save bear_SA_5000sim_snow_HydSigRun2.mat PE_value %data length by 1
save bear_SA_5000pars_snow_HydSigRun2.mat XALL %N by par  nr

% Compute main (first-order) and total effects:
for c=1:size(NSEyear,2)
    i1 = 1:size(XA,1);
    i2 = (size(XA,1)+1):2*size(XA,1);
    i3 = (2*size(XA,1)+1):size(XALL);
  [ WByearSi(c,:), WByearSTi(c,:) ] = vbsa_indices(WByear(i1,c),WByear(i2,c),WByear(i3,c)); %Si first order STi total order
  [ NSEyearSi(c,:), NSEyearSTi(c,:) ] = vbsa_indices(NSEyear(i1,c),NSEyear(i2,c),NSEyear(i3,c));
  [ KGEyearSi(c,:), KGEyearSTi(c,:) ] = vbsa_indices(KGEyear(i1,c),KGEyear(i2,c),KGEyear(i3,c)); 
  [ RMSEyearSi(c,:), RMSEyearSTi(c,:) ] = vbsa_indices(RSMEyear(i1,c),RSMEyear(i2,c),RSMEyear(i3,c));
  %[ MyearSi(c,:), MyearSTi(c,:) ] = vbsa_indices(Myear(i1,c),Myear(i2,c),Myear(i3,c));
  %[ RREyearSi(c,:), RREyearSTi(c,:) ] = vbsa_indices(RREyear(i1,c),RREyear(i2,c),RREyear(i3,c));
  [ SFDCE_high_yearSi(c,:), SFDCE_high_yearSTi(c,:) ] = vbsa_indices(SFDCE.high_yr_loop(i1,c),SFDCE.high_yr_loop(i2,c),SFDCE.high_yr_loop(i3,c));
  [ SFDCE_mid_yearSi(c,:), SFDCE_mid_yearSTi(c,:) ] = vbsa_indices(SFDCE.mid_yr_loop(i1,c),SFDCE.mid_yr_loop(i2,c),SFDCE.mid_yr_loop(i3,c));
  [ SFDCE_low_yearSi(c,:), SFDCE_low_yearSTi(c,:) ] = vbsa_indices(SFDCE.low_yr_loop(i1,c),SFDCE.low_yr_loop(i2,c),SFDCE.low_yr_loop(i3,c));
  [ RRyearSi(c,:), RRyearSTi(c,:) ] = vbsa_indices(RR_PDif(i1,c),RR_PDif(i2,c),RR_PDif(i3,c));
  [ ArBFIyearSi(c,:), ArBFIyearSTi(c,:) ] = vbsa_indices(ArnoldBFI_PDif(i1,c),ArnoldBFI_PDif(i2,c),ArnoldBFI_PDif(i3,c));
  [ SFDCyearSi(c,:), SFDCyearSTi(c,:) ] = vbsa_indices(SFDC_PDif(i1,c),SFDC_PDif(i2,c),SFDC_PDif(i3,c));
  [ CoMyearSi(c,:), CoMyearSTi(c,:) ] = vbsa_indices(CoM_PDif(i1,c),CoM_PDif(i2,c),CoM_PDif(i3,c));
end

save bear_sens_yr_run5000_hydr_sig_HydSigRun2.mat RRyearSi RRyearSTi ArBFIyearSi ArBFIyearSTi SFDCyearSi SFDCyearSTi CoMyearSi CoMyearSTi 
save bear_sens_yr_run5000_snow_HydSigRun2.mat WByearSi WByearSTi NSEyearSi NSEyearSTi KGEyearSi KGEyearSTi RMSEyearSi RMSEyearSTi %RREyearSi RREyearSTi %MyearSi MyearSTi %year nr by par nr
save bear_sens_yr_hyd_SFDCE_run5000_snow_HydSigRun2.mat SFDCE_high_yearSi SFDCE_high_yearSTi SFDCE_mid_yearSi SFDCE_mid_yearSTi SFDCE_low_yearSi SFDCE_low_yearSTi

%sensitivity based on output
for i=1:size(qs,2)
[QSi(i,:),QSTi(i,:)]=vbsa_indices(qs(i1,i),qs(i2,i),qs(i3,i));
end
%sensitivity for KGEwhole period
[KGEwholeSi,KGEwholeSTi]=vbsa_indices(KGE_whole(i1),KGE_whole(i2),KGE_whole(i3));

save bear_sens_QSTi_KGEwhole_run5000_snow_HydSigRun2.mat QSi QSTi KGEwholeSi KGEwholeSTi

%test 2 - normal year, test 3 - water year
%test 4 - water year, PCF and ATCF are set to 1, to avoid misinterpretation
%of results due to input changes from PCF
%test 6 - SA with FDC code
%test 9nr - SA with new parameter ranges
%test snow1 - SA with new paranemeter ranges (from 9nr) and new snow routine
%test snow2 - New snow routine with PET changes
%test snow_old - Old snow routine with PET changes
%Newrun1 - run for newly added watersheds
%of results due to input changes from PCF
%Hsigrun - SA on higrologig signatures
%HydSigRun2 - SA on hydrologic signatures with corrected CoM
%XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

figure; set(gcf,'color','w');
subplot(2,2,1);
imagesc(RRyearSTi);hold on; colorbar;
title('RR');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
% yticks([2 3 4 5 6 7 8 9]);
% yticklabels({'2006','2007','2008','2009','2010','2011','2012','2013'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(2,2,2);
imagesc(ArBFIyearSTi);hold on; colorbar;
title('Arnold BFI');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(2,2,3);
imagesc(SFDCyearSTi);hold on; colorbar;
title('SFDC');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});
subplot(2,2,4);
imagesc(CoMyearSTi);hold on; colorbar;
title('Center of Mass');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
imagesc(KGEyearSTi);hold on; colorbar;
title('KGE');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
imagesc(RMSEyearSTi);hold on; colorbar;
title('RMSE');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
imagesc(KGEwholeSTi);hold on; colorbar;
title('KGE whole');colormap(flipud(gray));caxis([0 1]);

% figure; set(gcf,'color','w');
% imagesc(QSTi);hold on; colorbar;
% title('Q STi daily');colormap(flipud(gray));caxis([0 1]);
% xticks([1 2 3 4 5 6 7 8 9 10]);
% xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});

ob_sim_diff=zeros(size(qs,1),size(qs,2));
ob_sim_diff_abs=zeros(size(qs,1),size(qs,2));
for i=1:size(qs,1)
    for j=1:size(qs,2)
        ob_sim_diff(i,j)=qobs(j)-qs(i,j);
        ob_sim_diff_abs(i,j)=abs(qobs(j)-qs(i,j));
    end
end

%sensitivity based on output
for i=1:size(ob_sim_diff,2)
[Q_diff_Si(i,:),Q_diff_STi(i,:)]=vbsa_indices(ob_sim_diff(i1,i),ob_sim_diff(i2,i),ob_sim_diff(i3,i));
end

figure; set(gcf,'color','w');
imagesc(Q_diff_STi);hold on; colorbar;
title('Daily diff STi');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks(aa(2:33)); yticklabels(1983:2014);

cnt=0; Q_diff_STi_yr_av=zeros(33,10);
%ob_sim_diff_yr_av=zeros(60000,33);
%Q_sim_yr_av=zeros(60000,33); QSTi_yr_av=zeros(33,10);  
for j=1981:2013 %1980:2014
    [x, xx]=find(year==j & month == 10 & day == 1);
    [y, yy]=find(year==(j+1) & month == 9 & day == 30);
    cnt=cnt+1;
    for i=1:10
        %QSTi_yr_av(cnt,i)=mean(QSTi(x:y,i));
        Q_diff_STi_yr_av(cnt,i)=mean(Q_diff_STi(x:y,i));
    end
%     for sim=1:60000
%         %Q_sim_yr_av(sim,cnt)=mean(qs(sim,x:y));
%         ob_sim_diff_yr_av(sim,cnt)=mean(ob_sim_diff(sim,x:y));
%     end
end

for i=1:size(Q_sim_yr_av,2)
%[Q_ann_Si(i,:),Q_ann_STi(i,:)]=vbsa_indices(Q_sim_yr_av(i1,i),Q_sim_yr_av(i2,i),Q_sim_yr_av(i3,i));
[Qdiff_ann_Si(i,:),Qdiff_ann_STi(i,:)]=vbsa_indices(ob_sim_diff_yr_av(i1,i),ob_sim_diff_yr_av(i2,i),ob_sim_diff_yr_av(i3,i));
end

figure; set(gcf,'color','w');
imagesc(Q_diff_STi_yr_av);hold on; colorbar;
title('Annual daily diff average STi');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
imagesc(Qdiff_ann_STi);hold on; colorbar;
title('Annual diff STi');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
imagesc(Q_ann_STi);hold on; colorbar;
title('Q annual STi');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

figure; set(gcf,'color','w');
imagesc(QSTi_yr_av);hold on; colorbar;
title('Q annual daily average STi');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([4 9 14 19 24 29]);
yticklabels({'1985','1990','1995','2000','2005','2010'});

KGEyear_aver_comp=zeros(3,10);
STiyear_aver_comp(1,:)=KGEwholeSTi;
for i=1:10
    STiyear_aver_comp(2,i)=mean(KGEyearSTi(:,i));
    STiyear_aver_comp(3,i)=mean(QSTi_yr_av(:,i))
end
figure; set(gcf,'color','w');
imagesc(STiyear_aver_comp);hold on; colorbar;
title('Q STi');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks([1 2 3]);
yticklabels({'Whole KGE','Yearly KGE aver','Daily Q aver'});

Q_SA=Data_Qflow_Bear_Lake(640:12692,:);
[aa,~]=find(Q_SA(:,2)==10 & Q_SA(:,3)==1);
figure; set(gcf,'color','w');
imagesc(QSTi(640:12692,:));hold on; colorbar;
title('Q STi daily');colormap(flipud(gray));caxis([0 1]);
xticks([1 2 3 4 5 6 7 8 9 10]);
xticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
yticks(aa(2:33)); yticklabels(1983:2014);

Q_SA_2014=Data_Qflow_Bear_Lake(12328:12692,:);
[aa14,~]=find(Q_SA_2014(:,3)==1);
figure; set(gcf,'color','w');
imagesc(QSTi(12328:12692,:)');hold on; colorbar;
title('Q STi daily');colormap(flipud(gray));caxis([0 1]);
yticks([1 2 3 4 5 6 7 8 9 10]);
yticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
xticks(aa14(2:12)); xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

figure; set(gcf,'color','w');
plot(Streamflow(12328:12692,:)); xlim([1 365]);
xticks(aa14(2:12)); xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

figure; set(gcf,'color','w');
bar(precip(12328:12692,:),'g'); xlim([1 365]);
xticks(aa14(2:12)); xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

Q_2011=Data_Qflow_Bear_Lake(11232:11596,:);
figure; set(gcf,'color','w');
imagesc(QSTi(11232:11596,:)');hold on; colorbar;
title('2011 daily Q STi');colormap(flipud(gray));caxis([0 1]);
yticks([1 2 3 4 5 6 7 8 9 10]);
yticklabels({'Kq','Ks','Alp','H','B','DDF','TT','Kf','TM','r'});
xticks(aa14(2:12)); xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});

figure; set(gcf,'color','w');
plot(Q_2011(:,4)); xlim([1 365]);
xticks(aa14(2:12)); xticklabels({'Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'});
