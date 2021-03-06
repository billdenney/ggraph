utils::globalVariables(c(
  'angle',
  'center_size',
  'circular',
  'con.id',
  'direction',
  'edge.id',
  'end',
  'from',
  'height',
  'r',
  'r0',
  'section',
  'start',
  'to',
  'width',
  'x',
  'xend',
  'y',
  'yend'
))

#' @rdname ggraph-extensions
#' @format NULL
#' @usage NULL
#' @export
StatFilter <- ggproto('StatFilter', StatIdentity,
  setup_data = function(data, params) {
    if (any(names(data) == 'filter')) {
      if (!is.logical(data$filter)) {
        stop('filter must be logical')
      }
      data <- data[data$filter, names(data) != 'filter']
    }
    data
  },
  default_aes = aes(filter = TRUE)
)

aes_intersect <- function(aes1, aes2) {
  structure(
    c(as.list(aes1), aes2[!names(aes2) %in% names(aes1)]),
    class = 'uneval'
  )
}

data_type <- function(data) {
  type <- attr(data, 'type_ggraph')
  if (is.null(type)) {
    if (inherits(data, 'layout_ggraph')) {
      return('node_ggraph')
    } else {
      return('other')
    }
  }
  type
}
