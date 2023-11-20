# how to save plots as ppt slides
library(ggplot2)
library(officer)
library(export)

# example data iris
plt1 <- ggplot(iris, aes(x = Species, fill = Species)) + geom_bar()
plt2 <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + geom_point()
plt3 <- ggplot(iris, aes(y = Petal.Length, fill = Species)) + geom_boxplot()

# method 1 using officer , this is useful for ggsurvplot with risk tables
# vectorize the plot, so that each elements of plots are editable in the pptx
plt_vec <- rvg::dml(ggobj = plt1)

# intialize pptx file
pptx <- read_pptx()

# add an empty slide with specific layout and theme
pptx <- add_slide(pptx, layout = "Title and Content", master = "Office Theme")

# add the plot in the slide as a shape
pptx <- ph_with(pptx, plt_vec, location = ph_location_fullsize())

# export the pptx file
print(pptx, target = "plot.pptx")

# method 2 using graph2ppt
graph2ppt(plt1, file = "plot.pptx")

# method 3 all plots in one pptx file, using officer
# vectorize each graphs in a list
plt_vec_list <- lapply(list(plt1, plt2, plt3), \(x){rvg::dml(ggobj = x)})

# initialize pptx file
pptx <- read_pptx()

# add individual plots as a slide in the pptx file
for (p in plt_vec_list){
  pptx <- pptx |> 
    add_slide(layout = "Title and Content", master = "Office Theme") |> 
    ph_with(p, location = ph_location_fullsize())
}

# export the pptx file
print(pptx, target = "plots.pptx")

# method 4 all plots in one pptx file, using export
# iteratively call graph2ppt to append slide to the original file
plt_list <- list(plt1, plt2, plt3)

for (p in plt_list){
  graph2ppt(p, file = "plots.pptx", append = T)
}


