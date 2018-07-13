library("rjson")

setwd("C:\\Users\\Vato\\Desktop\\Kitsak-BGP data")
res <- fromJSON(file="formatted.json")

yapply <- function(items) {
    years <- names(items)
    response <- list()
    for (i in years) {
        val <- items[[i]]
        response[[i]] <- val[["total"]] / 1000000
    }
    return(response)
}

att_data <- yapply(res[["AT&T"]])
iij_data <- yapply(res[["IIJ"]])
tinet_data <- yapply(res[["TINET"]])
ntt_data <- yapply(res[["NTT"]])

plot(names(att_data), att_data, type="o", col="red", 
	xlab="years", ylab="Hits (Millions)")
lines(names(iij_data), iij_data, type="o", col="blue")
lines(names(tinet_data), tinet_data, type="o", col="green")
lines(names(ntt_data), ntt_data, type="o", col="black")
