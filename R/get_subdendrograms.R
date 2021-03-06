#' @title Extract a list of \emph{k} subdendrograms from a given dendrogram
#' object
#' @export
#' @description
#' Extracts a list of subdendrogram structures based on the cutree \code{\link{cutree.dendrogram}} function
#' from a given dendrogram object. It can be useful in case of more exact visual 
#' investigation of clustering results.
#' @param dend a dendrogram object 
#' @param k the number of subdendrograms that should be extracted
#' @param ... parameters that should be passed to the cutree
#' \code{\link{cutree.dendrogram}}
#' @return 
#' A list of \emph{k} subdendrograms, based on the cutree
#' \code{\link{cutree.dendrogram}} clustering
#' clusters.
#' @examples
#' 
#' \dontrun{
#' # define dendrogram object to play with:
#' dend <- iris[,-5] %>% dist %>% hclust %>% as.dendrogram %>%  set("labels_to_character") %>% color_branches(k=5)
#' dend.list <- get.subdendrograms(dend, 5)
#'
#' # Plotting the result
#' par(mfrow = c(2,3))
#' plot(dend, main = "Original dendrogram")
#' sapply(ll, plot)
#' }
#' 

get.subdendrograms <- function(dend, k, ...) {
    clusters <- cutree(dend, k, ...)
    dend.list <- lapply(unique(clusters), function(cluster.id){
       find.dendrogram(dend, which(clusters == cluster.id))
    })  
    class(dend.list) <- "dendlist"
    dend.list
}

#' @title Search for the subdendrogram structure composed of indicated labels
#' @export
#' @description
#' Given a dendrogram object, the function performs a recursive DFS algorithm to determine
#' the subdendrogram which is composed of all indicated labels. The labels
#' which should compose the subdendrogram are marked as TRUE in the logical
#' vector of length \code{nleaves(dend)} 
#' @param dend a dendrogram object 
#' @param selected.labels logical vector with TRUE values at positions of
#' members which should be included in the resulting subdendrogram
#' @return 
#' A subdendrogram composed of only members indicated in the given logical
#' vector
#' clusters.
#' @examples
#' 
#' \dontrun{
#' # define dendrogram object to play with:
#' dend <- iris[,-5] %>% dist %>% hclust %>% as.dendrogram %>%  set("labels_to_character") %>% color_branches(k=5)
#' first.subdend.only <- cutree(dend, 4) == 1
#' sub.dend <- find.dendrogram(dend, first.subdend.only)
#' # Plotting the result
#' par(mfrow=c(1,2))
#' plot(dend, main = "Original dendrogram")
#' plot(sub.dend, main = "First subdendrogram")
#' }
#' 

find.dendrogram<-function(dendr, selected.labels){
    if(all(unlist(dendr) %in% selected.labels))
        return(dendr)
    
    if(any(unlist(dendr[[1]]) %in% selected.labels))
        return(find.dendrogram(dendr[[1]], selected.labels))
    else 
        return(find.dendrogram(dendr[[2]], selected.labels))
}


