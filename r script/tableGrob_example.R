library(survival)
library(survminer)
library(dplyr)
library(tidyr)

### demo to create a custom risk table and
### add it to the original plot using gridExtra::tableGrob
### and related gtable methods

# add strata
lung1 <- lung |> mutate(group = sample(c("pre", "post"), nrow(lung), replace = T))

# example curve
km <-  survfit(Surv(time, status) ~ sex + group, data = lung1)
g <- ggsurvplot(km, facet.by = "group", risk.table = T)
# g

g2 <- ggsurvplot(km, risk.table = T)
# g2

# g3 <- ggsurvplot(km)

# survtable data
df_surv <- g2$data.survtable
df <- df_surv |> 
  select(strata, time, n.risk) |> 
  pivot_wider(names_from = time, 
              values_from = n.risk, 
              names_glue = "t{time}")

# add days row
df <- df |> mutate(across(everything(), ~as.character(.x)))
day <- df_surv |> pull("time") |> unique()
day <- c("days", day)

df <- rbind(day, df)

# create tableGrob (graphical table element)
# require(gridExtra)
tb <- gridExtra::tableGrob(df, rows = NULL, cols = NULL, theme = gridExtra::ttheme_minimal())
title <- grid::textGrob("Number at risk", gp = grid::gpar(fontsize = 13))
padding <- unit(.5, "in")

# create an empty row and add the title
tb1 <- gtable::gtable_add_rows(tb, heights = grid::grobHeight(title) + padding, pos = 0)
tb1 <- gtable::gtable_add_grob(tb1, title, t = 1, l = 1, r = ncol(tb1))

# test, run two lines together
grid::grid.newpage()
grid::grid.draw(tb1)

# combine with survplot
p <- gridExtra::grid.arrange(g, tb1, nrow = 2, heights = c(3, 1))
p

# p |> ggsave(filename = "demo.png", width = 7, height = 8)




