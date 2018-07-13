library("rjson")
library("zoom")

providers <- c("AT&T", "IIJ", "NTT", "TINET")
year = "2007"

setwd("C:\\Users\\Vato\\Desktop\\Kitsak-BGP data")
res <- fromJSON(file="byweeks.json")

yapply <- function(items) {
    years <- names(items)
    response <- list()
    for (year in years) {
        year_list <- items[[year]][["list"]]
        response[[year]] <- list()
	  index <- 1
        for (day in year_list) {
            val = day[["total"]]
	      response[[year]][[index]] <- val / 10000
		index <- index + 1

        }
    }
    return(response)
}

att_data <- yapply(res[["AT&T"]])
iij_data <- yapply(res[["IIJ"]])
tinet_data <- yapply(res[["TINET"]])
ntt_data <- yapply(res[["NTT"]])
years = names(att_data)

plot(1:length(att_data[[year]]), att_data[[year]], type="o", col="red", xlab=paste("Week numbers in ", year), ylab="Hits (Ten Thousands)")
lines(1:length(iij_data[[year]]), iij_data[[year]], type="o", col="blue")
lines(1:length(tinet_data[[year]]), tinet_data[[year]], type="o", col="green")
lines(1:length(ntt_data[[year]]), ntt_data[[year]], type="o", col="black")

legend("topleft", legend=c("AT&T", "IIJ", "TINET", "NTT"), col=c("red", "blue", "green", "black"), lty=1)