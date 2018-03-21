barrier = 10
cars = 10
cars.speed = 20

# 4 metre car with 2 second gap
cars.flow = 2 + 4 / (cars.speed * 16/36)


x = 0:100
x = data.frame(time=x,
               cars.queue=floor(x / cars.flow) - 
                  floor(x / barrier),
               cars.carpark=floor(x / barrier))

y = x[(x$cars.queue + x$cars.carpark)==cars, ][1, ]

z = y$time:(cars * barrier + (barrier/2))
z = data.frame(time=z,
               cars.queue=y$cars.carpark + y$cars.queue - 
                  floor(z / barrier),
               cars.carpark=floor(z / barrier))

x = rbind(x[x$time<y$time, ],
          z)

