
if (!require("quanteda")) {
  install.packages("quanteda")
  library(quanteda)
}

?tokens_ngrams

?dfm

str(docTokensTrn)

#> str(docTokensTrn)
#List of 3
#$ train_1_en_US_blogs.txt  : chr [1:298349] "In" "the" "years" "thereafter" ...
#$ train_1_en_US_news.txt   : chr [1:278283] "He" "wasn" "t" "home" ...
#$ train_1_en_US_twitter.txt: chr [1:238268] "How" "are" "you" "Btw" ...
#- attr(*, "types")= chr [1:64831] "In" "the" "years" "thereafter" ...


#tkns2<-unlist()

#tkns1<-sapply(tknpFiles, function(tknFile){
#  tkn<-readRDS(paste0(tknDirHome,.Platform$file.sep,tknFile))
#  names(tkn)<-tknFile
#  return (tkn)
#})

#str(tkns1)

tknAll<-tkns[[1]]+tkns[[2]]+tkns[[3]]

str(tknAll)

tknAll2<-sapply(1:length(tkns),function(i){
  tkns[[i]]
})

str(tknAll2)

tknAll3<-lapply(1:length(tkns),function(i){
  tkns[[i]]
})

str(tknAll3)



#tknAll<-c(length (tknpFiles))

#str(tknAll)

tknAll1<-readRDS(paste0(tknDirHome,.Platform$file.sep,tknpFiles[1]))
names(tkn)<-tknpFiles[1]

for( i in 2:length (tknpFiles) ){
  tkn<-readRDS(paste0(tknDirHome,.Platform$file.sep,tknpFiles[i]))
  names(tkn)<-tknpFiles[i]
  tknAll1<-tknAll1+tkn
}

str(tkns)


?tokens_ngrams

?tokens

library("readr")

?list.files

corpFn1 <-c("file1.txt","file2.txt","file3.txt")

sapply(1:length(corpFn1), function(i){
  corpFn1[[i]][1]
}
)

sapply(corpFn, "[[",1)

cv<-c("one\r\n", "two\r\n", "three\r\n")

?toString 

?paste0

toString(cv)

pcv<-as.character(paste0(cv))

str(pcv)

pcv1<-paste(cv,collapse = '')

str(pcv1)

getwd()

data_dir<-"C:/Wrksps/dev/DataScienceCE/datasciencecoursera/DataScienceCapStone/Data/final/en_US"

setwd(data_dir)

oFileNames<-list.files(data_dir,pattern="[.]*.txt",include.dirs = FALSE)

oFileNames

oFileNames<-list.files(data_dir,pattern="*.txt$")

oFileNames


fileName<-"en_US_news.txt"

file_sep<-.Platform$file.sep

asbFileName<-paste0(data_dir,file_sep, fileName)

asbFileName

?readline

inFile<-file(asbFileName, "r")

?read_lines

flnData<-read_lines(asbFileName, skip=10000, n_max=1)

str(flnData)

?sample

sLines<-sample(10, size=5, replace=FALSE)

str(sLines)

length(sLines)

sLines

sTrnLines<-sample(sLines, size=0.8*length(sLines),replace=FALSE)

sTrnLines

sTestLines<-setdiff(sLines,sTrnLines)

sTestLines

start_time <- Sys.time()
tSet<-sapply(sTrnLines, function(x){
#  cat(x)
  read_lines(asbFileName, skip=x-1, n_max=1)
})
end_time <- Sys.time()
time_taken <- end_time - start_time
time_taken


sTrnLen<-length(sTrnLines)

sTrnData<-character(sTrnLen)

str(sTrnData)

start_time <- Sys.time()
for (i in 1:sTrnLen){
  print (paste(i, sTrnLines[i]))
  sTrnData[i]<- read_lines(asbFileName, skip=sTrnLines[i]-1, n_max=1)
}
end_time <- Sys.time()
time_taken<- end_time - start_time
time_taken

sTrnData
  



str(x)


tSet

subDir<-"sample_1"

ifelse(!dir.exists(file.path(data_dir, subDir)), dir.create(file.path(data_dir, subDir)), FALSE)

file.path(data_dir, subDir)

trainSampleFile<-paste("test","1",fileName,sep="_")

trainSampleFile

trainSampleFileAbs<-paste0(file.path(data_dir, subDir),file_sep,trainSampleFile )

trainSampleFileAbs

write_lines(tSet,trainSampleFileAbs)

str(tSet)

library(stringi)

stri_trans_general("Sølvsten", "Latin-ASCII")

?gsub

gsub(pattern = '[^a-zA-Z0-9\\s]+',
     x = 'English 象形字 Chinese',
     replacement = "",
     ignore.case = TRUE,
     perl = TRUE)


gsub(pattern = '[_]+',
     x = 'English___Chinese',
     replacement = " ",
     ignore.case = TRUE,
     perl = TRUE)


?grep 

grep(pattern = '[_]+',
     x = c('English___Chinese___','edfeff','dsfs_')
    )


x1<- c('English___Chinese___','edfeff','dsfs_')

grep(pattern = '[_]+',
     x = x1
)

x1

x2<-gsub(pattern = '[_]+',
     x1,
     replacement = " ",
     ignore.case = TRUE,
     perl = TRUE)

x2

gsub(pattern = '[_]+',
     x = '__truncated__',
     replacement = " ",
     ignore.case = TRUE,
     perl = TRUE)

install.packages("textcat");


library("textcat")

?textcat

names(textcat::TC_char_profiles)


tcOut<-textcat(c(
  "This is an English sentence.",
  "Das ist ein deutscher Satz.",
  "Esta es una frase en espa~nol."))


str(tcOut)



tcOut2<-textcat(c(
  "This Das is an English sentence.",
  "Das ist ein deutscher Satz.",
  "Esta es una frase en espa~nol."))

str(tcOut2)

install.packages("cld2")

?cld2

library(cld2)

# NOT RUN {
# Vectorized function

text <- c("To be or not to be?", "Ce n'est pas grave.", "Nou breekt mijn klomp!")

detect_language(text)

 
text <- c("To be or not to be? Ce n'est pas grave", "Ce n'est pas grave.", "Nou breekt mijn klomp!")

detect_language(text)

detect_language_mixed(text)


# }
# NOT RUN {
# Read HTML from connection

detect_language(url('http://www.un.org/ar/universal-declaration-human-rights/'), plain_text = FALSE)

# More detailed classification output
detect_language_mixed(
  url('http://www.un.org/fr/universal-declaration-human-rights/'), plain_text = FALSE)

detect_language_mixed(
  url('http://www.un.org/zh/universal-declaration-human-rights/'), plain_text = FALSE)
# }

library("readr")


data_dir<-"C:/Wrksps/dev/DataScienceCE/datasciencecoursera/DataScienceCapStone/Data/final/en_US"


str1 <- "How many words are in this sentence"

gr<-gregexpr("\\W+", str1)

gr

str(gr)

lengths(gregexpr("\\W+", str1)) + 1

?str_split

library(stringr)

str_split(str1,"\\W+");

str_extract_all(str1,"\\W+" );


?lengths

str(fileInfo)

class(fileInfo)

fileInfo[,]$size

fileInfo$size

absPath

names(absPath) <-c("absFilePath")

names(absPath)<-c()

names(absPath)
?cbind

fileInfo<-cbind(fileInfo,absPath,stringsAsFactors = FALSE )

fileInfo

str(fileInfo)


?gsub

gsub("(\\.)([a-zA-Z]*)(\\.)([a-zA-Z]*)", "_\\2\\3\\4","en_US.blogs.txt")

gsub("(\\.)([a-zA-Z]*)(\\.)([a-zA-Z]*)$", "_\\2\\3\\4","en_US.blogs.txt")

gsub("(\\.)([a-zA-Z]*)(\\.)([a-zA-Z]*)$", "_\\2\\3\\4","en_US_blogs.txt")



gsub("([a-zA-Z]*)[\\.])*)([a-zA-Z]*)(\\.)([a-zA-Z]*)$", "_\\2\\3\\4","en.US.blogs.txt")

grep("en_US.blogs.txt","(\\.)")

gc(reset=TRUE)

gcres<-gc()

rownames(gcres)
colnames(gcres)

str(gcres)
class(gcres)

row1<-gcres[1,]

str(row1)

names(row1)

class(row1)

col1<-gcres[,1]

col1


start_time <- Sys.time()

end_time <- Sys.time()

time_taken <- end_time - start_time


gcEnd<-gc()


absPath<-sapply(nFileNames, function(x){
  paste(data_dir,x,sep="")
})

class(absPath)

names(absPath)    

absPath["en_US.blogs.txt"]



blog_file_info<-file.info(blog_file_path);

blog_file_info

class(blog_file_info)

str(blog_file_info)

blgMb<-blog_file_info$size/(1024*1024)

blgMb

gcBeg

gcEnd<-gc()

gcEnd

maxMemUsed <-gcEnd[,6]-gcBeg[,6]

maxMemUsed

sum(maxMemUsed)

gcEnd

maxMemUsed <-gcEnd[,6]-gcBeg[,6]

maxMemUsed

sum(maxMemUsed)


Rprof(tf <- "dscsfinalmem.log", memory.profiling=TRUE)


x <- "hello.world.123.456"
g <- regexpr("\\.[^\\.]*$", x)


regexpr("\\.[^\\.]*$", x)

?substr

substr(x, 1, g)

regexpr("\\.", x)

regexpr("\\.", x)

regexpr("[\\.]*", x)

str(g)

class(g)

class(g)

attributes(g)

attributes(g)$match.length


