library(devtools) 
install_github('jandziak/textmining')
library(textmining)
library(rJava)
corp <- tmCorpus("train", method = "stylo")
model <- train(corp)
new_corp <- tmCorpus("predict", method = "stylo")
pred_old <- predict(model, newdata = corp)
pred_new <- predict(model, newdata = new_corp)

table <- topic_table(model)

topic_wordcloud(model, topic_id = 1, k = 100)
  
network <- gepi_network(20 ,table$words)
network
