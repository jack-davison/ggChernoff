#' Chernoff faces in ggplot2
#'
#' The Chernoff geom is used to create data visualisations in the shape of
#' human-like faces. By mapping to the relevant aesthetics, faces can appear to
#' vary in happiness, anger, size, colour and so on.
#'
#' @inheritParams ggplot2::geom_point
#'
#' @section Aesthetics:
#'
#'   `geom_chernoff` understands the following aesthetics (required aesthetics
#'   are in bold):
#'
#'    - **`x`**
#'    - **`y`**
#'    - `colour`
#'    - `fill`
#'    - `size`
#'    - `linewidth`
#'
#'   The following aesthetics are unique to `geom_chernoff`:
#'
#'    - `smile`
#'    - `brow`
#'    - `nose`
#'    - `eyes`
#'
#'   For details, see [chernoffGrob()].
#'
#' @examples
#' library(ggplot2)
#' ggplot(
#'   iris,
#'   aes(Sepal.Width, Sepal.Length, smile = Petal.Length, fill = Species)
#' ) +
#'   geom_chernoff()
#'
#' ggplot(data.frame(
#'   x = 1:4,
#'   y = c(3:1, 2.5),
#'   z = factor(1:4),
#'   w = rnorm(4),
#'   n = c(rep(FALSE, 3), TRUE)
#' )) +
#'   aes(x, y, fill = z, size = x, nose = n, smile = w) +
#'   geom_chernoff()
#'
#' @references
#'
#' Chernoff, H. (1973). The use of faces to represent points in
#' *k*-dimensional space graphically.
#' *Journal of the American Statistical Association, 68*(342), 361–368.
#'
#' @seealso [chernoffGrob()]
#'
#' @return A [ggplot2::Geom()] layer object for use with `ggplot2`.
#'
#' @import ggplot2
#' @export
geom_chernoff <- function(
    mapping = NULL,
    data = NULL,
    stat = "identity",
    position = "identity",
    na.rm = FALSE,
    show.legend = NA,
    inherit.aes = TRUE,
    ...
) {
  layer(
    geom = GeomChernoff,
    mapping = mapping,
    data = data,
    stat = stat,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

#' @rdname geom_chernoff
#' @format NULL
#' @usage NULL
#' @export
GeomChernoff <- ggproto(
  "GeomChernoff",
  ggplot2::Geom,
  required_aes = c("x", "y"),
  default_aes = aes(
    colour = from_theme(colour %||% ink),
    fill = from_theme(fill %||% NA),
    size = 4,
    alpha = NA,
    linewidth = from_theme(borderwidth),
    smile = 1,
    brow = NA,
    nose = FALSE,
    eyes = 1
  ),
  draw_panel = function(data, panel_params, coord) {
    coords <- coord$transform(data, panel_params)
    gl <- grobTree()
    for (i in seq_along(coords$x)) {
      # Filthy hack: draw one whole face at a time
      # so overlapping faces are rendered correctly.
      gl <- addGrob(
        gl,
        chernoffGrob(
          coords$x[i],
          coords$y[i],
          coords$size[i],
          coords$colour[i],
          coords$fill[i],
          coords$alpha[i],
          coords$linewidth[i],
          coords$smile[i],
          coords$brow[i],
          coords$nose[i],
          coords$eyes[i]
        )
      )
    }
    return(gl)
  },
  draw_key = function(data, params, size) {
    chernoffGrob(
      x = 0.5,
      y = 0.5,
      data$size,
      data$colour,
      data$fill,
      data$alpha,
      data$linewidth,
      data$smile,
      data$brow,
      data$nose,
      data$eyes
    )
  }
)
