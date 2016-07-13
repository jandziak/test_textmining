library(devtools) 
install_github('jandziak/textmining')
library(textmining)

library(SnowballC)


# create corpus from vector
docs <- tmCorpus(x = DirSource("predict"), method = "tm")
#start preprocessing
#Transform to lower case
docs <-tm_map(docs,content_transformer(tolower))

#remove potentially problematic symbols
toSpace <- content_transformer(function(x, pattern) 
  { return (gsub(pattern, " ", x))})

docs <- tm_map(docs, toSpace, "-")
docs <- tm_map(docs, toSpace, "’")
docs <- tm_map(docs, toSpace, "‘")
docs <- tm_map(docs, toSpace, "•")
docs <- tm_map(docs, toSpace, "\"")
docs <- tm_map(docs, toSpace, "'")

#remove punctuation
docs <- tm_map(docs, removePunctuation)
#Strip digits
docs <- tm_map(docs, removeNumbers)
#remove stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
#remove whitespace
docs <- tm_map(docs, stripWhitespace)
#Good practice to check every now and then
# writeLines(as.character(docs[[1]]))
#Stem document
docs <- tm_map(docs,stemDocument)

#fix up 1) differences between us and aussie english 2) general errors
docs <- tm_map(docs, content_transformer(gsub),
               pattern = "organiz", replacement = "organ")
docs <- tm_map(docs, content_transformer(gsub),
               pattern = "organis", replacement = "organ")
docs <- tm_map(docs, content_transformer(gsub),
               pattern = "andgovern", replacement = "govern")
docs <- tm_map(docs, content_transformer(gsub),
               pattern = "inenterpris", replacement = "enterpris")
docs <- tm_map(docs, content_transformer(gsub),
               pattern = "team-", replacement = "team")
#define and eliminate all custom stopwords
myStopwords <- c("can", "say","one","way","use",
                 "also","howev","tell","will",
                 "much","need","take","tend","even",
                 "like","particular","rather","said",
                 "get","well","make","ask","come","end",
                 "first","two","help","often","may",
                 "might","see","someth","thing","point",
                 "post","look","right","now","think","‘ve ",
                 "‘re ","anoth","put","set","new","good",
                 "want","sure","kind","larg","yes,","day","etc",
                 "quit","sinc","attempt","lack","seen","awar",
                 "littl","ever","moreov","though","found","abl",
                 "enough","far","earli","away","achiev","draw",
                 "last","never","brief","bit","entir","brief",
                 "great","lot")
docs <- tm_map(docs, removeWords, myStopwords)
#inspect a document as a check
#(as.character(docs[[1]]))

#Create   document-term matrix
dtm <- DocumentTermMatrix(docs)
#convert rownames to filenames
rownames(dtm) <- meta(docs, "title")
#collapse matrix by summing over columns
freq <- colSums(as.matrix(dtm))
#lengt  h should be total number of terms
length(freq)
#create sort order (descending)
ord <- order(freq,decreasing=TRUE)
#List all terms in decreasing order of freq and write to disk
freq[ord]


#load topic models library
library(topicmodels)


ldaOut <- train(dtm, no_of_topics = 5, method = "LDA_topic_models")

ldaOut <- ldaOut$model

#write out results
#docs to topics
ldaOut.topics <- as.matrix(topics(ldaOut))
k <- 5
#top 6 terms in each topic
ldaOut.terms <- as.matrix(terms(ldaOut,6))

#probabilities associated with each topic assignment
topicProbabilities <- as.data.frame(ldaOut@gamma)

#Find relative importance of top 2 topics
topic1ToTopic2 <- lapply(1:nrow(dtm),function(x)
  sort(topicProbabilities[x,])[k]/sort(topicProbabilities[x,])[k-1])

#Find relative importance of second and third most important topics
topic2ToTopic3 <- lapply(1:nrow(dtm),function(x)
  sort(topicProbabilities[x,])[k-1]/sort(topicProbabilities[x,])[k-2])
