
source("DsCsCommon.R")

curdir<-getwd()
dataDirHome<-"./data"
dataZipExtractDir<-paste0(dataDirHome, "/orig")
dataDir<-paste0(dataZipExtractDir,"/final/en_US")


fileInfo<-gatherFileInfo(dataDir,"*.txt$")
fileInfo<-gatherFileCounts(fileInfo)
fileCounts<-fileInfo[,.(fileName,size,line_count,word_count,char_count)]

fileCountsMelt<-melt(fileCounts, id.vars=c("fileName"), measure.vars = c("line_count","word_count"))
fileCountsMelt<-fileCountsMelt[,value_millions:=as.integer(value)/1000000]

corpdir<-"corpus"

corpdirExists<-ifelse(dir.exists(file.path(dataDirHome, corpdir)), TRUE, dir.create(file.path(dataDirHome, corpdir)))

corpFn<-str_split(fileInfo$fileName,"\\.")

corpFn<-sapply(corpFn, "[[",1)

corpFn

fileCount<-nrow(fileInfo)

corpusText<-character(fileCount)

str(corpusText)


#Read file contents and create corpus and save. Coprus with all file contents or 
#seperate for each file 

samplePercent<-1
numSplits<-3


sNumOflines<-sapply(1:nrow(fileInfo),function(fi){
  floor(as.integer(fileInfo[fi]$line_count)*samplePercent/100)
})

sNumOflines

fileText<-list(fileCount)

str(fileText)

paste0(dataDirHome,"/corpus/", corpFn[1],".rds")

for(fi in 1:fileCount){
  
  fileAbsPath<-fileInfo[fi]$absPath
  sNumOflines<-floor(as.integer(fileInfo[fi]$line_count)*samplePercent/100)
  sFileText<-read_lines(fileAbsPath,n_max=sNumOflines)
  sFileDoc<-paste(sFileText,collapse="")
  sCrop<-corpus(sFileDoc)
  saveRDS(sCrop,paste0(dataDirHome,.Platform$file.sep,corpdir,.Platform$file.sep, corpFn[fi],".rds") )
}

startTime <- captureStartTime()




captureTimeTaken(startTime, paste0(samplePercent," percent sample data files creation "))

