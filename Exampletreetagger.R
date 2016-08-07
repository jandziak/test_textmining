library(textmining)
library(dplyr)
library(koRpus)
corp <- tmCorpus("predict", package = "stylo")
rd <- tagtmCorpus_helper(corp, treetagger = "manual",
                         lang = "en", TT.options = list(path = "C:\\TreeTagger",
                                                        preset = "en"))

corp <- tmCorpus(c("This is corp", "Document 2"))
tg_corp <- tmTaggedCorpus(corp)
as.tmCorpus(tg_corp, "lemma")