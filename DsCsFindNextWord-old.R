
source("DsCsCommon.R")


startTime <- captureStartTime()
gcDet<-calcGc()

allTknFile<-list.files(ngramDirHome,pattern=alltknFilePattern)

allTkns<-readRDS(paste0(ngramDirHome,.Platform$file.sep,allTknFile[1]))

dfmAll<-dfm(allTkns,tolower = TRUE, remove=stopwords('en'))

str(dfmAll)

ngramFeatAll<-textstat_frequency(dfmAll)

str(ngramFeatAll)

?colSums

allNgramSums<-colSums(dfmAll)

str(allNgramSums)

uniGram <- data.table(word1 = names(allNgramSums), count = allNgramSums)

str(uniGram)

nGram<-2

ngramFilePattern<-paste0(nGramFilePrefix,nGram, "_(.)*.rds")

ngramFile<-list.files(ngramDirHome,pattern=ngramFilePattern)

ngram2<-readRDS(paste0(ngramDirHome,.Platform$file.sep,ngramFile[1]))

nGram<-3

ngramFilePattern<-paste0(nGramFilePrefix,nGram, "_(.)*.rds")

ngramFile<-list.files(ngramDirHome,pattern=ngramFilePattern)

ngram3<-readRDS(paste0(ngramDirHome,.Platform$file.sep,ngramFile[1]))

rm(ngram3)

nGram<-4

ngramFilePattern<-paste0(nGramFilePrefix,nGram, "_(.)*.rds")

ngramFile<-list.files(ngramDirHome,pattern=ngramFilePattern)

ngram4<-readRDS(paste0(ngramDirHome,.Platform$file.sep,ngramFile[1]))

nGram<-5

ngramFilePattern<-paste0(nGramFilePrefix,nGram, "_(.)*.rds")

ngramFile<-list.files(ngramDirHome,pattern=ngramFilePattern)

ngram5<-readRDS(paste0(ngramDirHome,.Platform$file.sep,ngramFile[1]))


#saveRDS(allTkns,paste0(dataDirHome,.Platform$file.sep,nGramsDir,.Platform$file.sep,allTokenFilePrefix,capstoneFileSuffix, ".rds") )

#corpFiles<-list.files(corpDirHome,pattern=corpFilePattern)
#tknpFiles<-list.files(tknDirHome,pattern=tknFilePattern)

#tkn<-readRDS(paste0(tknDirHome,.Platform$file.sep,tknFile))


#saveRDS(nGramToken,paste0(dataDirHome,.Platform$file.sep,nGramsDir,.Platform$file.sep,nGramFilePrefix,nGram,"_", capstoneFileSuffix, ".rds") )
#saveRDS(nGramToken,paste0(dataDirHome,.Platform$file.sep,nGramsDir,.Platform$file.sep,nGramFilePrefix,nGram,"_", capstoneFileSuffix, ".rds") )
#saveRDS(nGramToken,paste0(dataDirHome,.Platform$file.sep,nGramsDir,.Platform$file.sep,nGramFilePrefix,nGram,"_", capstoneFileSuffix, ".rds") )


totaltimeTaken <- captureTimeTaken(appStartTime, "Total N-Gram creation   ")

