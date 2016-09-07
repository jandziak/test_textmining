corp1 <- tmCorpus(c("This is number 1", "No 1"), random = c("1", ":2"))
length(corp1)
corp2 <- tmCorpus(list("This is number 1", "No 1"), random = c("1", ":2"))
length(corp2)
class(corp2)

corp3 <- tmCorpus(VectorSource(c("one a", "Twwo b")), package = "tm")
corp4 <- tmCorpus(DirSource("predict"), package = "tm")
corp5 <- tmCorpus("predict", package = "stylo", encoding = "UTF-8")
substr(getDoc(corp4, 1), 1, 100)


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
meta(corp1, "random")

#content of single document 
content(corp7[[1]])

# get first document
getDoc(corp7, 1) == content(corp7[[1]])

new_doc <- "Ala ma kota"
corp7 <- setDoc(corp7, new_doc, 1)
getDoc(corp7,2)
corp7 <- setMeta(corp7, "language", "pl", 1)
corp7[1]

new <- corp7[c(1,3,5)]
class(new) <- "tmCorpus"
tm_filter(corp7, function(x) getMeta(x, "language") == "pl")

a <- tm_filter(corp, FUN = function(x) meta(x, "language") == "en")
