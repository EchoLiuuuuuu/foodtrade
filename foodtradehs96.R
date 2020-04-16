## import dataset as tradehs96
tradehs96 <- read.table(file = "hscode96.tsv", sep = "\t", header = TRUE)

## install packages
install.packages(c("dplyr", "tidyr"))
library('dplyr')
library('tidyr')

## select the records under the HS code Chapter 1-22 as chapterhs96, delete col import_val
chapterhs96 <- tradehs96[tradehs96$hs96 <= 2209, -6]

## clean all NULL data
cleanchapterhs96 <- subset(chapterhs96, export_val != "NULL")

## classify each record into "meat" (101-410), "veg" (601-1302), "others" (1501-2209), "omit", name it class 
class <- ifelse(cleanchapterhs96$hs96 <= 410, "meat",
            ifelse(cleanchapterhs96$hs96 >= 601 & cleanchapterhs96$hs96 <= 1302, "veg",
                ifelse(cleanchapterhs96$hs96 >= 1501 & cleanchapterhs96$hs96<= 2209, "others", "omit")
         ))

## add class to cleanchapterhs96
cleanchapterhs96$class <- class

## combine origin and dest, name the new col flow, save the new dataframe as forsumhs96
forsumhs96 <- unite(cleanchapterhs96, "flow", origin, dest, remove = FALSE)

##sum data by year, flow and class
forsumhs96$export_val <- as.numeric(as.character(forsumhs96$export_val))
sumhs96 <- tapply(forsumhs96$export_val, forsumhs96[ ,c("year", "flow", "class")], sum)
sumhs96 <- as.data.frame.table(sumhs96)

##delete NA rows
sumhs96 <- na.omit(sumhs96)

## separate flow into origin and dest
finalsumhs96 <- separate(sumhs96, "flow", into = c("origin", "dest"), sep = "_")

## export a csv file
write.table(finalsumhs96, file = "finalsumhs96.csv", sep = ",", row.names=FALSE)
