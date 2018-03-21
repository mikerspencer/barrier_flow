# ------------------------
# ------------------------
# Model functions
# ------------------------
# ------------------------


# ------------------------
# Queue growth and decay model

barrier.model = function(barrier = 10,
                         cars = 10,
                         cars.speed = 20){
   # 4 metre car with 2 second gap
   cars.flow = 2 + 4 / (cars.speed * 16/36)
   
   # Queue growing
   x = 0:(cars.flow * cars * 1.5)
   x = data.frame(time=x,
                  cars.queue=floor(x / cars.flow) - floor(x / barrier),
                  cars.carpark=floor(x / barrier))
   
   # Car limit
   y = x[(x$cars.queue + x$cars.carpark)==cars, ][1, ]
   
   # Queue clearing
   z = y$time:(cars * barrier + (barrier/2))
   z = data.frame(time=z,
                  cars.queue=y$cars.carpark + y$cars.queue - floor(z / barrier),
                  cars.carpark=floor(z / barrier))
   
   # Joining model sections
   rbind(x[x$time<y$time, ], z)
}

