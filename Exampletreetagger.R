library(textmining)
library(dplyr)
library(koRpus)
corp <- tmCorpus("predict", package = "stylo")

corp <- tmCorpus(c("This is corp", "Document 2"))
tg_corp <- tmTaggedCorpus(corp)
as.tmCorpus(tg_corp, "lemma")
