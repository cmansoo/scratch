# how to save ggsurvplots with risk tables
library(survival)
library(survminer)
library(officer)

# fit a simple KM curve with lung dataset
# with risk table
fit_risk <- survfit(Surv(time, status) ~ sex, data = lung)
plt_risk <- ggsurvplot(fit, risk.table = T)
plt

# use a specific funciton from survminer
# the ::: operator allows access to hidden objects in the package.
test <- survminer:::.build_ggsurvplot(plt)

# save 1 - throws an error
# ggsave(plot = plt, file = "km_curve_table.tiff", compress = "lzw")

# vs.

# save 1
ggsave(file = "km_curve_table.tiff",
       plot = survminer:::.build_ggsurvplot(plt),
       compress = "lzw" # make the file size smaller
       )

# does not work and saves empty page
# ggsave(file = "km_curve_table.tiff",
#        plot = print(plt, newpage = F),
#        compress = "lzw"
#        )

# save as ppt
# vectorize plot
plt_vec <- rvg::dml(code = print(plt, newpage = F))
# initialize ppt file
slide <- read_pptx()
# add slide
slide <- add_slide(slide, layout = "Title and Content", master = "Office Theme")
# add a new shape in the slide
slide <- ph_with(slide, plt_vec, location = ph_location_fullsize())
# export as pptx file
print(slide, target = "km_curve_table.pptx")
