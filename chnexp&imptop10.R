## filter China's trade activites, save as chntrade
chntrade <- subset(finalsumhs96, origin == "chn" | dest == "chn")

dire <- ifelse(chntrade$origin == "chn", "exports", "imports")
chntrade$dire <- dire

## create and add a new col with all trade partners
country <- ifelse(chntrade$origin == "chn", chntrade$dest, chntrade$origin)
chntrade$country <- country

## delete origin and dest
cleanchntrade <- chntrade[,-c(2:3)]

sumnoclass <- tapply(cleanchntrade$Freq, cleanchntrade[ ,c("year", "dire", "country")], sum)
sumnoclass <- as.data.frame.table(sumnoclass)
sumnoclass <- na.omit(sumnoclass)

chnimport <- subset(sumnoclass, dire == "imports")
chnexport <- subset(sumnoclass, dire == "exports")

chnimp10 <- chnimport %>%
  group_by(year) %>%
  top_n(n = 10, wt = Freq)

chnexp10 <- chnexport %>%
  group_by(year) %>%
  top_n(n = 10, wt = Freq)
