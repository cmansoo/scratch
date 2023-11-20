library(survival)
library(survminer)
library(officer)

### example code to export ggsurvplot as pptx
### with risk tables, ggsurvplot seem to have bugs

## w/o risk table
fit <- survfit(Surv(time, status) ~ sex, data = lung)

# plot
ggsurvplot(fit)

# create editable layers
graph_vec <- rvg::dml(ggobj = last_plot())

# initialize empty pptx file as R obj
doc <- read_pptx()
doc <- doc |> add_slide(layout = "Title and Content", master = "Office Theme")

# add the graph vector into slide
doc <- doc |> ph_with(value = graph_vec, location = ph_location_fullsize())

# export to pptx
base::print(doc, target = "C:/Users/A216095/Documents/GitHub/refMHIF-IIRq/demo code/km_only.pptx")


## with risk table

# plot
plt <- ggsurvplot(fit, risk.table = T)
# plt

graph_vec2 <- rvg::dml(code = base::print(plt, newpage = F))

# initialize empty pptx file as R obj
doc2 <- read_pptx()
doc2 <- doc2 |> add_slide(layout = "Title and Content", master = "Office Theme")

# add the graph vector into slide
doc2 <- doc2 |> ph_with(value = graph_vec2, location = ph_location_fullsize())

# export to pptx
base::print(doc2, target = "C:/Users/A216095/Documents/GitHub/refMHIF-IIRq/demo code/with_risk_tbl.pptx")


### you can use export::graph2ppt for simple ggplot obj
### however, km curve throws error, its b/c of blank page
# p <- ggsurvplot(fit)
# export::graph2ppt(x = ggsurvplot(fit),
#                   file = "C:/Users/A216095/Documents/GitHub/refMHIF-IIRq/demo code/graph2_km.pptx")

# you need to get rid of the blank page by setting newpage = F
export::graph2ppt(x = print(ggsurvplot(fit), newpage = F), 
                  file = "C:/Users/A216095/Documents/GitHub/refMHIF-IIRq/demo code/graph2_km.pptx")

export::graph2ppt(x = print(ggsurvplot(fit, risk.table = T), newpage = F), 
                  file = "C:/Users/A216095/Documents/GitHub/refMHIF-IIRq/demo code/graph2_risk.pptx")


