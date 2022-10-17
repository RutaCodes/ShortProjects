        
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
