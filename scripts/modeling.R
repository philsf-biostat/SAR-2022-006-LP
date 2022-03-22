# setup -------------------------------------------------------------------
# library(moderndive)
library(broom)
# library(lmerTest)
# library(broom.mixed)
# library(simputation)
# library(mice)

# raw estimate ------------------------------------------------------------

mod_crude <- glm(outcome ~ group, family = binomial, analytical)

# adjusted ----------------------------------------------------------------

mod_full <- glm(outcome ~ group + sexo + has + asa + dm + tabagismo, family = binomial, analytical)

anova(mod_crude, mod_full, test = "Chisq")
mod_full %>% tidy
mod_full %>% augment

tab_inf <- tbl_merge(list(
  mod_crude %>% tbl_regression(exp = TRUE),
  mod_full %>% tbl_regression(exp = TRUE)
))

