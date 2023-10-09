#Ruta Basijokaite 

#--------------------------------------
#This code analyzes if differences among study groups are statistically significant
#--------------------------------------

#### DATA INPUT
# Uploading strength measurements 
Data_f = read.csv(file="Exercise_stats.csv",sep=",",header=T)  #Raw data

# Packages
library(tidyverse)
library(rstatix)
library(ggpubr) 
library(emmeans)

######################################
# ONE-WAY ANOVA: are means of Control, Active, Passive significantly different?
# Grouping data by Groups (Control, Active, Passive)
######################################
# One-way ANOVA - test where the data are organized into several groups according to only one single grouping variable (e.g. test group)

# The idea behind the ANOVA test: if the average variation between groups is large enough compared to the average variation within groups, 
# then you can conclude that at least one group mean is not equal to the others. To analyze that we evaluate whether the differences between 
# the group means are significant by comparing the two variance estimates. 

#### DATA ANALYSIS 

# Re-order
Data_f = Data_f %>% reorder_levels(Group, order = c("Control", "Active", "Passive"))

# Summary statistics
Data_f %>% group_by(Group) %>% get_summary_stats(Strength_Differences, type = "mean_sd")

### Checking if ANOVA assumptions are met

# Identify outliers 
Data_f %>% group_by(Group) %>% identify_outliers(Strength_Differences)
# There are no outliers

# Checking normality assumptions by group
Data_f %>% group_by(Group) %>% shapiro_test(Strength_Differences)
# The strength differences were normally distributed (p > 0.05) for each group, as assessed by
# Shapiro_Wilk's test for normality

# Homogeneity of variance assumption
Data_f %>% levene_test(Strength_Differences ~ Group)
# Since p>0.05, there is no significant difference between variances across groups

# Normal QQ plot to visualize normality. QQ plot draws the correlation between a given data and the 
# normality distribution 
ggqqplot(Data_f, "Strength_Differences", facet.by = "Group")
# All the points fall approximately along the reference line for each cell. So we can assume 
# normality of the data

### ANOVA COMPUTATION

# Compare the mean of multiple groups using ANOVA test
aov_test = Data_f %>% anova_test(Strength_Differences ~ Group)
# Print results
aov_test
# ANOVA test results indicate that there are no significant differences 
# between groups (since p=0.711).
# Also, F value (F<1) indicates that there are no significant differences between 
# the means of the sample groups.

# A significant one-way ANOVA is generally followed up by Tukey post-hoc tests to perform 
# multiple pairwise comparison between groups
pairwise_tukey = Data_f %>% tukey_hsd(Strength_Differences ~ Group)
pairwise_tukey

# Other pairwise comparison
pairwise_t = Data_f %>% pairwise_t_test(Strength_Differences ~ Group, p.adjust.method = "bonferroni")
pairwise_t 
# All p-values are above 0.05, therefore we can conclude that there are no significant differences
# among any of the groups (both pairwise tests agree)


### VISUALIZATION

# Create a box plot of strength differences by group
ggboxplot(Data_f, x = "Group", y = "Strength_Differences")

# Visualization: box plots with p-values

# Show adjusted p-values
pairwise_t = pairwise_t %>% add_xy_position(x = "Group")
ggboxplot(Data_f, x = "Group", y = "Strength_Differences") +
  stat_pvalue_manual(pairwise_t, label = "p.adj", tip.length = 0, step.increase = 0.1) +
  labs(subtitle = get_test_label(aov_test, detailed = TRUE), caption = get_pwc_label(pairwise_t))

# Show significance levels, hide non-significant test
ggboxplot(Data_f, x = "Group", y = "Strength_Differences") +
  stat_pvalue_manual(pairwise_t, hide.ns = TRUE, label = "p.adj.signif") +
  labs(subtitle = get_test_label(aov_test, detailed = TRUE), caption = get_pwc_label(pairwise_t))


######################################
# ONE-WAY ANOVA: are means of Above and Below EE groups significantly different?
# Grouping data by EE_average (Above, Below)
######################################

# Summary statistics
Data_f %>% group_by(EE_average) %>% get_summary_stats(Strength_Differences, type = "mean_sd")

### Checking if ANOVA assumptions are met

# Identify outliers 
Data_f %>% group_by(EE_average) %>% identify_outliers(Strength_Differences)
# There are two outliers - one in control group, one in active

# Checking normality assumptions by group
Data_f %>% group_by(EE_average) %>% shapiro_test(Strength_Differences)
# The strength differences were normally distributed (p > 0.05) for each EE group, as assessed by
# Shapiro_Wilk's test for normality

# Homogeneity of variance assumption
Data_f %>% levene_test(Strength_Differences ~ EE_average)
# Since p>0.05, there is no significant variance differences across groups

# Normal QQ plot to visualize normality. QQ plot draws the correlation between a given data and the 
# normality distribution 
ggqqplot(Data_f, "Strength_Differences", facet.by = "EE_average")
# All the points fall approximately along the reference line for each cell. So we can assume 
# normality of the data

### ANOVA COMPUTATION

# Compare the mean of multiple groups using ANOVA test
aov_test3 = Data_f %>% anova_test(Strength_Differences ~ EE_average)
aov_test3
# There are statistically significant differences between EE groups

# Pairwise comparisons
pairwise_tukey3 = Data_f %>% tukey_hsd(Strength_Differences ~ EE_average)
pairwise_tukey3

# Other pairwise comparison
pairwise_t3 = Data_f %>% pairwise_t_test(Strength_Differences ~ EE_average, p.adjust.method = "bonferroni")
pairwise_t3 
# This pairwise tests show that differences were statistically significant (p < 0.05) between EE groups


### VISUALIZATION

# Create a box plot of strength differences by group
ggboxplot(Data_f, x = "EE_average", y = "Strength_Differences")

# Visualization: box plots with p-values

# Show adjusted p-values
pairwise_t3 = pairwise_t3 %>% add_xy_position(x = "EE_average")
ggboxplot(Data_f, x = "EE_average", y = "Strength_Differences") +
  stat_pvalue_manual(pairwise_t3, label = "p.adj", tip.length = 0, step.increase = 0.1) +
  labs(subtitle = get_test_label(aov_test3, detailed = TRUE), caption = get_pwc_label(pairwise_t3))

# Show significance levels 
# Hide non-significant test
ggboxplot(Data_f, x = "EE_average", y = "Strength_Differences") +
  stat_pvalue_manual(pairwise_t3, hide.ns = TRUE, label = "p.adj.signif") +
  labs(subtitle = get_test_label(aov_test3, detailed = TRUE), caption = get_pwc_label(pairwise_t3))


######################################
# TWO-WAY ANOVA - Analyzing 8 subgroups
######################################
# Two-way ANOVA is used to evaluate simultaneously the effect of two different grouping variables on a continuous outcome variable (in this case
# strength differences)

# Summary statistics
# Compute the mean and standard deviation by subgroups
Data_f %>% group_by(Group, EE_average) %>% get_summary_stats(Strength_Differences, type = "mean_sd")

### Checking if ANOVA assumptions are met

# Outliers
Data_f %>% group_by(Group, EE_average) %>% identify_outliers(Strength_Differences)
# There are two outliers - one in control group (extreme outlier) and one in passive group (non extreme)

# Checking if data is normally distributed by groups
Data_f %>% group_by(Group, EE_average) %>% shapiro_test(Strength_Differences)
# One group is not normally distributed - Control Above (p < 0.05)

# Create QQ plots for each cell of design:
ggqqplot(Data_f, "Strength_Differences", ggtheme = theme_bw()) +
         facet_grid(Group ~ EE_average)
# Two outliers identified above do not fall along the reference line
# One extreme outlier in Control Active is responsible for not normal data distribution in that group

# Homogeneity of variance assumption
Data_f %>% levene_test(Strength_Differences ~ Group*EE_average)
# The Levene's test is not significant (p > 0.05) therefore we can assume the homogeneity of variances 
# in different groups

### ANOVA COMPUTATION

# Two-way ANOVA test with interaction effect
aov_test2 = Data_f %>% anova_test(Strength_Differences ~ Group*EE_average)
aov_test2
# There was no statistically significant main effects of  "Group" and "EE_average" on strength differences.
# Also, interactions between "Group" and "EE_average" was also not significant (p > 0.05)

### Investigating the effect of EE_average at every level of Group

# Analyzing simple main effects
# Group data by group and fit anova
model = lm(Strength_Differences ~ Group*EE_average, data = Data_f)
Data_f %>% group_by(Group) %>% anova_test(Strength_Differences ~ EE_average, error = model)
# The simple main effect of "EE_average" on strength differences was statistically significant only
# for Active group

# Pairwise comparison
pairwise_t2 = Data_f %>% group_by(Group) %>% emmeans_test(Strength_Differences ~ EE_average, p.adjust.method = "bonferroni")
pairwise_t2
# There was a significant difference of strength difference between EE_average groups only in Active group

### Inspect main effects

# Pairwise t-test comparison
Data_f %>% pairwise_t_test(Strength_Differences ~ EE_average, p.adjust.method = "bonferroni")
# This pairwise test shows that differences were statistically significant (p < 0.05)

# Pairwise comparison using Emmeans test. This makes it easier to detect any statistically significant differences if they exist
Data_f %>% emmeans_test(Strength_Differences ~ EE_average, p.adjust.method = "bonferroni", model = model)

### VISUALIZATION

# Visualizing
bxp = ggboxplot(Data_f, x = "Group", y = "Strength_Differences", color = "EE_average", palette = "jco")
bxp

# Visualization: box plots with p-values
pairwise_t2 = pairwise_t2 %>% add_xy_position(x = "Group")
bxp + 
  stat_pvalue_manual(pairwise_t2) + 
  labs(subtitle = get_test_label(aov_test2, detailed = TRUE), 
       caption = get_pwc_label(pairwise_t2))


### Investigating the effect of EE_average at every level of Group

# Analyzing simple main effects
# Group data by EE_average and fit anova
Data_f %>% group_by(EE_average) %>% anova_test(Strength_Differences ~ Group, error = model)
# The simple main effect of "Group" on strength differences was no statistically significant on both EE groups

# Pairwise comparison
pairwise_t4 = Data_f %>% group_by(EE_average) %>% emmeans_test(Strength_Differences ~ Group, p.adjust.method = "bonferroni")
pairwise_t4
# There was no significant difference among groups in both EE average groups

# Visualizing
bxp2 = ggboxplot(Data_f, x = "EE_average", y = "Strength_Differences", color = "Group", palette = "jco")
bxp2

# Visualization: box plots with p-values
pairwise_t4 = pairwise_t4 %>% add_xy_position(x = "EE_average")
bxp2 + 
  stat_pvalue_manual(pairwise_t4) + 
  labs(subtitle = get_test_label(aov_test2, detailed = TRUE), 
       caption = get_pwc_label(pairwise_t4))

