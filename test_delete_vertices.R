library("igraph")

#g <- make_star(10, mode="undirected") %>% set_vertex_attr("name", value = 1:10)

#plot(g)

#reduced_g <- delete_vertices(g, lapply(1:8, toString))

#reduced_g <- delete_vertices(g, 1:8)

#check previous stack overflow question to solve this issue
#reduced_g <- delete_vertices(g, 1)

#plot(reduced_g)

g <- erdos.renyi.game(14, 1/10)
plot(g)