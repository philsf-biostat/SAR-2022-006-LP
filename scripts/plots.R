# setup -------------------------------------------------------------------
# library(survminer)

ff.col <- "steelblue" # good for single groups scale fill/color brewer
ff.pal <- "Paired"    # good for binary groups scale fill/color brewer

scale_color_discrete <- function(...) scale_color_brewer(palette = ff.pal, ...)
scale_fill_discrete <- function(...) scale_fill_brewer(palette = ff.pal, ...)

gg <- analytical %>%
  ggplot() +
  theme_ff()

# plots -------------------------------------------------------------------

gg.outcome <- gg +
  geom_bar(aes(group, fill = outcome), position = "fill") +
  scale_y_continuous(labels = scales::label_percent()) +
  labs(fill = attr(analytical$outcome, "label")) +
  xlab(attr(analytical$idade, "label")) +
  ylab("")

