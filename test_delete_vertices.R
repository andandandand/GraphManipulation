library("igraph")

g <- make_star(10, mode="undirected")

plot(g)

reduced_g <- delete_vertices(g, lapply(1:8, toString))

reduced_g <- delete_vertices(g, 1:8)


plot(reduced_g)