##For top 10 CHN partner
## filter China's trade activites, save as chntrade
chntrade <- subset(finalsumhs96, origin == "chn" | dest == "chn")

dire <- ifelse(chntrade$origin == "chn", "exports", "imports")
chntrade$dire <- dire

## create and add a new col with all trade partners
country <- ifelse(chntrade$origin == "chn", chntrade$dest, chntrade$origin)
chntrade$country <- country

## delete origin and dest
cleanchntrade <- chntrade[,-c(2:3)]

## sum total trade val by year, by ex/import, by country
sumnoclass <- tapply(cleanchntrade$Freq, cleanchntrade[ ,c("year", "dire", "country")], sum)
sumnoclass <- as.data.frame.table(sumnoclass)
sumnoclass <- na.omit(sumnoclass)

##make two table for export and import data
chnimport <- subset(sumnoclass, dire == "imports")
chnexport <- subset(sumnoclass, dire == "exports")

## select the top 10 countries by im/export by year
chnimp10 <- chnimport %>%
  group_by(year) %>%
  top_n(n = 10, wt = Freq)

chnexp10 <- chnexport %>%
  group_by(year) %>%
  top_n(n = 10, wt = Freq)

## rank the top 10 
imprank <- chnimp10 %>%
  group_by(year) %>%
  arrange(Freq) %>%
  mutate(row_number = row_number(desc(Freq)))

exprank <- chnexp10 %>%
  group_by(year) %>%
  arrange(Freq) %>%
  mutate(row_number = row_number(desc(Freq)))



##For worldwide top 10
##sum each countries' export val by year
sumexpyear <- tapply(finalsumhs96$Freq, finalsumhs96[,c("year", "origin")], sum)
tsumexpyear = t(sumexpyear)
forrank <- as.data.frame.table(tsumexpyear)

## select the top 10 countries by year
worldtop10 <- forrank %>%
  group_by(year) %>%
  top_n(n = 10, wt = Freq)

## rank the top 10 
worldexp10 <- worldtop10 %>%
  group_by(year) %>%
  arrange(Freq) %>%
  mutate(row_number = row_number(desc(Freq)))

##sum each countries' import val by year
sumimpyear <- tapply(finalsumhs96$Freq, finalsumhs96[,c("year", "dest")], sum)
tsumimpyear = t(sumimpyear)
forrank2 <- as.data.frame.table(tsumimpyear)

## select the top 10 countries by year
worldtop102 <- forrank2 %>%
  group_by(year) %>%
  top_n(n = 10, wt = Freq)

## rank the top 10 
worldimp10 <- worldtop102 %>%
  group_by(year) %>%
  arrange(Freq) %>%
  mutate(row_number = row_number(desc(Freq)))

## export both tables for world top 10
write.table(worldexp10, file = "worldexp10.csv",sep = ",", row.names=FALSE)
write.table(worldimp10, file = "worldimp10.csv",sep = ",", row.names=FALSE)
