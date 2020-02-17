
source("DsCsCommon.R")


startTime <- captureStartTime()
gcDet<-calcGc()


nGram<-1

nwmFilePattern<-paste0(nwmFilePrefix,nGram, "_(.)*.rds")

nwmFile<-list.files(nwmDirHome,pattern=nwmFilePattern)

nwm<-readRDS(paste0(nwmDirHome,.Platform$file.sep,nwmFile[1]))

uniGramDT <- nwm

timeTaken <- captureTimeTaken(startTime, paste0(nGram, " gram next word model load "))
rm(nwmFilePattern)
rm(nwmFile)
rm(nwm)

gcDet<-calcGc()

nGram<-2

nwmFilePattern<-paste0(nwmFilePrefix,nGram, "_(.)*.rds")

nwmFile<-list.files(nwmDirHome,pattern=nwmFilePattern)

nwm<-readRDS(paste0(nwmDirHome,.Platform$file.sep,nwmFile[1]))

biGramDT <- nwm

rm(nwmFilePattern)
rm(nwmFile)
rm(nwm)

timeTaken <- captureTimeTaken(startTime, paste0(nGram, " gram next word model load "))
gcDet<-calcGc()


nGram<-3

nwmFilePattern<-paste0(nwmFilePrefix,nGram, "_(.)*.rds")

nwmFile<-list.files(nwmDirHome,pattern=nwmFilePattern)

nwm<-readRDS(paste0(nwmDirHome,.Platform$file.sep,nwmFile[1]))

triGramDT <- nwm

rm(nwmFilePattern)
rm(nwmFile)
rm(nwm)

timeTaken <- captureTimeTaken(startTime, paste0(nGram, " gram next word model load "))
gcDet<-calcGc()


?data.table

#uniCount<-uniGramDT[,.N]

uniCount<-nrow(uniGramDT)

uniGramDT<-uniGramDT[,prob:=.N/uniCount, by=word1]


biGramDT<-biGramDT[uniGramDT,.(word1, word2, count,i.count), on="word1"]

head(biGramDT,5)

setnames(biGramDT,old="i.count", new="prevcount")

biGramDT<-biGramDT[,prob:=count/prevcount]

biGramDT<-biGramDT[,prevWcount:=.N,by=word1]


knd<-0.75

biGramDT<-biGramDT[uniGramDT,.(word1, word2, count,prevcount,prob,prevWcount, i.prob), on=c("word2==word1")]

setnames(biGramDT,old="i.prob", new="w2uniprob")

head(biGramDT,5)

#pkn -pkn(Wi/Wi-1)=max(c(Wi-1wi-d),0)/c(Wi-1)+lambda(Wi-1)*pcn(wi). Where  lambda(Wi-1)=d/c(wi-1){w:c(wi-1,w)>0}
#c(Wi-1wi-d) - bigram count, d - discount, c(wi-1) unigram wi-1 coun, c(wi-1,w): first word count of bigram
#

biGramDT[,pkn:=((count-knd)/prevcount+knd/prevcount*prevWcount*w2uniprob)]


triGramDT<-triGramDT[biGramDT,.(word1, word2, word3, count,i.count), on=.(word1,word2)]

head(triGramDT)

setnames(triGramDT,old="i.count", new="prevcount")

triGramDT<-triGramDT[,prob:=count/prevcount]

triGramDT<-triGramDT[,prevWcount:=.N,by=.(word1,word2)]

triGramDT<-triGramDT[biGramDT,.(word1, word2,word3, count,prevcount,prob,prevWcount, i.pkn), on=.(word1,word2)]

setnames(triGramDT,old="i.pkn", new="bipkn")

#pkn -pkn(Wi/Wi-1)=max(c(Wi-1wi-d),0)/c(Wi-1)+lambda(Wi-1)*pcn(wi). Where  lambda(Wi-1)=d/c(wi-1){w:c(wi-1,w)>0}
#c(Wi-1wi-d) - bigram count, d - discount, c(wi-1) unigram wi-1 coun, c(wi-1,w): first word count of bigram
#
triGramDT[,pkn:=((count-knd)/prevcount+knd/prevcount*prevWcount*bipkn)]

head(uniGramDT)

uniGramDT <- uniGramDT[order(-prob)]

uniGrams <- function(n = 5) {  
  return(sample(uniGramDT[, word1], size = n))
}


biGrams <- function(w1, n = 5) {
  pwords <- biGramDT[word1==w1][order(-pkn)]
  if (any(is.na(pwords)))
    return(uniGrams(n))
  if (nrow(pwords) > n)
    return(pwords[1:n, word2])
  count <- nrow(pwords)
  unWords <- uniGramDT(n)[1:(n - count)]
  return(c(pwords[, word2], unWords))
}

triGrams <- function(w1, w2, n = 5) {
  pwords <- triGramDT[word1==w1 & word2==w2][order(-pkn)]
  if (any(is.na(pwords)))
    return(biGrams(w2, n))
  if (nrow(pwords) > n)
    return(pwords[1:n, word3])
  count <- nrow(pwords)
  bwords <- biGrams(w2, n)[1:(n - count)]
  return(c(pwords[, word3], bwords))
}

?char_tolower

getNextWords <- function(str, n=5){
  #require(textclean)
  #require(quanteda)
  #require(tm)
  #str <- cleanInput(str)
  
  tokens <- tokens(x = char_tolower(str))
  tokens <- rev(rev(tokens[[1]])[1:2])
  
  words <- triGrams(tokens[1], tokens[2], n)
  chain_1 <- paste(tokens[1], tokens[2], words[1], sep = " ")
  
  print(words)
}


getNextWords("Shall we go to")


##############

str<-"Shall we go to"

tokens <- tokens(x = char_tolower(str))
tokens <- rev(rev(tokens[[1]])[1:2])

triGramDT[word1==tokens[1] & word2==tokens[2]]

pwords <- triGramDT[word1==tokens[1] & word2==tokens[2]][order(-pkn)]



rm(uniGramDT)
rm(biGramDT)
rm(triGramDT)
gcDet<-calcGc()
totaltimeTaken <- captureTimeTaken(appStartTime, "Total N-Gram model creation   ")

