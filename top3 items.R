## import dataset as tradehs96
tradehs02 <- read.table(file = "hscode02.tsv", sep = "\t", header = TRUE)

## install packages
install.packages(c("dplyr", "tidyr"))
library('dplyr')
library('tidyr')

## get the food trade for the whole world
main_food_vague <- tradehs02[tradehs02$hs02 <= 2209, ]
extra_food_vague <- tradehs02[tradehs02$hs02 == c(3301, 3502), ]
all_food <- rbind(main_food_vague, extra_food_vague)
nofood <- c(0101, 0106, 0501, 0502, 0503, 0504,0505,0506,0507,0508,0509,0510,0511, 0601, 0602,0603, 0604, 1209, 1213, 1214, 1401, 1402, 1403,1404,1505, 1518, 1519, 1520,1521,1522, 2207)
nofood_trade <- filter(all_food, hs02 %in% nofood)
foodtrade <- setdiff(all_food, nofood_trade)

##filter China's food trade
chntrade <- filter(foodtrade, origin == "chn" | dest == "chn")
chntrade <- chntrade[,-6]
clean_chn <- subset(chntrade, export_val != "NULL")
dire <- ifelse(clean_chn$origin == "chn", "exports", "imports")
clean_chn$dire <- dire
clean_chn$export_val <- as.numeric(as.character(clean_chn$export_val))

##separate import and export
chn_imports <- filter(clean_chn, dire == "imports")
chn_exports <- filter(clean_chn, dire == "exports")

##sum each year each country's trade value
im_year_country <- chn_imports %>%
  group_by(year, origin) %>%
  summarize(total = sum(export_val))

ex_year_country <- chn_exports %>%
  group_by(year, dest) %>%
  summarize(total = sum(export_val))

##selet the top 10 for each year and rank
im_top10 <- im_year_country %>%
  subset(origin != "xxb") %>%
  top_n(n = 10, wt = total) %>%
  mutate(row_number = row_number(desc(total)))

ex_top10 <- ex_year_country %>%
  subset(dest != "xxb") %>%
  top_n(n = 10, wt = total) %>%
  mutate(row_number = row_number(desc(total)))

##find the top trade countries and their trade record
tops <- union(im_top10$origin, ex_top10$dest)
top_countries <- filter(clean_chn, origin %in% tops | dest %in% tops)

##find top 3 items
top3_im_items <- top_countries %>%
  filter(origin != "chn") %>%
  group_by(year, origin) %>%
  top_n(n = 3, wt = export_val) %>%
  mutate(row_number = row_number(desc(export_val)))

top3_ex_items <- top_countries %>%
  filter(dest != "chn") %>%
  group_by(year, dest) %>%
  top_n(n = 3, wt = export_val) %>%
  mutate(row_number = row_number(desc(export_val)))

