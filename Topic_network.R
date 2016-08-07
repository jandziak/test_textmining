x <- tmCorpus(rep("as, a , a ,s  l k l l k k j h g f f hg j aaa", 100))
require(mallet)
model <- suppressMessages(train(x, stoplist_file = c("ala", "ma")))
network <- topic_network(10 ,model)
network



x <- tmCorpus(lapply(1:100, function(x) paste(sample(LETTERS, 11),
                                              collapse = "")))
y <- tm::DocumentTermMatrix(x)
rownames(y) <- meta(x, "title")
model <- suppressMessages(train(y, package = "topicmodels"))
network <- topic_network(10 ,model)
network