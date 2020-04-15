# foodtrade

The Harmonized System was introduced in 1988 and is administrated by the World Customs Organization (WCO). The WCO prepares amendments updating the HS every <a href="http://www.wcoomd.org/en/topics/nomenclature/overview/what-is-the-harmonized-system.aspx">5-6</a> years. These changes are called revisions and entered into force in 1996, 2002, 2007, 2012 and 2017. OEC dataset uses different HS editions for different time scale:
<br><li>1995-2017 (HS 1992)</li>
<br><li>1998-2017 (HS 1996)</li>
<br><li>2003-2017 (HS 2002)</li>
<br><li>2008-2017 (HS 2007)</li>
<br>I couldn’t find the amendment document in 1996, so I cannot tell what are the changes from the 1992 edition to 1996. In this case, I only studied and cleaned the 1996-2007 edition. I guess the reason we use the 1992 version was because it covers a longer time scale.

According to <a href="https://www.ers.usda.gov/data-products/us-food-imports/documentation/">USDA</a>, Food products are covered by chapters 1 - 22, except chapter 5 (Products of animal origin...) and 14 (Vegetable plaiting materials). 
<br>Note: For items under Chapter 5, the item 0504 (Guts, bladders and stomachs of animals …) actually is regarded as "edible." This chapter indicates that it does not cover edible products except the items of products of animal origin. 

<br>After clean the scale, there are 174 4-digit HS codes on food products. The code for each item category is the same from 1996 to 2007. I created a <a href="https://docs.google.com/spreadsheets/d/1LloSZrLH-NRakJNQImdTdzx5jtlM1Dl5Jw9UWpTkqfU/edit?usp=sharing">Google sheet</a> to show the code and definition of each category. The columns “hs07,” “hs02” and “hs96” indicate the 4-digit HS code we use in the research.

Since the categories for food are the same in HS 1996, 2002 and 2007 edition, I use the HS 1996 edition in my research because among OEC's datasets it covers the most time preiod. The data I use is the "HS6 REV. 1996 (1998 - 2017) - Product Trade between Origin and Destination Country by Year (4 digit depth, bilateral)" dataset from <a href="https://oec.world/en/resources/data/">OEC</a>. I renamed the tsv file I downloaded from OEC as "hscode96" during my data processing.
