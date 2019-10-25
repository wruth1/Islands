library(tidyverse)

data.raw = read.csv("Hill_Running.csv")

data = mutate(data.raw, Change = After - Before,
              rel.change = Change/Before)

hist(data$rel.change)

Uphill = (data$Type == "Up")

Up.Change = data[Uphill,"Change"]
Down.Change = data[!Uphill, "Change"]
test.Change = t.test(Up.Change, Down.Change)

Up.rel.change = data[Uphill, "rel.change"]
Down.rel.change = data[!Uphill, "rel.change"]
test.rel.change = t.test(Up.rel.change, Down.rel.change)
