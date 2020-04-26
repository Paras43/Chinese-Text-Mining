library(quanteda)
library(dplyr)
library(quanteda.corpora)
library(tidytext)
library(knitr)
library(ggplot2)
library(readtext)
setwd("/Users/apple/Desktop/Chinese Text Mining/")
getwd()
dir()
YGA <- readtext("/Users/apple/Desktop/Chinese Text Mining/YGA.txt")
YGA_corpus <- corpus(YGA)
ch_stop <- stopwords("zh",source = "misc")
ch_YGA <- YGA_corpus[-grep("\\b\\d+\\b",YGA_corpus$metadata),] # Remove the number.
ch_YGA <- gsub("\\s+","",ch_YGA) # Remove the white stripe.
ch_YGA <- ch_YGA %>% tokens(remove_punct = TRUE) %>% tokens_remove(pattern=ch_stop) # Remove punctuation and stop words.
ch_dfm <- dfm(ch_YGA)
topfeatures(ch_dfm)
kable(textstat_frequency(ch_dfm)%>%head(n=15))
---------------------------------------------------
### main Analysis:###
# plot a word cloud.
set.seed(50)
textplot_wordcloud(ch_dfm, min_count = 40, random_order = FALSE,rotation = .25, max_words = 100,min_size = 0.5, max_size = 2.8,font = if (Sys.info()['sysname'] == "Darwin") "SimHei" else NULL,color = RColorBrewer::brewer.pal(8, "Dark2"))
# Collocation. 
Collocation <- textstat_collocations(ch_YGA,size=2, min_count = 20)
kable(head(Collocation,20)) ## how to make a good table visualization.
# Association.
ch_fcm <- fcm(ch_YGA,context = "window")
topfeatures(ch_fcm["发展",])
# Key words.
kwic(ch_YGA,"建设") %>% head(n=15)
# Frequency plots.
ch_fre <- textstat_frequency(ch_dfm,n=10)
ggplot(data = ch_fre)+geom_bar(mapping = aes(x=reorder(feature,-frequency),y=frequency),stat = "identity",fill=c("red","red","grey","grey","grey","grey","grey","grey","grey","grey"))
------------------------------------------------------
### Subsidiary Analysis ###
# Entropy
textstat_entropy(ch_dfm)
# lexical diversity 
textstat_lexdiv(ch_YGA,measure = "TTR")