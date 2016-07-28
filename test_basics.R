corp1 <- tmCorpus(c("This is number 1", "No 1"))
length(corp1)
corp2 <- tmCorpus(list("This is number 1", "No 1"))
length(corp2)
class(corp2)

corp3 <- tmCorpus(VectorSource(c("one a", "Twwo b")), method = "tm")
corp4 <- tmCorpus(DirSource("predict"), method = "tm")
corp5 <- tmCorpus("predict", method = "stylo")
substr(getDoc(corp5, 1), 1, 100)


corp_stylo <- load.corpus("all", "predict")
corp6 <- as.tmCorpus(corp_stylo)

getDoc(corp6, 1) == getDoc(corp5, 1)

corp_tm <- VCorpus(DirSource("predict"))

corp7 <- as.tmCorpus(corp_tm)

getDoc(corp7, 1) == getDoc(corp4, 1)

print(corp7)
#Get metadata of documents
meta(corp7, "language")
meta(corp7, "title")
meta(corp7, "random")

#content of single document 
content(corp7[[1]])

# get first document
getDoc(corp7, 1) == content(corp7[[1]])

new_doc <- "Ala ma kota"
corp7 <- setDoc(corp7, new_doc, 1)
getDoc(corp7,1)
corp7 <- setMeta(corp7, "language", "pl", 1)
corp7[1]

