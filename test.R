library(devtools) 
install_github('jandziak/textmining')
library(textmining)
corp <- tmCorpus(source = "train", method = "stylo")
model <- train(corp)
new_corp <- tmCorpus(source = "predict", method = "stylo")
pred_old <- predict(model, x = corp)
pred_new <- predict(model, x = new_corp)

table <- topic_table(model, corp)

topic_wordcloud(table, topic_id = 1, no_of_words = 100)
  
network <- gepi_network(10 ,table$words)
network