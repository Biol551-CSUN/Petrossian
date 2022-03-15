#More Q&A - https://github.com/dkahle/ggmap/issues/51

#Get the latest Install
if(!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("dkahle/ggmap", ref = "tidyup", force=TRUE)

#Load the library
library("ggmap")

#Set your API Key
ggmap::register_google(key = "YOUR KEY HERE")

#Notes: If you get still have a failure then I suggest to restart R and run the library and register google commands again.