# setup -------------------------------------------------------------------
library(philsfmisc)
# library(data.table)
library(tidyverse)
library(readxl)
# library(haven)
# library(foreign)
library(lubridate)
# library(naniar)
library(labelled)

# data loading ------------------------------------------------------------
set.seed(42)
data.raw <- read_csv("dataset/atq septuagenarios clean.csv")
# data.raw <- read_excel("dataset/file.xlsx") %>%
#   janitor::clean_names()

Nvar_orig <- data.raw %>% ncol
Nobs_orig <- data.raw %>% nrow

# data cleaning -----------------------------------------------------------

data.raw <- data.raw %>%
  rename(
    id = prontuario,
    outcome = comp_qualquer,
    ) %>%
  # select() %>%
  mutate() %>%
  filter()

# data wrangling ----------------------------------------------------------

data.raw <- data.raw %>%
  mutate(
    id = factor(id), # or as.character
    idade = floor(as.duration(data_de_nascimento %--% dia_da_cirurgia)/dyears(1)),
    group = factor(idade >= 70, labels = c("<70", "70+")),
    asa = factor(asa),
  )

# labels ------------------------------------------------------------------

data.raw <- data.raw %>%
  set_variable_labels(
    group = "Study group",
    outcome = "Study outcome",
  )

# analytical dataset ------------------------------------------------------

analytical <- data.raw %>%
  # select analytic variables
  select(
    id,
    group,
    outcome,
    idade,
    sexo,
    has,
    asa,
    dm,
    tabagismo,
  )

Nvar_final <- analytical %>% ncol
Nobs_final <- analytical %>% nrow

# mockup of analytical dataset for SAP and public SAR
analytical_mockup <- tibble( id = c( "1", "2", "3", "...", "N") ) %>%
# analytical_mockup <- tibble( id = c( "1", "2", "3", "...", as.character(Nobs_final) ) ) %>%
  left_join(analytical %>% head(0), by = "id") %>%
  mutate_all(as.character) %>%
  replace(is.na(.), "")
