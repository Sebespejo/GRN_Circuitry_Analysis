#GRN diversity analysis
library(plyr)

GRNs <- read.csv("data/processed/GRNs.csv")

#GRN extraction
signGRN <- sign(GRNs)
signGRN[1, ]#First GRN

#Unique circuits with duplications
duplicatedcircuits <- unique(signGRN)
abs(duplicatedcircuits)

#Number of times each circuit appers
singleGRNS <- ddply(signGRN, .(MA,AA,BA,CA,MB,AB,BB,CB,MC,AC,BC,CC), nrow)


numbinteracGRN <- ddply(abs(duplicatedcircuits), .(MA,AA,BA,CA,MB,AB,BB,CB,MC,AC,BC,CC), sum)


GRNScomplexity <- transform(abs(duplicatedcircuits), sum = rowSums(abs(duplicatedcircuits)))
complexitylist <- GRNScomplexity[ , length(GRNScomplexity)] #List of complexity value per type of circuit
class(complexitylist)

#Histogram
png(file = "figs/complexityhistogram.png")
# Create the histogram.
hist(complexitylist, xlab = "Weight",col = "darkcyan")

dev.off()
