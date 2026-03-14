# PSYC2001 Assignment Data Analysis Script
# This script analyzes the data for the PSYC2001 assignment
###############################################################################

performStats <- function(dat){
# 
library(here) 
library(tidyverse)

dat <- dat %>%
  mutate(group = factor(group, levels = c(1, 2), labels = c("Group 1", "Group 2"))) 

###############################################################################


###############################################################################
# 
paired_t_test_result <- t.test(dat$v1, dat$v2, paired = TRUE)

###############################################################################
# 
independent_t_test_v1_group <- t.test(v1 ~ group, data = dat, var.equal=TRUE)

###############################################################################
# 
one_sample_t_test_v1 <- t.test(dat$v1, mu = 0)

###############################################################################
# 
correlation_v1_v2 <- cor.test(dat$v1, dat$v2)

###############################################################################
# 
independent_t_test_v2_group <- t.test(v2 ~ group, data = dat, var.equal=TRUE)

###############################################################################
# 
one_sample_t_test_v2 <- t.test(dat$v2, mu = 0)

###############################################################################

marking_info <- list(paired_t = paired_t_test_result,
                     indy_v1 = independent_t_test_v1_group, 
                     one_samp = one_sample_t_test_v1, 
                     cor = correlation_v1_v2,
                     indy_v2 = independent_t_test_v2_group,
                     one_samp_v2 = one_sample_t_test_v2)
return(marking_info)

}
