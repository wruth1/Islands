data = read.csv("City_Sizes.csv")

buildings.list = sapply(1:nrow(data), function(i){
  island = data[i, "Island"]
  city = data[i,"Name"]
  build.count = data[i,"Buildings"]
  this.buildings = paste0(island, "-", city, "-", 1:build.count)
  return(this.buildings)
})

buildings = unlist(buildings.list)
n.build = length(buildings)


#Generate an SRS of n buildings from all buildings on the islands
get.sample = function(n){
  my.indices = sample(1:n.build, n)
  my.sample = buildings[my.indices]
  my.sample.ordered = sort(my.sample)
  return(my.sample.ordered)
}