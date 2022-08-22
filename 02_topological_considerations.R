library(plyr)
#Topological considerations
data <- read.csv("data/raw/raw_grns.csv")

data <- data[,5:16]

GRNs <- sign(data)

singleGRNS <- ddply(GRNs, .(MA,AA,BA,CA,MB,AB,BB,CB,MC,AC,BC,CC), nrow)

net <- singleGRNS[,-13]

net1 <- data.matrix(net)
net2 <- data.matrix(net)
net3 <- data.matrix(net)
net4 <- data.matrix(net)
net5 <- data.matrix(net)
net6 <- data.matrix(net)

#MA 1
#AA 2
#BA 3
#CA 4
#MB 5
#AB 6
#BB 7
#CB 8
#MC 9
#AC 10
#BC 11
#CC 12

#[, c(1,2,3,4,5,6,7,8,9,10,11,12)]
net2 <- net2[, c(5,7,6,8,1,3,2,4,9,11,10,12)] # ABC -> BAC
net3 <- net3[, c(9,12,11,10,5,8,7,6,1,4,3,2)] # ABC -> CBA
net4 <- net4[, c(5,7,8,6,9,11,12,10,1,3,4,2)] # ABC -> BCA
net5 <- net5[, c(9,12,10,11,1,4,2,3,5,8,6,7)] # ABC -> CAB
net6 <- net6[, c(1,2,4,3,9,10,12,11,5,6,8,7)] # ABC -> ACB

net <- data.frame(net1,net2,net3,net4,net5,net6)
colnames(net) <- NULL
net <- data.matrix(net)

redundant_source <- c()
redundant_target <- c()
redundant_permute <- c()

for(i in seq(1, length(net[,1]))){
  flag_redundant <- FALSE
  i_net <- net[i,1:12]
  if(i %in% redundant_target){
    next
  }
  for(j in seq(1, length(net[,1]))){
    for(k in seq(2,5)){
      if(j!=i){
        j_net <- net[j,(1+(k-1)*12):(k*12)]
        if(sum(i_net==j_net)==12){
          flag_redundant <- TRUE
          redundant_source <- append(redundant_source, i)
          redundant_target <- append(redundant_target, j)
          redundant_permute <- append(redundant_permute, k)
          break
        }
      }
    }
  }
  print(i)
}

for(i in seq(1, length(redundant_source))){
  singleGRNS$V1[redundant_source[i]] <- singleGRNS$V1[redundant_source[i]] +
    singleGRNS$V1[redundant_target[i]]
}

singleGRNS <- singleGRNS[c(-redundant_target), ]
write.csv(singleGRNS, "output/singletopologies.csv")


