% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dendextend.R
\name{as_hclust_fixed}
\alias{as_hclust_fixed}
\title{Convert dendrogram Objects to Class hclust}
\usage{
as_hclust_fixed(x, hc, ...)
}
\arguments{
\item{x}{any object which has an as.hclust method. 
(mostly used for dendrogram)}

\item{hc}{an old hclust object from which to re-use 
the call/method/dist.method values}

\item{...}{passed to as.hclust}
}
\value{
An hclust object (from a dendrogram) with the original hclust 
call/method/dist.method values
}
\description{
Convert dendrogram Objects to Class hclust while preserving 
the call/method/dist.method values of the original hclust object (hc)
}
\examples{
hc <- hclust(dist(USArrests[1:3,]), "ave")
dend <- as.dendrogram(hc)

as.hclust(dend)
as_hclust_fixed(dend, hc)
}
\seealso{
\link{as.hclust}
}
