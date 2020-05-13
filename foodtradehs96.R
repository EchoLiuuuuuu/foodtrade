## import dataset as tradehs96
tradehs02 <- read.table(file = "hscode02.tsv", sep = "\t", header = TRUE)

## install packages
install.packages(c("dplyr", "tidyr"))
library('dplyr')
library('tidyr')

## select the records under the HS code Chapter 1-22 as chapterhs96, delete col import_val
chapterhs02 <- tradehs02[tradehs02$hs02 <= 2209, -6]

## clean all NULL data
cleanchapterhs02 <- subset(chapterhs02, export_val != "NULL")

## classify each record into "meat" (101-410), "veg" (601-1302), "others" (1501-2209), "omit", name it class 
class <- ifelse(cleanchapterhs02$hs02 <= 410, "meat",
            ifelse(cleanchapterhs02$hs02 >= 601 & cleanchapterhs96$hs96 <= 1302, "veg",
                ifelse(cleanchapterhs02$hs02 >= 1501 & cleanchapterhs96$hs96<= 2209, "others", "omit")
         ))

## add class to cleanchapterhs96
cleanchapterhs02$class <- class

## combine origin and dest, name the new col flow, save the new dataframe as forsumhs96
forsumhs02 <- unite(cleanchapterhs02, "flow", origin, dest, remove = FALSE)

##sum data by year, flow and class
forsumhs02$export_val <- as.numeric(as.character(forsumhs02$export_val))
sumhs02 <- tapply(forsumhs02$export_val, forsumhs02[ ,c("year", "flow", "class")], sum)
sumhs02 <- as.data.frame.table(sumhs02)

##delete NA rows
sumhs02 <- na.omit(sumhs02)

## separate flow into origin and dest
finalsumhs02 <- separate(sumhs02, "flow", into = c("origin", "dest"), sep = "_")

## export a csv file
write.table(finalsumhs02, file = "finalsumhs02.csv", sep = ",", row.names=FALSE)
