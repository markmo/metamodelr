library(pmml)
library(XML)
library(RCurl)

url <- "$IIS_SERVICE_URL/pmml"

#' Export Model Metadata to the InfoSphere Information Governance Catalog as PMML
#' 
#' @param model The predictive model
#' @param name The name of the model
#' @param data The Dataframe for the model
#' @export
exportMetadata <- function(model, name, data) {
  pmml <- pmml(model, name=name, data=data)
  xml = saveXML(pmml)
  header=c(Connection="close", 'Content-Type'="text/plain; charset=UTF-8", 'Content-Length'=nchar(xml))
  getURL(url=url, postfields=xml, httpheader=header, verbose=F)
}

#' Delete Model Metadata from the InfoSphere Information Governance Catalog for the given App
#' 
#' @param name The name of the app
#' @export
deleteMetadata <- function(name="R") {
  httpDELETE(url=paste(url, "/", name, sep=""))
}

#' Fetch the glossary of terms
#' 
#' @export
glossary <- function() {
  content <- getURL("http://119.81.7.68:9000/glossary")
  read.csv(text=content)
}