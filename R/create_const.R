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
  x_str <- deparse(substitute(x))
  force(value)
  if(exists(x_str,envir=parent.frame(),inherits = FALSE) && bindingIsLocked(x_str,parent.frame())){
    stop(paste0(x_str," := ",deparse(substitute(value)),"\nCannot re-assign constant."),call.=FALSE)
  } else invisible(const(x_str,value,parent.frame()))
}

const <- function(name,value,env){
  assign(name,structure(value,class=c("const",class(value))),env)
  lockBinding(name,env)
  value
}

deconst <- function(x){
  class(x) <- class(x)[class(x) != "const"]
  x
}

#' @export
#' @method print const
print.const <- function(x,...){
  cat("\033[33m<const>\n\033[39m")
  print(deconst(x))
}

#' @export
#' @method Ops const
Ops.const <- function(e1,e2){
  if(missing(e2)) eval.parent(call(.Generic,deconst(e1))) else
    eval.parent(call(.Generic,deconst(e1),deconst(e2)))
}
