sony<-read.csv("E:\\R\\Sony",header=FALSE,sep="\t", stringsAsFactors =FALSE)
kodak<-read.csv("E:\\R\\Kodak",header=FALSE,sep="\t", stringsAsFactors =FALSE)
names(kodak)<-c("productId","title","price","userId","profileName","helpfulness","score","time","summary","text")
names(sony)<-c("productId","title","price","userId","profileName","helpfulness","score","time","summary","text")
str(sony)
str(kodak)
library(wordcloud)
library(tm)
data_corpus<-Corpus(VectorSource(kodak$text))
data_corpus<-tm_map(data_corpus,content_transformer(tolower))
data_corpus<-tm_map(data_corpus,removePunctuation)
data_corpus<-tm_map(data_corpus, function(x) removeWords(x,stopwords()))
wordcloud(data_corpus,colors='green')

hu.liu.neg = scan('E:\\R\\negative_words.txt',what='character', comment.char=';')
hu.liu.pos = scan('E:\\R\\positive_words.txt',what='character', comment.char=';')
pos.words = c(hu.liu.pos, 'upgrade')
neg.words = c(hu.liu.neg, 'wtf', 'wait', 'waiting','epicfail', 'mechanical')
dataframe<-data.frame(text=unlist(sapply(data_corpus,`[`,"content")))
datafram1<-dataframe[-21]
review_score<-function(dat,pos.words,neg.words){
  s3=c()  ##initialize empty vector
  for (i in 1:7143){    ##data contains 7143 rows
    as1<-dat[i]  	##reviews present in 11th column
    as3<-str_split(as1,"\\s+")  ##breaks long character into list of words
    as4<-unlist(as3)   ##converts list of words into character of words
    s3[i]<-sum(!is.na(match(as4,pos.words)))-sum(!is.na(match(as4,neg.words)))
  }
  return(s3)
}
sentiment_score<-review_score(dataframe$text,pos.words,neg.words)
hist(sentiment_score,col='blue')
