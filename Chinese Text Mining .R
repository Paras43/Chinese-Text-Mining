library(quanteda)
library(dplyr)
library(quanteda.corpora)
setwd("/Users/apple/Desktop/Chinese Text Mining/")
getwd()
dir()

YGA <- read.delim("YGA.txt",stringsAsFactors = FALSE)
str(YGA)
YGA_corpus <- VCorpus(VectorSource(YGA))

ch_stop <- stopwords("zh",source = "misc")
ch_toks <- YGA_corpus %>% tokens(remove_punct = TRUE) %>% tokens_remove(pattern=ch_stop)
ch_dfm <- dfm(ch_toks)
topfeatures(ch_dfm)


library(quanteda)
library(dplyr)
setwd("/Users/apple/Desktop/Chinese Text Mining/")
getwd()
dir()
YGA <- read.delim("YGA.txt",stringsAsFactors = FALSE)
str(YGA)
YGA_corpus <- Corpus(VectorSource(YGA))
summary(YGA_corpus)

ch_stop <- stopwords("zh",source = "misc")
ch_toks <- YGA_corpus %>% tokens(remove_punct = TRUE)%>% tokens_remove(pattern=ch_stop)

