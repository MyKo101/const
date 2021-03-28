#' Create Constant
#'
#' Assign a value to a constant. Once a constant has been
#' created, it cannot be re-assigned.
#'
#' @usage
#' x := value
#'
#' @param x
#' a constant name
#'
#' @param value
#' a value to be assigned to x.
#'
#' @export

`:=` <- function(x,value){
  x_str <- deparse1(substitute(x))
  force(value)
  if(exists(x_str,envir=parent.frame(),inherits = FALSE) && bindingIsLocked(x_str,parent.frame())){
    stop(paste0(x_str," := ",deparse1(substitute(value)),"\nCannot re-assign constant."),call.=FALSE)
  } else invisible(const(x_str,value,parent.frame()))
}

const <- function(name,value,env){
  assign(name,structure(value,class=c("const",class(value))),env)
  lockBinding(name,env)
  value
}

#' @export
print.const <- function(x,...){
  cat("\033[33m<const>\n\033[39m")
  x2 <- x
  class(x2) <- class(x)[-which(class(x) == "const")]
  print(x2)
}

