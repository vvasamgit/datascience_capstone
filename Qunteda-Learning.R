
packageVersion("quanteda")


install.packages("quanteda")

install.packages("digest")

packageVersion("devtools")

install.packages("devtools")

devtools::install_github("quanteda/quanteda.corpora")

devtools::install_github("quanteda/spacyr", build_vignettes = FALSE)

devtools::install_github("kbenoit/quanteda.dictionaries")


library("spacyr")

spacy_install()

install.packages("newsmap")

devtools::install_github("quanteda/quanteda.corpora")

require(readtext)

install.packages("readtext")

library("readtext")

library("quanteda")

data(data_char_ukimmig2010)

data_char_ukimmig2010

class (data_char_ukimmig2010)

length(data_char_ukimmig2010)

names(data_char_ukimmig2010)

data_char_ukimmig2010[1]

nchar(data_char_ukimmig2010[1])

names(data_char_ukimmig2010[1])


path_data <- system.file("extdata/", package = "readtext")


dat_eu <- readtext(paste0(path_data, "/txt/EU_manifestos/*.txt"),
                   docvarsfrom = "filenames", 
                   docvarnames = c("unit", "context", "year", "language", "party"),
                   dvsep = "_", 
                   encoding = "ISO-8859-1")


class(dat_eu)

str(dat_eu)

getwd()


dat_twitter <- readtext("content/data/twitter.json", source = "twitter")

object.size(dat_twitter)

head(names(dat_twitter))


dat_inaug <- read.csv(paste0(path_data, "/csv/inaugCorpus.csv"))


dat_dail <- readtext(paste0(path_data, "/tsv/dailsample.tsv"), text_field = "speech")


class(dat_dail)

#[1] "readtext"   "data.frame"

 class(path_data)
#[1] "character"
 
 class(dat_inaug)
 
 ?gc()

 gcinfo(TRUE)
 
 gc(TRUE)
 
 tempdir()
 
 f<-"IndianTreaty_English_UTF-16LE.txt"
 
 filename <- gsub(".txt$", "", f)
 
 filename
 
 ?strsplit

 strsplit(filename,"_")
 
 sapply(strsplit(filename,"_"),"[",3)
 
 sres<-sapply(strsplit(filename,"_"),"[",3)

 sres
 
 ?gsub
 
 iconvlist()
 
 ?quanteda::clean
 