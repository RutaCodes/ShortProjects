*HW1* RUTA BASIJOKAITE*;
OPTIONS NOCENTER NODATE PAGENO=1 LS=76 PS=45 NOLABEL;
DATA ALL;
  INPUT X Y;
  CARDS;
  151.31 261.369
  165.85 259.526
  175.83 305.442
  185.21 282.925
  197.22 353.926
  206.17 314.609
  225.69 337.269
  234.05 370.963
  249.06 406.731
  255.64 370.554
  269.19 415.977
  292.32 402.084
  290.98 451.253
  308.13 462.038
  323.46 486.502
  353.77 480.302
  339.93 478.823
  305.93 429.149
  337.41 455.362
  370.22 515.41
  ;
 RUN;
 TITLE 'HW1';
 PROC MEANS N MEAN MEDIAN STD MIN MAX MAXDEC=4;
   VAR Y X;
 RUN;
 PROC CORR PEARSON SPEARMAN;
   VAR Y X;
 RUN;
 *PROC CORR DATA=ALL COV PEARSON SPEARMAN;
 *  VAR X Y;
 *RUN;
 PROC REG DATA=ALL SIMPLE CORR;
   MODEL Y=X / CLB P CLM CLI;
 RUN;
 PROC SGPLOT DATA=ALL NOAUTOLEGEND;
   SCATTER X=X Y=Y / MARKERATTRS=(SYMBOL=CIRCLEFILLED COLOR=BLACK); 
 RUN;
  
