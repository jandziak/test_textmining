library(textmining)
library(mallet)
corp <- tmCorpus("train", package = "stylo")
corp
dtm_corp <- DocumentTermMatrix(corp)
k <- 30
SEED <- 1231452
Gibbs = train(dtm_corp, k = k, method = "Gibbs",
              control = list(seed = SEED, burnin = 10,
                             thin = 100, iter = 100))
model <- train(corp, k = 10)
terms(model, 1000)
class(corp) <- "tmCorpus"
new_corp <- tmCorpus("predict", package = "stylo")
new_dtm_corp <- DocumentTermMatrix(new_corp)

pred_old <- predict(Gibbs, new_dtm_corp)
pred_new <- predict(model, new_corp)

table <- topic_table(model)

topic_wordcloud(model, topic_id = 1, k = 100)
topic_wordcloud(Gibbs, topic_id = 1, k = 100)

network <- topic_network(20, model = model)
network

network_1 <- topic_network(20, model = Gibbs)
network_1
# Create mallet topic model using implemented stopwordslist
model <- train(corp, 20, c("Ala", "Ma", "Kota", "ala", "ma", "kota"))
pred <- predict(model, new_corp)