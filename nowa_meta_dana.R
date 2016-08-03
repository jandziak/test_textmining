x <- tmCorpus(c("a, ", "b"), language = "en")
meta(x, "language") <- c("pl", "en")
meta(x, "language")
x <- tmCorpus(c("a, ", "b"), random = "POS")
meta(x, "random")
meta(x, "random") <- c("Pos1","POS")
meta(x, "random")
meta(x, "random1") <- c("Pos1","POS")

x <- tmCorpus("predict", package = "stylo", random = "POS")
meta(x, "random")

x <- tmCorpus(DirSource("predict"), package = "tm", random = "POS")
meta(x, "random")
