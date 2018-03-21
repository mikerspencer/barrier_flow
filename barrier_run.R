# ------------------------
# ------------------------
# Model run
# ------------------------
# ------------------------

library(tidyverse)

source("./barrier_functions.R")
source("./plot_functions.R")


# ------------------------
# Single run

barrier.model() %>% 
   plot.single()


# ------------------------
# Probabilistic run

params = list(barrier = 5:15,
              cars = 15,
              cars.speed = 10:20)
params = expand.grid(params)

x = lapply(1:nrow(params), function(i){
   print(i)
   y = barrier.model(barrier=params[i, "barrier"],
                 cars=params[i, "cars"],
                 params[i, "cars.speed"])
   y$run = i
   y
})
x = do.call("rbind.data.frame", x)

library(viridis)

ggplot(x, aes(time, cars.queue)) +
   stat_density_2d(geom="raster",
                   aes(fill=..density..),
                   contour=F) +
   scale_fill_viridis() +
   theme_linedraw()
