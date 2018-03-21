# ------------------------
# ------------------------
# Plot functions
# ------------------------
# ------------------------

library(tidyverse)


# ------------------------
# Single run output

plot.single = function(i){
   i %>% 
      gather(variable, value, -time) %>% 
      ggplot(aes(time, value)) +
      geom_line() +
      facet_wrap(~variable) +
      scale_y_continuous(breaks= scales::pretty_breaks()) +
      labs(title="Cars passing through a barrier",
           x="Time (seconds)",
           y="Cars") +
      theme_linedraw()
}
