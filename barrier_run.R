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

x %>% 
   gather(variable, value, -time, -run) %>% 
   ggplot(aes(time, value)) +
   stat_density_2d(geom="raster",
                   aes(fill=..density..),
                   contour=F) +
   scale_fill_viridis(option="magma", labels=scales::percent_format()) +
   facet_wrap(~ variable) +
   theme_linedraw() +
   labs(title="Probabilistic simulation of cars passing a barrier",
        subtitle="Barrier time: 5 to 15 seconds\nCars: 15\nCar speed: 10-20 mph",
        x="Time (seconds)",
        y="Number of cars",
        fill="Model runs")
