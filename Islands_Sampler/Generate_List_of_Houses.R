library(dplyr)

data = read.csv("City_Sizes.csv")

buildings.list = sapply(1:nrow(data), function(i){
  island = data[i, "Island"]
  city = data[i,"Name"]
  build.count = data[i,"Buildings"]
  this.buildings = expand.grid(island, city, 1:build.count)
  return(this.buildings)
}, simplify=F)

buildings = bind_rows(buildings.list)
colnames(buildings) = c("Island", "City", "House")
n.build = nrow(buildings)


#Generate an SRS of n buildings from all buildings on the islands
get.sample.all = function(n){
  num.buildings = sum(data$Buildings)
  my.indices = sample(1:num.buildings, n)
  my.sample = buildings[my.indices,]
  return(my.sample)
  # my.sample.ordered = my.sample[order(my.sample$Island,
  #                                     my.sample$City,
  #                                     my.sample$House),]
  # return(my.sample.ordered)
}

get.sample.island = function(n, island){
  my.data = filter(data, Island == eval(island))
  my.buildings = filter(buildings, Island == eval(island))
  num.buildings = sum(my.data$Buildings)
  my.indices = sample(1:num.buildings, n)
  my.sample = my.buildings[my.indices,]
  return(my.sample)
  # my.sample.ordered = my.sample[order(my.sample$Island,
  #                                     my.sample$City,
  #                                     my.sample$House),]
  # return(my.sample.ordered)
}

get.sample = function(n, type){
  if(type == "All"){
    my.sample = get.sample.all(n)
  } else{
    my.sample = get.sample.island(n, type)
  }
  return(my.sample)
}
