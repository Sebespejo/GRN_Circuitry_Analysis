library(vegan)

#Analysis of diversity of GRNs mechanisms

singletopologies <- read.csv("output/singletopologies.csv")

singletopologies$V1


png(file = "figs/abundancehistogram.png")

hist(singletopologies$V1, breaks = 30, xlab = "Number of GRN ocurrances",
     ylab = "Number of topologies", col = "orange", main = "Abundance of 
     topologies")

dev.off()

#I also can use a diversity index

diversity(singletopologies$V1,"shannon")

#To check diversity of the GRN population I can calculate Renyi's profile
#which 
renyiGRNS <- renyi(singletopologies$V1)
