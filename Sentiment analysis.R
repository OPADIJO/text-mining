
#load the Tm and wordcloud packages
library(tm)
library(wordcloud)

#import the dataset
Hotels<-read.csv("tourist_accommodation_reviews.csv", header = T)

#inspect the dataset
names(Hotels)
head(Hotels)
tail(Hotels)
summary(Hotels)
str(Hotels)
dim(Hotels)

#create a list of 30 randomly selected Hotels 
shotel<- sample(Hotels$Hotel.Restaurant.name, 30,replace = T)
shotel

#create Hotel specific subsets. 
SSWR <- subset(Hotels, Hotel.Restaurant.name=="Siam Smile Wine & Restaurant")
RVCB<- subset(Hotels, Hotel.Restaurant.name=="Rawai View Cafe' & Bar")
LBC<- subset(Hotels, Hotel.Restaurant.name=="La Boucherie - Chalong")
TPCND<- subset(Hotels, Hotel.Restaurant.name=="Trattoria pizzeria Cosa Nostra Delivery")
DPK<- subset(Hotels, Hotel.Restaurant.name=="Danny's Place Kamala")
BB<- subset(Hotels, Hotel.Restaurant.name=="Bamboo Bar")
RTC<- subset(Hotels, Hotel.Restaurant.name=="Raya Thai Cuisine")
TIR<- subset(Hotels, Hotel.Restaurant.name=="Tiger Inn Restaurant")
BK<- subset(Hotels, Hotel.Restaurant.name=="Baan Kalim")
WCDBCP<- subset(Hotels, Hotel.Restaurant.name=="Wine Connection Deli & Bistro - Chalong, Phuket")
OSOT<- subset(Hotels, Hotel.Restaurant.name=="OSOT")
LP<- subset(Hotels, Hotel.Restaurant.name=="Little Paris")
BM<- subset(Hotels, Hotel.Restaurant.name=="Baan Mai")
MIR<- subset(Hotels, Hotel.Restaurant.name=="Mare Italian Restaurant")
EBB<- subset(Hotels, Hotel.Restaurant.name=="ELLA Bar & Bistro")
S9<- subset(Hotels, Hotel.Restaurant.name=="99 Seafood")
MINT<- subset(Hotels, Hotel.Restaurant.name=="Mint")
KR<- subset(Hotels, Hotel.Restaurant.name=="Kook Restaurant")
ER<- subset(Hotels, Hotel.Restaurant.name=="Enjoy Restaurant")
SB<- subset(Hotels, Hotel.Restaurant.name=="Smile Bar")
HHBR<- subset(Hotels, Hotel.Restaurant.name=="Hey Ha Bar & Restaurant")
MM<- subset(Hotels, Hotel.Restaurant.name=="Mamasita Mexican")
KeR<- subset(Hotels, Hotel.Restaurant.name=="Ken Restaurant")
SR<- subset(Hotels, Hotel.Restaurant.name=="Sansabai restaurant")
KOKO<- subset(Hotels, Hotel.Restaurant.name=="Kokosnuss")
KCSTC<- subset(Hotels, Hotel.Restaurant.name=="Karon Cafe Steakhouse & Thai Cuisine")
DIRBP<- subset(Hotels, Hotel.Restaurant.name=="Deepavali Indian Restaurant - Bangtao Place")
HRCP<- subset(Hotels, Hotel.Restaurant.name=="Hard Rock Cafe Phuket")
BamK<- subset(Hotels, Hotel.Restaurant.name=="Bamboo Kitchen")
TPC<- subset(Hotels, Hotel.Restaurant.name=="The Palm Cuisine")

#Inspect the review column in the database
head(SSWR$Review)
head(RVCB$Review)
head(LBC$Review)
head(TPCND$Review)
head(DPK$Review)
head(BB$Review)
head(RTC$Review)
head(TIR$Review)
head(BK$Review)
head(WCDBCP$Review)
head(OSOT$Review)
head(LP$Review)
head(BM$Review)
head(MIR$Review)
head(EBB$Review)
head(S9$Review)
head(MINT$Review)
head(KR$Review)
head(ER$Review)
head(SB$Review)
head(HHBR$Review)
head(MM$Review)
head(KeR$Review)
head(SR$Review)
head(KOKO$Review)
head(KCSTC$Review)
head(DIRBP$Review)
head(HRCP$Review)
head(BamK$Review)
head(TPC$Review)

#CREATE A VECTOR BASED ON THE REVIEWS IN THE DATAFRAME 
review_SSWR<-SSWR$Review
review_RVCB<-RVCB$Review
review_LBC<-LBC$Review
review_TPCND<-TPCND$Review
review_DPK<-DPK$Review
review_BB<-BB$Review
review_RTC<-RTC$Review
review_TIR<-TIR$Review
review_BK<-BK$Review
review_WCDBCP<-WCDBCP$Review
review_OSOT<-OSOT$Review
review_LP<-LP$Review
review_BM<-BM$Review
review_MIR<-MIR$Review
review_EBB<-EBB$Review
review_S9<-S9$Review
review_MINT<-MINT$Review
review_KR<-KR$Review
review_ER<-ER$Review
review_SB<-SB$Review
review_HHBR<-HHBR$Review
review_MM<-MM$Review
review_KeR<-KeR$Review
review_SR<-SR$Review
review_KOKO<-KOKO$Review
review_KCSTC<-KCSTC$Review
review_DIRBP<-DIRBP$Review
review_HRCP<-HRCP$Review
review_BamK<-BamK$Review
review_TPC<-TPC$Review

#CONVERT ALL TO LOWERCASE 
review_SSWR<- tolower(review_SSWR)
review_RVCB<- tolower(review_RVCB)
review_LBC<- tolower(review_LBC)
review_TPCND<- tolower(review_TPCND)
review_DPK<- tolower(review_DPK)
review_BB<- tolower(review_BB)
review_RTC<-tolower(review_RTC)
review_TIR<- tolower(review_TIR)
review_BK<- tolower(review_BK)
review_WCDBCP<- tolower(review_WCDBCP)
review_OSOT<-tolower(review_OSOT)
review_LP<- tolower(review_LP)
review_BM<- tolower(review_BM)
review_MIR<- tolower(review_MIR)
review_EBB<- tolower(review_EBB)
review_S9<- tolower(review_S9)
review_MINT<- tolower(review_MINT)
review_KR<- tolower(review_KR)
review_ER<- tolower(review_ER)
review_SB<- tolower(review_SB)
review_HHBR<- tolower(review_HHBR)
review_MM<- tolower(review_MM)
review_KeR<- tolower(review_KeR)
review_SR<- tolower(review_SR)
review_KOKO<- tolower(review_KOKO)
review_KCSTC<- tolower(review_KCSTC)
review_DIRBP<- tolower(review_DIRBP)
review_HRCP<- tolower(review_HRCP)
review_BamK<- tolower(review_BamK)
review_TPC<- tolower(review_TPC)

#REMOVE WEB LINKS FROM THE REVIEW
review_SSWR<- gsub("http\\S+\\s*","",review_SSWR)
review_RVCB<- gsub("http\\S+\\s*","",review_RVCB)
review_LBC<- gsub("http\\S+\\s*","",review_LBC)
review_TPCND<- gsub("http\\S+\\s*","",review_TPCND)
review_DPK<- gsub("http\\S+\\s*","",review_DPK)
review_BB<- gsub("http\\S+\\s*","",review_BB)
review_RTC<-gsub("http\\S+\\s*","",review_RTC)
review_TIR<- gsub("http\\S+\\s*","",review_TIR)
review_BK<- gsub("http\\S+\\s*","",review_BK)
review_WCDBCP<- gsub("http\\S+\\s*","",review_WCDBCP)
review_OSOT<-gsub("http\\S+\\s*","",review_OSOT)
review_LP<- gsub("http\\S+\\s*","",review_LP)
review_BM<- gsub("http\\S+\\s*","",review_BM)
review_MIR<- gsub("http\\S+\\s*","",review_MIR)
review_EBB<- gsub("http\\S+\\s*","",review_EBB)
review_S9<- gsub("http\\S+\\s*","",review_S9)
review_MINT<- gsub("http\\S+\\s*","",review_MINT)
review_KR<- gsub("http\\S+\\s*","",review_KR)
review_ER<- gsub("http\\S+\\s*","",review_ER)
review_SB<- gsub("http\\S+\\s*","",review_SB)
review_HHBR<- gsub("http\\S+\\s*","",review_HHBR)
review_MM<- gsub("http\\S+\\s*","",review_MM)
review_KeR<- gsub("http\\S+\\s*","",review_KeR)
review_SR<- gsub("http\\S+\\s*","",review_SR)
review_KOKO<- gsub("http\\S+\\s*","",review_KOKO)
review_KCSTC<- gsub("http\\S+\\s*","",review_KCSTC)
review_DIRBP<- gsub("http\\S+\\s*","",review_DIRBP)
review_HRCP<- gsub("http\\S+\\s*","",review_HRCP)
review_BamK<- gsub("http\\S+\\s*","",review_BamK)
review_TPC<- gsub("http\\S+\\s*","",review_TPC)

#REMOVE PUNCTUATION FROM THE REVIEWS
review_SSWR<- gsub("[[:punct:]]","",review_SSWR)
review_RVCB<- gsub("[[:punct:]]","",review_RVCB)
review_LBC<- gsub("[[:punct:]]","",review_LBC)
review_TPCND<- gsub("[[:punct:]]","",review_TPCND)
review_DPK<- gsub("[[:punct:]]","",review_DPK)
review_BB<- gsub("[[:punct:]]","",review_BB)
review_RTC<-gsub("[[:punct:]]","",review_RTC)
review_TIR<- gsub("[[:punct:]]","",review_TIR)
review_BK<- gsub("[[:punct:]]","",review_BK)
review_WCDBCP<- gsub("[[:punct:]]","",review_WCDBCP)
review_OSOT<-gsub("[[:punct:]]","",review_OSOT)
review_LP<- gsub("[[:punct:]]","",review_LP)
review_BM<- gsub("[[:punct:]]","",review_BM)
review_MIR<- gsub("[[:punct:]]","",review_MIR)
review_EBB<- gsub("[[:punct:]]","",review_EBB)
review_S9<- gsub("[[:punct:]]","",review_S9)
review_MINT<- gsub("[[:punct:]]","",review_MINT)
review_KR<- gsub("[[:punct:]]","",review_KR)
review_ER<- gsub("[[:punct:]]","",review_ER)
review_SB<- gsub("[[:punct:]]","",review_SB)
review_HHBR<- gsub("[[:punct:]]","",review_HHBR)
review_MM<- gsub("[[:punct:]]","",review_MM)
review_KeR<- gsub("[[:punct:]]","",review_KeR)
review_SR<- gsub("[[:punct:]]","",review_SR)
review_KOKO<- gsub("[[:punct:]]","",review_KOKO)
review_KCSTC<- gsub("[[:punct:]]","",review_KCSTC)
review_DIRBP<- gsub("[[:punct:]]","",review_DIRBP)
review_HRCP<- gsub("[[:punct:]]","",review_HRCP)
review_BamK<- gsub("[[:punct:]]","",review_BamK)
review_TPC<- gsub("[[:punct:]]","",review_TPC)

#REMOVE NUMBERS FROM THE REVIEWS
review_SSWR<- gsub("[[:digit:]]","",review_SSWR)
review_RVCB<- gsub("[[:digit:]]","",review_RVCB)
review_LBC<- gsub("[[:digit:]]","",review_LBC)
review_TPCND<- gsub("[[:digit:]]","",review_TPCND)
review_DPK<- gsub("[[:digit:]]","",review_DPK)
review_BB<- gsub("[[:digit:]]","",review_BB)
review_RTC<-gsub("[[:digit:]]","",review_RTC)
review_TIR<- gsub("[[:digit:]]","",review_TIR)
review_BK<- gsub("[[:digit:]]","",review_BK)
review_WCDBCP<- gsub("[[:digit:]]","",review_WCDBCP)
review_OSOT<-gsub("[[:digit:]]","",review_OSOT)
review_LP<- gsub("[[:digit:]]","",review_LP)
review_BM<- gsub("[[:digit:]]","",review_BM)
review_MIR<- gsub("[[:digit:]]","",review_MIR)
review_EBB<- gsub("[[:digit:]]","",review_EBB)
review_S9<- gsub("[[:digit:]]","",review_S9)
review_MINT<- gsub("[[:digit:]]","",review_MINT)
review_KR<- gsub("[[:digit:]]","",review_KR)
review_ER<- gsub("[[:digit:]]","",review_ER)
review_SB<- gsub("[[:digit:]]","",review_SB)
review_HHBR<- gsub("[[:digit:]]","",review_HHBR)
review_MM<- gsub("[[:digit:]]","",review_MM)
review_KeR<- gsub("[[:digit:]]","",review_KeR)
review_SR<- gsub("[[:digit:]]","",review_SR)
review_KOKO<- gsub("[[:digit:]]","",review_KOKO)
review_KCSTC<- gsub("[[:digit:]]","",review_KCSTC)
review_DIRBP<- gsub("[[:digit:]]","",review_DIRBP)
review_HRCP<- gsub("[[:digit:]]","",review_HRCP)
review_BamK<- gsub("[[:digit:]]","",review_BamK)
review_TPC<- gsub("[[:digit:]]","",review_TPC)

#REMOVE BLANK SPACES AT THE BEGINING  FROM THE REVIEWS
review_SSWR<- gsub("^ ","",review_SSWR)
review_RVCB<- gsub("^ ","",review_RVCB)
review_LBC<- gsub("^ ","",review_LBC)
review_TPCND<- gsub("^ ","",review_TPCND)
review_DPK<- gsub("^ ","",review_DPK)
review_BB<- gsub("^ ","",review_BB)
review_RTC<-gsub("^ ","",review_RTC)
review_TIR<- gsub("^ ","",review_TIR)
review_BK<- gsub("^ ","",review_BK)
review_WCDBCP<- gsub("^ ","",review_WCDBCP)
review_OSOT<-gsub("^ ","",review_OSOT)
review_LP<- gsub("^ ","",review_LP)
review_BM<- gsub("^ ","",review_BM)
review_MIR<- gsub("^ ","",review_MIR)
review_EBB<- gsub("^ ","",review_EBB)
review_S9<- gsub("^ ","",review_S9)
review_MINT<- gsub("^ ","",review_MINT)
review_KR<- gsub("^ ","",review_KR)
review_ER<- gsub("^ ","",review_ER)
review_SB<- gsub("^ ","",review_SB)
review_HHBR<- gsub("^ ","",review_HHBR)
review_MM<- gsub("^ ","",review_MM)
review_KeR<- gsub("^ ","",review_KeR)
review_SR<- gsub("^ ","",review_SR)
review_KOKO<- gsub("^ ","",review_KOKO)
review_KCSTC<- gsub("^ ","",review_KCSTC)
review_DIRBP<- gsub("^ ","",review_DIRBP)
review_HRCP<- gsub("^ ","",review_HRCP)
review_BamK<- gsub("^ ","",review_BamK)
review_TPC<- gsub("^ ","",review_TPC)

#REMOVE BLANK SPACES AT THE END FROM THE REVIEWS
review_SSWR<- gsub(" $ ","",review_SSWR)
review_RVCB<- gsub(" $","",review_RVCB)
review_LBC<- gsub(" $","",review_LBC)
review_TPCND<- gsub(" $","",review_TPCND)
review_DPK<- gsub(" $","",review_DPK)
review_BB<- gsub(" $","",review_BB)
review_RTC<-gsub(" $","",review_RTC)
review_TIR<- gsub(" $","",review_TIR)
review_BK<- gsub(" $","",review_BK)
review_WCDBCP<- gsub(" $","",review_WCDBCP)
review_OSOT<-gsub(" $","",review_OSOT)
review_LP<- gsub(" $","",review_LP)
review_BM<- gsub(" $","",review_BM)
review_MIR<- gsub(" $","",review_MIR)
review_EBB<- gsub(" $","",review_EBB)
review_S9<- gsub(" $","",review_S9)
review_MINT<- gsub(" $","",review_MINT)
review_KR<- gsub(" $","",review_KR)
review_ER<- gsub(" $","",review_ER)
review_SB<- gsub(" $","",review_SB)
review_HHBR<- gsub(" $","",review_HHBR)
review_MM<- gsub(" $","",review_MM)
review_KeR<- gsub(" $","",review_KeR)
review_SR<- gsub(" $","",review_SR)
review_KOKO<- gsub(" $","",review_KOKO)
review_KCSTC<- gsub(" $","",review_KCSTC)
review_DIRBP<- gsub(" $","",review_DIRBP)
review_HRCP<- gsub(" $","",review_HRCP)
review_BamK<- gsub(" $","",review_BamK)
review_TPC<- gsub(" $","",review_TPC)

#INSPECT THE VECTORS AFTER CLEANING 
head(review_SSWR)
head(review_RVCB)
head(review_LBC)
head(review_TPCND)
head(review_DPK)
head(review_BB)
head(review_RTC)
head(review_TIR)
head(review_BK)
head(review_WCDBCP)
head(review_OSOT)
head(review_LP)
head(review_BM)
haed(review_MIR)
head(review_EBB)
head(review_S9)
head(review_MINT)
head(review_KR)
head(review_ER)
head(review_SB)
head(review_HHBR)
head(review_MM)
head(review_KeR)
head(review_SR)
head(review_KOKO)
head(review_KCSTC)
head(review_DIRBP)
head(review_BamK)
head(review_TPC)

#CONVERT THE TEXT TO CORPUS
corpus_SSWR<- Corpus(VectorSource(review_SSWR))
corpus_RVCB<- Corpus(VectorSource(review_RVCB))
corpus_LBC<- Corpus(VectorSource(review_LBC))
corpus_TPCND<- Corpus(VectorSource(review_TPCND))
corpus_DPK<- Corpus(VectorSource(review_DPK))
corpus_BB<- Corpus(VectorSource(review_BB))
corpus_RTC<-Corpus(VectorSource(review_RTC))
corpus_TIR<- Corpus(VectorSource(review_TIR))
corpus_BK<- Corpus(VectorSource(review_BK))
corpus_WCDBCP<- Corpus(VectorSource(review_WCDBCP))
corpus_OSOT<-Corpus(VectorSource(review_OSOT))
corpus_LP<- Corpus(VectorSource(review_LP))
corpus_BM<- Corpus(VectorSource(review_BM))
corpus_MIR<- Corpus(VectorSource(review_MIR))
corpus_EBB<- Corpus(VectorSource(review_EBB))
corpus_S9<- Corpus(VectorSource(review_S9))
corpus_MINT<- Corpus(VectorSource(review_MINT))
corpus_KR<- Corpus(VectorSource(review_KR))
corpus_ER<- Corpus(VectorSource(review_ER))
corpus_SB<- Corpus(VectorSource(review_SB))
corpus_HHBR<- Corpus(VectorSource(review_HHBR))
corpus_MM<- Corpus(VectorSource(review_MM))
corpus_KeR<- Corpus(VectorSource(review_KeR))
corpus_SR<- Corpus(VectorSource(review_SR))
corpus_KOKO<- Corpus(VectorSource(review_KOKO))
corpus_KCSTC<- Corpus(VectorSource(review_KCSTC))
corpus_DIRBP<- Corpus(VectorSource(review_DIRBP))
corpus_HRCP<- Corpus(VectorSource(review_HRCP))
corpus_BamK<- Corpus(VectorSource(review_BamK))
corpus_TPC<- Corpus(VectorSource(review_TPC))

#CLEAN UP CORPUS BY REMOVING STOPWORDS AND WHITESPACES 
corpus_SSWR<- tm_map(corpus_SSWR, removeWords, stopwords("english"))
corpus_SSWR<- tm_map(corpus_SSWR, stripWhitespace)
stem_corpus_SSWR<- tm_map(corpus_SSWR, stemDocument)

corpus_RVCB<- tm_map(corpus_RVCB, removeWords, stopwords("english"))
corpus_RVCB<- tm_map(corpus_RVCB, stripWhitespace)
stem_corpus_RVCB<- tm_map(corpus_RVCB, stemDocument)


corpus_LBC<- tm_map(corpus_LBC, removeWords, stopwords("english"))
corpus_LBC<- tm_map(corpus_LBC, stripWhitespace)
stem_corpus_LBC<- tm_map(corpus_LBC, stemDocument)

corpus_TPCND<- tm_map(corpus_TPCND, removeWords, stopwords("english"))
corpus_TPCND<- tm_map(corpus_TPCND, stripWhitespace)
stem_corpus_TPCND<- tm_map(corpus_TPCND, stemDocument)

corpus_DPK<- tm_map(corpus_DPK, removeWords, stopwords("english"))
corpus_DPK<- tm_map(corpus_DPK, stripWhitespace)
stem_corpus_DPK<- tm_map(corpus_DPK, stemDocument)

corpus_BB<- tm_map(corpus_BB, removeWords, stopwords("english"))
corpus_BB<- tm_map(corpus_BB, stripWhitespace)
stem_corpus_BB<- tm_map(corpus_BB, stemDocument)

corpus_RTC<-tm_map(corpus_RTC, removeWords, stopwords("english"))
corpus_RTC<- tm_map(corpus_RTC, stripWhitespace)
stem_corpus_RTC<- tm_map(corpus_RTC, stemDocument)

corpus_TIR<- tm_map(corpus_TIR, removeWords, stopwords("english"))
corpus_TIR<- tm_map(corpus_TIR, stripWhitespace)
stem_corpus_TIR<- tm_map(corpus_TIR, stemDocument)

corpus_BK<- tm_map(corpus_BK, removeWords, stopwords("english"))
corpus_BK<- tm_map(corpus_BK, stripWhitespace)
stem_corpus_BK<- tm_map(corpus_BK, stemDocument)

corpus_WCDBCP<- tm_map(corpus_WCDBCP, removeWords, stopwords("english"))
corpus_WCDBCP<- tm_map(corpus_WCDBCP, stripWhitespace)
stem_corpus_WCDBCP<- tm_map(corpus_WCDBCP, stemDocument)

corpus_OSOT<-tm_map(corpus_OSOT, removeWords, stopwords("english"))
corpus_OSOT<- tm_map(corpus_OSOT, stripWhitespace)
stem_corpus_OSOT<- tm_map(corpus_OSOT, stemDocument)

corpus_LP<- tm_map(corpus_LP, removeWords, stopwords("english"))
corpus_LP<- tm_map(corpus_LP, stripWhitespace)
stem_corpus_LP<- tm_map(corpus_LP, stemDocument)

corpus_BM<- tm_map(corpus_BM, removeWords, stopwords("english"))
corpus_BM<- tm_map(corpus_BM, stripWhitespace)
stem_corpus_BM<- tm_map(corpus_BM, stemDocument)

corpus_MIR<- tm_map(corpus_MIR, removeWords, stopwords("english"))
corpus_MIR<- tm_map(corpus_MIR, stripWhitespace)
stem_corpus_MIR<- tm_map(corpus_MIR, stemDocument)

corpus_EBB<- tm_map(corpus_EBB, removeWords, stopwords("english"))
corpus_EBB<- tm_map(corpus_EBB, stripWhitespace)
stem_corpus_EBB<- tm_map(corpus_EBB, stemDocument)

corpus_S9<- tm_map(corpus_S9, removeWords, stopwords("english"))
corpus_S9<- tm_map(corpus_S9, stripWhitespace)
stem_corpus_S9<- tm_map(corpus_S9, stemDocument)

corpus_MINT<- tm_map(corpus_MINT, removeWords, stopwords("english"))
corpus_MINT<- tm_map(corpus_MINT, stripWhitespace)
stem_corpus_MINT<- tm_map(corpus_MINT, stemDocument)

corpus_KR<- tm_map(corpus_KR, removeWords, stopwords("english"))
corpus_KR<- tm_map(corpus_KR, stripWhitespace)
stem_corpus_KR<- tm_map(corpus_KR, stemDocument)

corpus_ER<- tm_map(corpus_ER, removeWords, stopwords("english"))
corpus_ER<- tm_map(corpus_ER, stripWhitespace)
stem_corpus_ER<- tm_map(corpus_ER, stemDocument)

corpus_SB<- tm_map(corpus_SB, removeWords, stopwords("english"))
corpus_SB<- tm_map(corpus_SB, stripWhitespace)
stem_corpus_SB<- tm_map(corpus_SB, stemDocument)

corpus_HHBR<- tm_map(corpus_HHBR, removeWords, stopwords("english"))
corpus_HHBR<- tm_map(corpus_HHBR, stripWhitespace)
stem_corpus_HHBR<- tm_map(corpus_HHBR, stemDocument)

corpus_MM<- tm_map(corpus_MM, removeWords, stopwords("english"))
corpus_MM<- tm_map(corpus_MM, stripWhitespace)
stem_corpus_MM<- tm_map(corpus_MM, stemDocument)

corpus_KeR<- tm_map(corpus_KeR, removeWords, stopwords("english"))
corpus_KeR<- tm_map(corpus_KeR, stripWhitespace)
stem_corpus_KeR<- tm_map(corpus_KeR, stemDocument)

corpus_SR<- tm_map(corpus_SR, removeWords, stopwords("english"))
corpus_SR<- tm_map(corpus_SR, stripWhitespace)
stem_corpus_SR<- tm_map(corpus_SR, stemDocument)

corpus_KOKO<- tm_map(corpus_KOKO, removeWords, stopwords("english"))
corpus_KOKO<- tm_map(corpus_KOKO, stripWhitespace)
stem_corpus_KOKO<- tm_map(corpus_KOKO, stemDocument)

corpus_KCSTC<- tm_map(corpus_KCSTC, removeWords, stopwords("english"))
corpus_KCSTC<- tm_map(corpus_KCSTC, stripWhitespace)
stem_corpus_KCSTC<- tm_map(corpus_KCSTC, stemDocument)

corpus_DIRBP<- tm_map(corpus_DIRBP, removeWords, stopwords("english"))
corpus_DIRBP<- tm_map(corpus_DIRBP, stripWhitespace)
stem_corpus_DIRBP<- tm_map(corpus_DIRBP, stemDocument)

corpus_HRCP<- tm_map(corpus_HRCP, removeWords, stopwords("english"))
corpus_HRCP<- tm_map(corpus_HRCP, stripWhitespace)
stem_corpus_HRCP<- tm_map(corpus_HRCP, stemDocument)

corpus_BamK<- tm_map(corpus_BamK, removeWords, stopwords("english"))
corpus_BamK<- tm_map(corpus_BamK, stripWhitespace)
stem_corpus_BamK<- tm_map(corpus_BamK, stemDocument)

corpus_TPC<- tm_map(corpus_TPC, removeWords, stopwords("english"))
corpus_TPC<- tm_map(corpus_TPC, stripWhitespace)
stem_corpus_TPC<- tm_map(corpus_TPC, stemDocument)

#LOAD THE POSITIVE AND NEGATIVE LEXICONS 
positive_lexicon<- read.csv("positive-lexicon.txt", header = F)
negative_lexicon<- read.csv("negative-lexicon.txt", header= F)

#INSPECT THE POSITIVE AND NEGATIVE LEXICONS
head(positive_lexicon)
tail(positive_lexicon)
summary(positive_lexicon)
dim(positive_lexicon)
str(positive_lexicon)
head(negative_lexicon)
tail(negative_lexicon)
summary(negative_lexicon)
dim(negative_lexicon)
str(negative_lexicon)


#CREATE SENTIMENT FUNCTION  
sentiment<- function(stem_corpus)
{
  wordcloud(stem_corpus,
            min.freq = 3,
            colors = brewer.pal(8,"Dark2"),
            random.color = T,
            max.words = 100)
  
  #CREATE VARIABLE AND VECTOR TO COUNT THE NUMBER OF POSITIVE AND NEGATIVE WORDS IN THE REVIEW
  
  Positive_review<- 0
  Negative_review<- 0
  Positive_review_vector<- c()
  Negative_review_vector<- c()
  
  #CALCULATE THE SIZE OF THE CORPUS
  size<- length(stem_corpus)
  
  for (i in size) 
    {
    corpus_word<- list(strsplit(stem_corpus[[i]]$content, split = " "))
    
    #POSITIVE WORD COUNT IN THE REVIEW
    positive_count <- length(intersect(unlist(corpus_word), unlist(positive_lexicon)))
    
    #NEGATIVE WORD COUNT IN THE REVIEW
    negative_count <- length(intersect(unlist(corpus_word), unlist(negative_lexicon)))
    
    #TOTAL NUMBER OF ALL POSITIVE AND NEGATIVE WORDS 
    total_positive_count <- total_positive_count + positive_count
    total_positive_count
    total_negative_count <- total_negative_count + negative_count
    total_positive_count
    
  }
  #CALCULATING OVERALL PERCENTAGE OF POSITIVE AND NEGATIVE WORD OF ALL THE REVIEWS
  total_count<- total_positive_count + total_negative_count
  total_positive_percentage<- (total_positive_count/total_count)*100
  total_negative_percentage<- (total_negative_count/total_count)*100
  
  #CREATE A DATAFRAME WITH ALL THE POSITIVE AND NEGATIVE REVIEWS 
  df<-data.frame(Review_type= c("Positive", "Negative"),
                 Count=c(total_positive_percentage, total_negative_percentage))
  print(df)
  
  Overall_positive_percentage<- paste("Percentage of positive Reviews:", 
                                      round(Overall_positive_percentage,2),"%")
  return(Overall_positive_percentage)
  
}

sentiment(stem_corpus_SSWR)
sentiment(stem_corpus_RVCB)
sentiment(stem_corpus_LBC)
sentiment(stem_corpus_TPCND)
sentiment(stem_corpus_DPK)
sentiment(stem_corpus_BB)
sentiment(stem_corpus_RTC)
sentiment(stem_corpus_TIR)
sentiment(stem_corpus_BK)
sentiment(stem_corpus_WCDBCP)
sentiment(stem_corpus_OSOT)
sentiment(stem_corpus_LP)
sentiment(stem_corpus_BM)
sentiment(stem_corpus_MIR)
sentiment(stem_corpus_EBB)
sentiment(stem_corpus_S9)
sentiment(stem_corpus_MINT)
sentiment(stem_corpus_KR)
sentiment(stem_corpus_ER)
sentiment(stem_corpus_SB)
sentiment(stem_corpus_HHBR)
sentiment(stem_corpus_MM)
sentiment(stem_corpus_KeR)
sentiment(stem_corpus_SR)
sentiment(stem_corpus_KOKO)
sentiment(stem_corpus_KCSTC)
sentiment(stem_corpus_DIRBP)
sentiment(stem_corpus_HRCP)
sentiment(stem_corpus_BamK)
sentiment(stem_corpus_TPC)

