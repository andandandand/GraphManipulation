library("igraph")

star6 <- make_star(6, mode="undirected")

delstar6 <- delete_vertices(star6, c("2", "3"))

plot(delstar6)